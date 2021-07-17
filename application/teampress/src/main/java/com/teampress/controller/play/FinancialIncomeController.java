package com.teampress.controller.play;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.financial.Income;
import com.teampress.database.model.system.User;
import com.teampress.database.service.financial.IncomeGroupConnectionService;
import com.teampress.database.service.financial.IncomeService;
import com.teampress.database.service.system.UserOrganizationService;
import com.teampress.database.service.system.UserService;
import com.teampress.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/financial/create")
public class FinancialIncomeController extends BaseController {

    private IncomeService incomeService;
    private IncomeGroupConnectionService incomeGroupConnectionService;
    private UserOrganizationService userOrganizationService;
    private UserService userService;

    public FinancialIncomeController(IncomeService incomeService, IncomeGroupConnectionService incomeGroupConnectionService, UserOrganizationService userOrganizationService, UserService userService) {
        this.incomeService = incomeService;
        this.incomeGroupConnectionService = incomeGroupConnectionService;
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
    }

    @RequestMapping("")
    public ModelAndView showCreate() {
        if(hasPermission(Permissions.COST_CREATE)) {
            ModelAndView view = new ModelAndView("play/FinancialCreate");
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            view.addObject("table", incomeService.findByOrg(userOrganizationService.getOrgByUser(currentUser).getOrganization()));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/new")
    @ResponseBody
    public String createIncome(@RequestParam("id") String id,@RequestParam("name") String name, @RequestParam("type") String type, @RequestParam("val") String prize){
        if(hasPermission(Permissions.COST_CREATE) && !name.trim().equals("") && !type.trim().equals("") && !prize.trim().equals("")){
            Income income;
            if(!id.equals("") && incomeService.exist(Integer.parseInt(id))){
                income = incomeService.find(Integer.parseInt(id));
            } else {
                income = new Income();
                income.setDeleted(false);
            }
            income.setName(name);
            income.setIncome(type.equals("1"));
            income.setOrganization(userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization());
            income.setPrize(Integer.parseInt(prize));
            incomeService.mergeFlush(income);
        }
        return "redirect:/financial/create";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    @ResponseBody
    public String delIncome(@RequestParam("id") String id){
        if(hasPermission(Permissions.COST_CREATE)){
            if(!id.equals("") && incomeService.exist(Integer.parseInt(id))) {
                Income income = incomeService.find(Integer.parseInt(id));
                if(!incomeGroupConnectionService.exist(income)){
                    income.setDeleted(true);
                    incomeService.mergeFlush(income);
                } else {
                    return doAlert("danger", "A kívánt elem nem törölhető, mivel még csoportosítva van!").toString();
                }
            }
        }
        return "";
    }
}
