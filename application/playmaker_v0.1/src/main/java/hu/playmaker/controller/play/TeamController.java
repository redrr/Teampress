package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.common.templates.TeamPlayerTmp;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.service.databank.PlayerDataService;
import hu.playmaker.database.service.system.LookupCodeService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.database.service.trainingplan.ExerciseService;
import hu.playmaker.handler.SessionHandler;
import org.apache.commons.collections4.map.LinkedMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/statistics/team")
public class TeamController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private PlayerDataService playerDataService;

    public TeamController(UserService userService, UserOrganizationService userOrganizationService, PlayerDataService playerDataService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.playerDataService = playerDataService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.CAREER_TABLE)) {
            ModelAndView view = new ModelAndView("play/Team");
            view.addObject("teams", getTeams());
            return view;
        }
        return new ModelAndView("403");
    }

    private LinkedMap<LookupCode, List<TeamPlayerTmp>> getTeams() {
        LinkedMap<LookupCode, List<TeamPlayerTmp>> result = new LinkedMap<>();
        User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
        List<UserOrganization> userOrganizations = userOrganizationService.getOrgListByUser(currentUser);
        for(UserOrganization userOrganization : userOrganizations) {
            LookupCode team = userOrganization.getType();
            List<TeamPlayerTmp> players = new ArrayList<>();
            userOrganizationService.getUsersByOrgIfPlayer(userOrganization.getOrganization(), team).forEach(userOrg -> {
                if(playerDataService.existsByCodeAndUser(userOrg.getUser()))
                    players.add(new TeamPlayerTmp()
                        .setPlayer(userOrg.getUser())
                        .setData(playerDataService.getPlayerDataByCode(userOrg.getUser())));
            });
            result.put(team, players);
        }
        return result;
    }


    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del() {
        if(hasPermission(Permissions.EXERCISE_CREATE)) {
            return "asd";
        }
        return "";
    }
}
