package hu.playmaker.controller.play;

import com.stripe.exception.StripeException;
import com.stripe.model.Charge;
import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.financial.PaymentRequestService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.ChargeRequest;
import hu.playmaker.handler.PaymentHandler;
import hu.playmaker.handler.SessionHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/payment")
public class PaymentController extends BaseController {

    @Value("${STRIPE_PUBLIC_KEY}")
    private String stripePublicKey;

    @Autowired
    private PaymentHandler paymentsService;

    @Autowired
    private UserService userService;

    @Autowired
    private UserOrganizationService userOrganizationService;

    @Autowired
    private PaymentRequestService paymentRequestService;

    @RequestMapping("/")
    public ModelAndView checkout() {
        if(hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
            ModelAndView view = new ModelAndView("play/Payments");
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(user).getOrganization();
            view.addObject("stripePublicKey", stripePublicKey);
            view.addObject("currency", ChargeRequest.Currency.HUF);
            view.addObject("records", paymentRequestService.findByOrg(organization, user));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(value = "/pay", method = RequestMethod.POST)
    public ModelAndView charge(ChargeRequest chargeRequest) throws StripeException {
        if(hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
            chargeRequest.setDescription("Example charge");
            chargeRequest.setCurrency(ChargeRequest.Currency.HUF);
            Charge charge = paymentsService.charge(chargeRequest);
            return checkout();
        }
        return new ModelAndView("403");
    }
}
