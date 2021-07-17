package com.teampress.controller.play;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.financial.IncomeGroup;
import com.teampress.database.model.system.Organization;
import com.teampress.database.service.financial.IncomeGroupConnectionService;
import com.teampress.database.service.financial.IncomeGroupService;
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
