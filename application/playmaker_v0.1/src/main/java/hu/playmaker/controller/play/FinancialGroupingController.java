package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.financial.Income;
import hu.playmaker.database.model.financial.IncomeGroupConnection;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.financial.IncomeGroupConnectionService;
import hu.playmaker.database.service.financial.IncomeGroupService;
import hu.playmaker.database.service.financial.IncomeService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/financial/grouping")
public class FinancialGroupingController extends BaseController {

    private IncomeGroupService incomeGroupService;
    private IncomeService incomeService;
    private IncomeGroupConnectionService incomeGroupConnectionService;
    private UserOrganizationService userOrganizationService;
    private UserService userService;

    public FinancialGroupingController(IncomeGroupService incomeGroupService, IncomeService incomeService, IncomeGroupConnectionService incomeGroupConnectionService, UserOrganizationService userOrganizationService, UserService userService) {
        this.incomeGroupService = incomeGroupService;
        this.incomeService = incomeService;
        this.incomeGroupConnectionService = incomeGroupConnectionService;
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
    }

    @RequestMapping("")
    public ModelAndView showGroups() {
        if(hasPermission(Permissions.GROUP_COSTS)) {
            ModelAndView view = new ModelAndView("play/FinancialGrouping");
            String userName = SessionHandler.getUsernameFromCurrentSession();
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(userName)).getOrganization();
            view.addObject("groups", incomeGroupService.findAllCreatedBy(userName));
            view.addObject("incomes", usedIncome(incomeService.findByOrgAndAccept(organization, true)));
            view.addObject("table", incomeGroupConnectionService.findAllCreatedBy(userName));
            return view;
        }
        return new ModelAndView("403");
    }

    private ArrayList<Income> usedIncome(List<Income> incomes){
        return incomes.stream().filter(income -> !incomeGroupConnectionService.exist(income)).collect(Collectors.toCollection(ArrayList::new));
    }

    @RequestMapping(method = RequestMethod.POST, value = "/create")
    @ResponseBody
    public String grpIncome(@RequestParam("id") String id, @RequestParam("group") String group, @RequestParam("item") String income){
        if(hasPermission(Permissions.GROUP_COSTS)){
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            IncomeGroupConnection connection;
            if(!id.equals("") && incomeGroupConnectionService.exist(Integer.parseInt(id))){
                connection = incomeGroupConnectionService.find(Integer.parseInt(id));
            } else {
                connection = new IncomeGroupConnection();
            }
            connection.setOrganization(organization);
            connection.setGroup(incomeGroupService.find(Integer.parseInt(group)));
            connection.setIncome(incomeService.find(Integer.parseInt(income)));
            incomeGroupConnectionService.mergeFlush(connection);
        }
        return "redirect:/financial/grouping";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    @ResponseBody
    public String grpIncomedel(@RequestParam("id") String id){
        if(hasPermission(Permissions.GROUP_COSTS)){
            IncomeGroupConnection connection;
            if(!id.equals("") && incomeGroupConnectionService.exist(Integer.parseInt(id))) {
                connection = incomeGroupConnectionService.find(Integer.parseInt(id));
                incomeGroupConnectionService.delete(connection);
            }
        }
        return "redirect:/financial/grouping";
    }
}
