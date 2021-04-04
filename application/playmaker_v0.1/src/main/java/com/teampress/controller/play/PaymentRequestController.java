package com.teampress.controller.play;

import com.teampress.common.enums.LGroups;
import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.financial.PaymentRequest;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.service.financial.IncomeGroupService;
import com.teampress.database.service.financial.PaymentRequestService;
import com.teampress.database.service.system.LookupCodeService;
import com.teampress.database.service.system.UserOrganizationService;
import com.teampress.database.service.system.UserService;
import com.teampress.form.AnnualPaymentForm;
import com.teampress.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import static java.util.Objects.isNull;

@Controller
@RequestMapping("/financial/paymentrequest")
public class PaymentRequestController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private LookupCodeService lookupCodeService;
    private IncomeGroupService incomeGroupService;
    private PaymentRequestService paymentRequestService;

    public PaymentRequestController(UserService userService, UserOrganizationService userOrganizationService, LookupCodeService lookupCodeService, IncomeGroupService incomeGroupService, PaymentRequestService paymentRequestService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.lookupCodeService = lookupCodeService;
        this.incomeGroupService = incomeGroupService;
        this.paymentRequestService = paymentRequestService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.COST_CREATE)) {
            ModelAndView view = new ModelAndView("play/PaymentRequest", "modifyrequest", new AnnualPaymentForm());
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            view.addObject("types", lookupCodeService.findAllLookupByLgroup(LGroups.TEAM_TYPE.name()));
            view.addObject("group", incomeGroupService.findAll(organization));
            view.addObject("datas", paymentRequestService.collectByUUID());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView doSubmit(@Valid @ModelAttribute("modifyrequest") AnnualPaymentForm form, BindingResult result) {
        if(hasPermission(Permissions.COST_CREATE)){
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            List<User> players = userOrganizationService.getOrgListByTeam(organization, lookupCodeService.find(form.getTypeId())).stream().map(UserOrganization::getUser).collect(Collectors.toList());
            String uuid = UUID.randomUUID().toString();
            for (User player : players) {
                PaymentRequest payment = (isNull(form.getId())) ? new PaymentRequest() : paymentRequestService.find(form.getId());
                payment.setOrganization(organization);
                payment.setUser(player);
                payment.setUuid(uuid);
                payment.setGroup(incomeGroupService.find(form.getGroupId()));
                payment.setName(form.getName());
                payment.setAmount(form.getAmount());
                paymentRequestService.mergeFlush(payment);
            }
        }
        return show();
    }
}
