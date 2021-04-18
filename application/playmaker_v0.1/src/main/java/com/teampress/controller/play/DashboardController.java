package com.teampress.controller.play;

import com.teampress.common.enums.Permissions;
import com.teampress.common.template.DashboardUser;
import com.teampress.controller.BaseController;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.service.system.UserOrganizationService;
import com.teampress.database.service.system.UserService;
import com.teampress.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/dashboard")
public class DashboardController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;

    public DashboardController(UserService userService, UserOrganizationService userOrganizationService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
    }

    @RequestMapping()
    public ModelAndView show() {
        if (hasPermission(Permissions.MY_CLUB) || hasPermission(Permissions.MY_TEAM)) {
            ModelAndView view = new ModelAndView("play/Dashboard");
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
            view.addObject("players", getAllPlayer(organization));
            if (hasPermission(Permissions.MY_CLUB)) {
                view.addObject("trainers", getAllTrainer(organization));
            }
            return view;
        }
        return new ModelAndView("403");
    }

    private List<DashboardUser> getAllTrainer(Organization organization) {
        HashSet<User> trainers = new HashSet<>();
        List<DashboardUser> users = new ArrayList<>();
        for (UserOrganization userOrganization : userOrganizationService.getOrgListByOrg(organization)) {
            if (userOrganization.getUser().isTrainer()) {
                trainers.add(userOrganization.getUser());
            }
        }
        for (User user : trainers) {
            DashboardUser dashboardUser = new DashboardUser();
            dashboardUser.setOrganization(organization);
            dashboardUser.setUser(user);
            dashboardUser.setTeams(userOrganizationService.getOrgListByUser(user).stream().map(UserOrganization::getType).collect(Collectors.toList()));
            users.add(dashboardUser);
        }
        return users;
    }

    private List<DashboardUser> getAllPlayer(Organization organization) {
        HashSet<User> trainers = new HashSet<>();
        List<DashboardUser> users = new ArrayList<>();
        for (UserOrganization userOrganization : userOrganizationService.getOrgListByOrg(organization)) {
            if (userOrganization.getUser().isPlayer()) {
                trainers.add(userOrganization.getUser());
            }
        }
        for (User user : trainers) {
            DashboardUser dashboardUser = new DashboardUser();
            dashboardUser.setOrganization(organization);
            dashboardUser.setUser(user);
            dashboardUser.setTeams(userOrganizationService.getOrgListByUser(user).stream().map(UserOrganization::getType).collect(Collectors.toList()));
            users.add(dashboardUser);
        }
        return users;
    }

    @RequestMapping(value = "/manageuser", method = RequestMethod.POST)
    @ResponseBody
    public void manageUser(@RequestParam String username, @RequestParam Boolean status) {
        if (hasPermission(Permissions.MY_CLUB) || hasPermission(Permissions.MY_TEAM)) {
            if (Objects.nonNull(username) && Objects.nonNull(status)) {
                User user = userService.findEnabledUserByUsername(username);
                user.setEnabled(status);
                userService.mergeFlush(user);
            }
        }
    }
}
