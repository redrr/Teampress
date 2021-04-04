package com.teampress.controller.play;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.financial.Income;
import com.teampress.database.model.financial.IncomeGroupConnection;
import com.teampress.database.model.financial.PaymentRequest;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.service.financial.IncomeGroupConnectionService;
import com.teampress.database.service.financial.IncomeService;
import com.teampress.database.service.financial.PaymentRequestService;
import com.teampress.database.service.system.UserOrganizationService;
import com.teampress.database.service.system.UserService;
import com.teampress.handler.SessionHandler;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.util.Objects;
import java.util.UUID;

@Controller
@RequestMapping("/payment")
public class PaymentController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserOrganizationService userOrganizationService;

    @Autowired
    private PaymentRequestService paymentRequestService;

    @Autowired
    private IncomeService incomeService;

    @Autowired
    private IncomeGroupConnectionService connectionService;

    //@Value("${STRIPE_PUBLIC_KEY}")
    private String stripePublicKey;

    //@Value("${STRIPE_SECRET_KEY}")
    String secretKey = "";

    @PostConstruct
    public void init() {
        Stripe.apiKey = secretKey;
    }

    @RequestMapping("")
    public ModelAndView checkout() {
        if(hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
            ModelAndView view = new ModelAndView("play/Payments");
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(user).getOrganization();
            Stripe.apiKey = organization.getStripePrivateKey();
            view.addObject("stripePublicKey", organization.getStripePublicKey());
            view.addObject("info", "");
            view.addObject("records", paymentRequestService.findByOrg(organization, user));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(value = "/pay", method = RequestMethod.POST)
    @ResponseBody
    public String charge(@RequestParam("id") String id, HttpServletRequest httpServletRequest) throws StripeException, JSONException {
        if(hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
            PaymentRequest request = paymentRequestService.find(Integer.valueOf(id));
            String baseURL = httpServletRequest.getRequestURL().delete((httpServletRequest.getRequestURL().toString().length()-httpServletRequest.getRequestURI().length()), httpServletRequest.getRequestURL().toString().length()).toString();
            SessionCreateParams params =
                SessionCreateParams.builder()
                    .addPaymentMethodType(SessionCreateParams.PaymentMethodType.CARD)
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .setSuccessUrl(baseURL + "/payment/success/" + id)
                    .setCancelUrl(baseURL + "/payment/cancel")
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
            String uuid = UUID.randomUUID().toString();
            Income income = new Income();
            income.setAccept(true);
            income.setIncome(true);
            income.setName(request.getName());
            income.setOrganization(request.getOrganization());
            income.setPrize(request.getAmount());
            income.setUuid(uuid);
            incomeService.mergeFlush(income);
            if (Objects.nonNull(request.getGroup())) {
                IncomeGroupConnection connection = new IncomeGroupConnection();
                connection.setIncome(incomeService.findByUUID(uuid));
                connection.setGroup(request.getGroup());
                connection.setOrganization(request.getOrganization());
                connectionService.mergeFlush(connection);
            }
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
