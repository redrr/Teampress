package com.teampress.controller.play;

import com.teampress.common.enums.Permissions;
import com.teampress.common.factory.mlsz.MLSZParser;
import com.teampress.controller.BaseController;
import com.teampress.database.model.databank.PlayerData;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.service.system.UserOrganizationService;
import com.teampress.database.service.system.UserService;
import com.teampress.handler.SessionHandler;
import org.apache.commons.collections4.map.LinkedMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Controller
@RequestMapping("/statistics/team")
public class TeamController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;

    public TeamController(UserService userService, UserOrganizationService userOrganizationService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
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

    private LinkedMap<LookupCode, LinkedMap<PlayerData, List<PlayerData>>> getTeams() {
        LinkedMap<LookupCode, LinkedMap<PlayerData, List<PlayerData>>> result = new LinkedMap<>();
        //Get current data
        User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
        List<UserOrganization> currentUser_UserOrganizations = userOrganizationService.getOrgListByUser(currentUser);
        for(UserOrganization userOrganization : currentUser_UserOrganizations) {
            LookupCode team = userOrganization.getType();
            LinkedMap<PlayerData, List<PlayerData>> teamDatas = new LinkedMap<>();
            List<UserOrganization> allUserOfTeam = userOrganizationService.getUsersByOrgIfPlayer(userOrganization.getOrganization(), team);
            List<PlayerData> allPlayerData = new ArrayList<>();
            PlayerData maxData = new PlayerData();
            for (UserOrganization uOrg : allUserOfTeam) {
                PlayerData playerData = new MLSZParser(uOrg.getUser().getUrl()).getPlayerData();
                playerData.setUser(uOrg.getUser());
                allPlayerData.add(playerData);
                //find max
                if(Objects.isNull(maxData.getCsere()) || maxData.getCsere() < playerData.getCsere())
                    maxData.setCsere(playerData.getCsere());
                if(Objects.isNull(maxData.getGolok()) || maxData.getGolok() < playerData.getGolok())
                    maxData.setGolok(playerData.getGolok());
                if(Objects.isNull(maxData.getKezdo()) || maxData.getKezdo() < playerData.getKezdo())
                    maxData.setKezdo(playerData.getKezdo());
                if(Objects.isNull(maxData.getKispad()) || maxData.getKispad() < playerData.getKispad())
                    maxData.setKispad(playerData.getKispad());
                if(Objects.isNull(maxData.getMeccsek()) || maxData.getMeccsek() < playerData.getMeccsek())
                    maxData.setMeccsek(playerData.getMeccsek());
                if(Objects.isNull(maxData.getOnGolok()) || maxData.getOnGolok() < playerData.getOnGolok())
                    maxData.setOnGolok(playerData.getOnGolok());
                if(Objects.isNull(maxData.getPirosLap()) || maxData.getPirosLap() < playerData.getPirosLap())
                    maxData.setPirosLap(playerData.getPirosLap());
                if(Objects.isNull(maxData.getSargaLap()) || maxData.getSargaLap() < playerData.getSargaLap())
                    maxData.setSargaLap(playerData.getSargaLap());
            }
            teamDatas.put(maxData, allPlayerData);
            result.put(team, teamDatas);
        }
        return result;
    }
}