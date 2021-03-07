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
    private PlayerDataService playerDataService;
    private UserOrganizationService userOrganizationService;
    private TabellaService tabellaService;
    private SorsolasService sorsolasService;
    private GoalsService goalsService;
    private YellowCardService yellowCardService;
    private RedCardService redCardService;
    private LigaService ligaService;

    public StatisticsDashboardController(UserService userService, PlayerDataService playerDataService, UserOrganizationService userOrganizationService, TabellaService tabellaService, SorsolasService sorsolasService, GoalsService goalsService, YellowCardService yellowCardService, RedCardService redCardService, LigaService ligaService) {
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

    @RequestMapping(value = "/history", method = RequestMethod.POST)
    @ResponseBody
    @Deprecated
    private String history(@RequestParam("liga") String ligaIn) {
        if (hasPermission(Permissions.MLSZ_STATISTICS)){
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
                data.addLabel("");
            }
            for (int i = 0; i < teams.size(); i++) {
                String team = teams.get(i);
                if(team.equals(liga.getKlubName())){
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
            }
            Options options = new Options();
            Legend legend = new Legend();
            legend.setDisplay(false);
            options.setLegend(legend);
            Animation animation = new Animation();
            animation.setDelay(500);
            animation.setDuration(2500);
            options.setAnimation(animation);
            chartBuilder.setData(data);
            chartBuilder.setOptions(options);
            return chartBuilder.build();
        }
        return "";
    }

    @RequestMapping(value = "/league", method = RequestMethod.POST)
    @ResponseBody
    @Deprecated
    private String league(@RequestParam("liga") String ligaIn) {
        if (hasPermission(Permissions.MLSZ_STATISTICS)){
            Liga liga = ligaService.findByName(ligaIn.trim());
            int maxFord = tabellaService.getLastFordByLiga(liga);
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            List<Tabella> teams = tabellaService.getTabellaByLiga(liga);
            String currentName =userOrganizationService.getOrgByUser(currentUser).getOrganization().getName();
            BarChartBuilder chartBuilder = new BarChartBuilder();
            //Dataset template
            BarDataSet template = new BarDataSet();
            template.setBorderWidth(4);
            //Create Datasets
            Data<BarDataSet> data = new Data<>();
            data.addLabel("");
            for(Tabella tabella : teams){
                BarDataSet dataSet = new BarDataSet(template);
                Color color = (tabella.getCsapat().equals(currentName)) ? new Color(26, 188, 156, 1.0) : new Color(189, 195, 199, 1.0);
                dataSet.setLabel(tabella.getCsapat());
                dataSet.setBackgroundColor(color);
                dataSet.setHoverBackgroundColor(color);
                dataSet.setBorderColor(color);
                dataSet.setHoverBorderColor(color);
                List<Object> datas = new ArrayList<>();
                datas.add((Objects.nonNull(tabella) && Objects.nonNull(tabella.getPontszam())) ? tabella.getPontszam() : 0);
                dataSet.setData(datas.toArray());
                data.addDataset(dataSet);
            }
            Options options = new Options();
            Legend legend = new Legend();
            legend.setDisplay(false);
            options.setLegend(legend);
            Animation animation = new Animation();
            animation.setDelay(500);
            animation.setDuration(2500);
            options.setAnimation(animation);
            chartBuilder.setData(data);
            chartBuilder.setOptions(options);
            return chartBuilder.build();
        }
        return "";
    }

    private PlayerData getPlayerData() {
        User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
        UserOrganization uOrg = userOrganizationService.getOrgByUser(currentUser);
        return new MLSZParser(uOrg.getUser().getUrl()).getPlayerData();
    }
}
