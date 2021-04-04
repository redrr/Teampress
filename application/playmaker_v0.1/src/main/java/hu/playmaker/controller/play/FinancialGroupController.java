package hu.playmaker.controller.play;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.financial.IncomeGroup;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.financial.IncomeGroupConnectionService;
import hu.playmaker.database.service.financial.IncomeGroupService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/financial/group")
public class FinancialGroupController extends BaseController {

    private IncomeGroupService incomeGroupService;
    private IncomeGroupConnectionService incomeGroupConnectionService;
    private UserService userService;
    private UserOrganizationService userOrganizationService;

    public FinancialGroupController(IncomeGroupService incomeGroupService, IncomeGroupConnectionService incomeGroupConnectionService, UserService userService, UserOrganizationService userOrganizationService) {
        this.incomeGroupService = incomeGroupService;
        this.incomeGroupConnectionService = incomeGroupConnectionService;
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
    }

    @RequestMapping("")
    public ModelAndView showGroup() {
        if(hasPermission(Permissions.GROUP_COSTS)) {
            ModelAndView view = new ModelAndView("play/FinancialGroup");
            String username = SessionHandler.getUsernameFromCurrentSession();
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(username)).getOrganization();
            view.addObject("table", incomeGroupService.findAllCreatedBy(username, organization));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST, value = "/create")
    @ResponseBody
    public String createGroup(@RequestParam("id") String id,@RequestParam("name") String name, @RequestParam("desc") String description){
        if(hasPermission(Permissions.GROUP_COSTS) && !name.trim().equals("")) {
            IncomeGroup group;
            if(!id.equals("") && incomeGroupService.exist(Integer.parseInt(id))){
                group = incomeGroupService.find(Integer.parseInt(id));
            } else {
                group = new IncomeGroup();
                Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
                group.setOrganization(organization);
                group.setDeleted(false);
            }
            group.setName(name);
            group.setDescription(description);
            incomeGroupService.mergeFlush(group);
        }
        return "redirect:/financial/group";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    @ResponseBody
    public String delGroup(@RequestParam("id") String id){
        if(hasPermission(Permissions.GROUP_COSTS)){
            if(!id.equals("") && incomeGroupService.exist(Integer.parseInt(id))) {
                IncomeGroup group = incomeGroupService.find(Integer.parseInt(id));
                if(!incomeGroupConnectionService.exist(group)){
                    group.setDeleted(true);
                    incomeGroupService.mergeFlush(group);
                } else {
                    return doAlert("danger", "A csoport nem törölhető, mivel még tartalmaz elemet!").toString();
                }
            }
        }
        return "";
    }
}
