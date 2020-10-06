package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.common.factory.chartjs.Color;
import hu.playmaker.common.factory.chartjs.Data;
import hu.playmaker.common.factory.chartjs.LineChartBuilder;
import hu.playmaker.common.factory.chartjs.LineDataSet;
import hu.playmaker.common.factory.chartjs.common.enums.BorderCapStyle;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.databank.*;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.service.databank.*;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@Controller
@RequestMapping("/statistics/league")
public class StatisticsLeagueController extends BaseController {

    private UserService userService;
    private PlayerDataService playerDataService;
    private UserOrganizationService userOrganizationService;
    private TabellaService tabellaService;
    private SorsolasService sorsolasService;
    private GoalsService goalsService;
    private YellowCardService yellowCardService;
    private RedCardService redCardService;
    private LigaService ligaService;

    public StatisticsLeagueController(UserService userService, PlayerDataService playerDataService, UserOrganizationService userOrganizationService, TabellaService tabellaService, SorsolasService sorsolasService, GoalsService goalsService, YellowCardService yellowCardService, RedCardService redCardService, LigaService ligaService) {
        this.userService = userService;
        this.playerDataService = playerDataService;
        this.userOrganizationService = userOrganizationService;
        this.tabellaService = tabellaService;
        this.sorsolasService = sorsolasService;
        this.goalsService = goalsService;
        this.yellowCardService = yellowCardService;
        this.redCardService = redCardService;
        this.ligaService = ligaService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.CAREER_TABLE)) {
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
            ModelAndView view = new ModelAndView("play/StatisticsLeague");
            if(hasPermission(Permissions.CAREER_HEADER)){
                view.addObject("headerData", createHeader());
            }
            view.addObject("ligas", getPlayerLigas(currentUser));
            view.addObject("tabellas", getTabellaByLiga(getPlayerLigas(currentUser)));
            view.addObject("sorsolas" , getSorsolasByLiga(getPlayerLigas(currentUser)));
            view.addObject("golok", getGoalsByLiga(getPlayerLigas(currentUser), organization));
            view.addObject("sargak", getYellowCardsByLiga(getPlayerLigas(currentUser), organization));
            view.addObject("pirosak", getRedCardsByLiga(getPlayerLigas(currentUser), organization));
            view.addObject("org", organization);
            view.addObject("user", currentUser);
            simpleData("MEGYEI I.");
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(value = "/history", method = RequestMethod.POST)
    @ResponseBody
    private String simpleData(@RequestParam("liga") String ligaIn) {
        if (hasPermission(Permissions.PLAYERS_STAT)){
            Liga liga = ligaService.findByName(ligaIn.trim());
            int maxFord = tabellaService.getLastFordByLiga(liga);
            List<String> teams = tabellaService.getTeams(liga);
            String currentName =userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization().getName();
            LineChartBuilder chartBuilder = new LineChartBuilder();
            //Dataset template
            LineDataSet template = new LineDataSet();
            template.setBorderCapStyle(BorderCapStyle.ROUND);
            template.setBorderWidth(4);
            template.setPointRadius(2);
            template.setPointHoverRadius(4);
            template.setPointHitRadius(12);
            template.setPointHoverBorderWidth(8);
            //Create Datasets
            Data<LineDataSet> data = new Data<>();
            for(int j = 1; j < maxFord+1; j++){
                data.addLabel(j+". forduló");
            }
            for (int i = 0; i < teams.size(); i++) {
                String team = teams.get(i);
                LineDataSet dataSet = new LineDataSet(template);
                Color color;
                Color hoverColor;
                if(currentName.equals(team)) {
                    color = new Color(26, 188, 156, 0.2);
                    hoverColor = new Color(26, 188, 156, 0.8);
                } else {
                    color = new Color(44, 62, 80, 0.2);
                    hoverColor = new Color(44, 62, 80, 0.3);
                    dataSet.setBorderWidth(2);
                    dataSet.setPointHoverRadius(2);
                    dataSet.setPointHitRadius(4);
                }
                dataSet.setLabel(team);
                dataSet.setBackgroundColor(color);
                dataSet.setHoverBackgroundColor(hoverColor);
                dataSet.setBorderColor(hoverColor);
                dataSet.setHoverBorderColor(hoverColor);
                dataSet.setPointBackgroundColor(color);
                dataSet.setPointHoverBackgroundColor(color);
                dataSet.setFill(currentName.equals(team));
                dataSet.setOrder(currentName.equals(team) ? 0 : 100);
                List<Object> datas = new ArrayList<>();
                for(int j = 1; j < maxFord+1; j++){
                    Tabella tabella = tabellaService.getByTeamLigaAndFord(liga, team, j);
                    datas.add((Objects.nonNull(tabella) && Objects.nonNull(tabella.getPontszam())) ? tabella.getPontszam() : 0);
                }
                dataSet.setData(datas.toArray());
                data.addDataset(dataSet);
            }
            chartBuilder.setData(data);
            return chartBuilder.build();
        }
        return "";
    }

    //region [Region] Helper Methods
    private ArrayList<Liga> getPlayerLigas(User currentUser) {
        List<UserOrganization> userOrganization = userOrganizationService.getOrgListByUser(currentUser);
        return userOrganization.stream().collect(ArrayList::new,(liga, userOrg) -> liga.add(userOrg.getLiga()),ArrayList::addAll);
    }

    private HashMap<Integer, List<RedCard>> getRedCardsByLiga(ArrayList<Liga> playerLigas, Organization organization) {
        HashMap<Integer, List<RedCard>> result = new HashMap<>();
        for(Liga liga : playerLigas) {
            List<RedCard> data = redCardService.findByOrg(liga, organization);
            result.put(liga.getId(), data);
        }
        return result;
    }

    private HashMap<Integer, List<YellowCard>> getYellowCardsByLiga(ArrayList<Liga> playerLigas, Organization organization) {
        HashMap<Integer, List<YellowCard>> result = new HashMap<>();
        for(Liga liga : playerLigas) {
            List<YellowCard> data = yellowCardService.findByOrg(liga, organization);
            result.put(liga.getId(), data);
        }
        return result;
    }

    private HashMap<Integer, List<Goals>> getGoalsByLiga(ArrayList<Liga> playerLigas, Organization organization) {
        HashMap<Integer, List<Goals>> result = new HashMap<>();
        for(Liga liga : playerLigas) {
            List<Goals> goals = new ArrayList<>();
            List<Object[]> objects = goalsService.findLastByleagueAndClub(liga, organization);
            if(objects.size() > 0){
                objects.forEach(o -> {
                    Goals data = new Goals();
                    data.setName((String) o[0]);
                    data.setGoal((Integer) o[1]);
                    goals.add(data);
                });
            }
            goals.sort(Comparator.comparing(Goals::getGoal));
            Collections.reverse(goals);
            for (int i = 0; i < goals.size(); i++) {
                goals.get(i).setHely(i+1);
            }
            result.put(liga.getId(), goals);
        }
        return result;
    }

    private HashMap<Integer, List<Sorsolas>> getSorsolasByLiga(ArrayList<Liga> ligas) {
        HashMap<Integer, List<Sorsolas>> result = new HashMap<>();
        for(Liga liga : ligas) {
            List<Sorsolas> sorsolas = sorsolasService.getSorsolasByLiga(liga);
            result.put(liga.getId(), sorsolas);
        }
        return result;
    }

    private HashMap<Integer, List<Tabella>> getTabellaByLiga(ArrayList<Liga> ligas) {
        HashMap<Integer, List<Tabella>> result = new HashMap<>();
        for(Liga liga : ligas) {
            List<Tabella> tabella = tabellaService.getTabellaByLiga(liga);
            result.put(liga.getId(), tabella);
        }
        return result;
    }

    private HashMap<String, String> createHeader() {
        HashMap<String, String> map = new HashMap<>();
        User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());

        map.put("profilImg", "/content/profileImages/"+user.getProfilImg());
        map.put("nev", user.getName());
        map.put("szul", playerDataService.getPlayerDataByCode(user).getSzulDate());
        map.put("kor", playerDataService.getPlayerDataByCode(user).getKor().toString());
        map.put("csapat", userOrganizationService.getOrgByUser(user).getOrganization().getName());

        map.put("meccsek", playerDataService.getPlayerDataByCode(user).getMeccsek().toString());
        map.put("meccsekv", String.valueOf((int)((double)playerDataService.getPlayerDataByCode(user).getMeccsek() / playerDataService.maxmeccsek() * 100)));
        map.put("golok", String.valueOf(playerDataService.getPlayerDataByCode(user).getGolok()));
        map.put("golokv", String.valueOf((int)((double)playerDataService.getPlayerDataByCode(user).getGolok() / playerDataService.maxgolok() * 100)));
        map.put("onGolok", String.valueOf(playerDataService.getPlayerDataByCode(user).getOnGolok()));
        map.put("onGolokv", String.valueOf((int)((double)playerDataService.getPlayerDataByCode(user).getOnGolok() / playerDataService.maxonGolok() * 100)));
        map.put("sarga", String.valueOf(playerDataService.getPlayerDataByCode(user).getSargaLap()));
        map.put("sargav", String.valueOf((int)((double)playerDataService.getPlayerDataByCode(user).getSargaLap() / playerDataService.maxsargaLap() * 100)));
        map.put("piros", String.valueOf(playerDataService.getPlayerDataByCode(user).getPirosLap()));
        map.put("pirosv", String.valueOf((int)((double)playerDataService.getPlayerDataByCode(user).getPirosLap() / playerDataService.maxpirosLap() * 100)));
        map.put("kezdo", String.valueOf(playerDataService.getPlayerDataByCode(user).getKezdo()));
        map.put("kezdov", String.valueOf((int)((double)playerDataService.getPlayerDataByCode(user).getKezdo() / playerDataService.maxkezdo() * 100)));
        map.put("csere", String.valueOf(playerDataService.getPlayerDataByCode(user).getCsere()));
        map.put("cserev", String.valueOf((int)((double)playerDataService.getPlayerDataByCode(user).getCsere() / playerDataService.maxcsere() * 100)));
        map.put("kispad", String.valueOf(playerDataService.getPlayerDataByCode(user).getKispad()));
        map.put("kispadv", String.valueOf((int)((double)playerDataService.getPlayerDataByCode(user).getKispad() / playerDataService.maxkispad() * 100)));
        return map;
    }
    //endregion
}
