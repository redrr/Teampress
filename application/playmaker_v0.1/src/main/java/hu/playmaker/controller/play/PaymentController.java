package hu.playmaker.controller.play;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.financial.PaymentRequest;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.financial.PaymentRequestService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.SessionHandler;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.PostConstruct;

@Controller
@RequestMapping("/payment")
public class PaymentController extends BaseController {

    @Value("${STRIPE_PUBLIC_KEY}")
    private String stripePublicKey;

    @Value("${STRIPE_SECRET_KEY}")
    String secretKey;

    @PostConstruct
    public void init() {
        Stripe.apiKey = secretKey;
    }

    @Autowired
    private UserService userService;

    @Autowired
    private UserOrganizationService userOrganizationService;

    @Autowired
    private PaymentRequestService paymentRequestService;

    @RequestMapping("")
    public ModelAndView checkout() {
        if(hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
            ModelAndView view = new ModelAndView("play/Payments");
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(user).getOrganization();
            view.addObject("stripePublicKey", stripePublicKey);
            view.addObject("info", "");
            view.addObject("records", paymentRequestService.findByOrg(organization, user));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(value = "/pay", method = RequestMethod.POST)
    @ResponseBody
    public String charge(@RequestParam("id") String id) throws StripeException, JSONException {
        if(hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
            PaymentRequest request = paymentRequestService.find(Integer.valueOf(id));
            SessionCreateParams params =
                SessionCreateParams.builder()
                    .addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD)
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .setSuccessUrl("http://localhost:8080/payment/success/"+id)
                    .setCancelUrl("http://localhost:8080/payment/cancel")
                    .addLineItem(
                        SessionCreateParams.LineItem.builder()
                            .setQuantity(1L)
                            .setPriceData(
                                SessionCreateParams.LineItem.PriceData.builder()
                                    .setCurrency("huf")
                                    .setUnitAmount((long) request.getAmount()*100)
                                    .setProductData(
                                        SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                            .setName(request.getName())
                                            .build()
                                    )
                                .build()
                            )
                            .build())
                        .build();
            Session session = Session.create(params);
            return session.getId();
        }
        return "";
    }

    @RequestMapping("/success/{id}")
    public String complete(@PathVariable String id) {
        if(hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
            PaymentRequest request = paymentRequestService.find(Integer.valueOf(id));
            request.setCompleted(true);
            paymentRequestService.mergeFlush(request);
            return "redirect:/payment/success";
        }
        return "redirect:/403";
    }

    @RequestMapping("/{status}")
    public ModelAndView back(@PathVariable String status) {
        if(hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
            ModelAndView view = checkout();
            view.addObject("info", status);
            return view;
        }
        return new ModelAndView("403");
    }
}
