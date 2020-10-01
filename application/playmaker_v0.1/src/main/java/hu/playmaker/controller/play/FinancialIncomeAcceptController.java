package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.financial.Income;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.financial.IncomeGroupConnectionService;
import hu.playmaker.database.service.financial.IncomeService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/financial/accept")
public class FinancialIncomeAcceptController extends BaseController {

    private IncomeService incomeService;
    private IncomeGroupConnectionService incomeGroupConnectionService;
    private UserOrganizationService userOrganizationService;
    private UserService userService;

    public FinancialIncomeAcceptController(IncomeService incomeService, IncomeGroupConnectionService incomeGroupConnectionService, UserOrganizationService userOrganizationService, UserService userService) {
        this.incomeService = incomeService;
        this.incomeGroupConnectionService = incomeGroupConnectionService;
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
    }

    @RequestMapping("")
    public ModelAndView showAccept() {
        if(hasPermission(Permissions.COST_ACCEPT)) {
            ModelAndView view = new ModelAndView("play/FinancialAccept");
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            view.addObject("table1", incomeService.findByOrgAndNotAcceptedYet(organization));
            view.addObject("table2", incomeService.findByOrgAndAccept(organization,true));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/confirm")
    @ResponseBody
    public String accIncome(@RequestParam("id") String id){
        if(hasPermission(Permissions.COST_ACCEPT)){
            if(!id.equals("") && incomeService.exist(Integer.parseInt(id))){
                Income income = incomeService.find(Integer.parseInt(id));
                income.setAccept(true);
                incomeService.mergeFlush(income);
            }
        }
        return "redirect:/financial/accept";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/ignore")
    @ResponseBody
    public String igIncome(@RequestParam("id") String id){
        if(hasPermission(Permissions.COST_ACCEPT)){
            if(!id.equals("") && incomeService.exist(Integer.parseInt(id))){
                Income income = incomeService.find(Integer.parseInt(id));
                if(!incomeGroupConnectionService.exist(income)){
                    income.setAccept(false);
                    income.setDeleted(true);
                    incomeService.mergeFlush(income);
                } else {
                    return doAlert("danger", "A kivánt elem nem utasítható el, mivel csoportosítva van!").toString();
                }
            }
        }
        return "";
    }
}
