package com.teampress.controller.play;

import com.teampress.common.enums.LGroups;
import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.financial.AnnualPayment;
import com.teampress.database.model.system.Organization;
import com.teampress.database.service.financial.AnnualPaymentService;
import com.teampress.database.service.financial.IncomeGroupService;
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
import java.util.Objects;

import static java.util.Objects.isNull;

@Controller
@RequestMapping("/financial/annual")
public class AnnualPaymentController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private LookupCodeService lookupCodeService;
    private AnnualPaymentService annualPaymentService;
    private IncomeGroupService incomeGroupService;

    public AnnualPaymentController(UserService userService, UserOrganizationService userOrganizationService, LookupCodeService lookupCodeService, AnnualPaymentService annualPaymentService, IncomeGroupService incomeGroupService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.lookupCodeService = lookupCodeService;
        this.annualPaymentService = annualPaymentService;
        this.incomeGroupService = incomeGroupService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.ANNUAL_COST_CREATE)) {
            ModelAndView view = new ModelAndView("play/AnnualPayment", "modifyAnnual", new AnnualPaymentForm());
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            view.addObject("types", lookupCodeService.findAllLookupByLgroup(LGroups.TEAM_TYPE.name()));
            view.addObject("group", incomeGroupService.findAll(organization));
            view.addObject("datas", annualPaymentService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView doSubmit(@Valid @ModelAttribute("modifyAnnual") AnnualPaymentForm form, BindingResult result) {
        if(hasPermission(Permissions.ANNUAL_COST_CREATE)){
            AnnualPayment payment = (isNull(form.getId())) ? new AnnualPayment() : annualPaymentService.find(form.getId());
            payment.setOrganization(userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization());
            payment.setTeam(lookupCodeService.find(form.getTypeId()));
            payment.setGroup(incomeGroupService.find(form.getGroupId()));
            payment.setName(form.getName());
            payment.setAmount(form.getAmount());
            payment.setDay(form.getDay());
            annualPaymentService.mergeFlush(payment);
        }
        return show();
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(Integer id) {
        if(hasPermission(Permissions.ANNUAL_COST_CREATE) && Objects.nonNull(id) && annualPaymentService.exist(id)) {
            annualPaymentService.delete(annualPaymentService.find(id));
            annualPaymentService.flush();
        }
        return "redirect:/financial/annual";
    }
}
