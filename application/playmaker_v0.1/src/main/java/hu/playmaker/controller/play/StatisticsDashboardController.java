package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.common.factory.chartjs.*;
import hu.playmaker.common.factory.chartjs.common.enums.BorderCapStyle;
import hu.playmaker.common.factory.mlsz.MLSZParser;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.databank.*;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.service.databank.*;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.SessionHandler;
import org.apache.commons.collections4.map.LinkedMap;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/statistics/dashboard")
public class StatisticsDashboardController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;

    public StatisticsDashboardController(UserService userService, UserOrganizationService userOrganizationService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.MLSZ_STATISTICS)) {
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
            ModelAndView view = new ModelAndView("play/StatisticsDashboard");
            if (hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
                view.addObject("playerData", getPlayerData());
            }
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(value = "/points", method = RequestMethod.POST)
    @ResponseBody
    private String points(@RequestParam("liga") String ligaIn){
        JSONArray array = new JSONArray();
        MLSZParser parser = new MLSZParser("http://ada1bank.mlsz.hu/club?teamId=214928");
        String[] points = parser.getMaxMinPoints();
        array.put(points[0]);
        array.put(points[1]);
        return array.toString();
    }

    @RequestMapping(value = "/goals", method = RequestMethod.POST)
    @ResponseBody
    private String goals(@RequestParam("liga") String ligaIn){
        JSONObject object = new JSONObject();
        try {
            MLSZParser parser = new MLSZParser("http://ada1bank.mlsz.hu/club?teamId=214928");
            String[] goals = parser.getLkGoals();
            object.put("lgoals", new JSONArray().put(Integer.parseInt(goals[0])));
            object.put("kgoals", new JSONArray().put(Integer.parseInt(goals[1])));
            return object.toString();
        } catch (Exception e) {
            return "";
        }
    }

    @RequestMapping(value = "/games", method = RequestMethod.POST)
    @ResponseBody
    private String games(@RequestParam("liga") String ligaIn){
        MLSZParser parser = new MLSZParser("http://ada1bank.mlsz.hu/club?teamId=214928");
        String[] goals = parser.getEnds();
        JSONArray array = new JSONArray();
        array.put(goals[0]);
        array.put(goals[1]);
        array.put(goals[2]);
        return array.toString();
    }

    private PlayerData getPlayerData() {
        User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
        UserOrganization uOrg = userOrganizationService.getOrgByUser(currentUser);
        return new MLSZParser(uOrg.getUser().getUrl()).getPlayerData();
    }
}
