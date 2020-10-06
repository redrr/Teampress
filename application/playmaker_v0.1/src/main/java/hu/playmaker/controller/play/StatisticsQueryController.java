package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.common.factory.chartjs.Color;
import hu.playmaker.common.factory.chartjs.Data;
import hu.playmaker.common.factory.chartjs.LineChartBuilder;
import hu.playmaker.common.factory.chartjs.LineDataSet;
import hu.playmaker.common.factory.chartjs.common.enums.BorderCapStyle;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.databank.Goals;
import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.model.databank.RedCard;
import hu.playmaker.database.model.databank.YellowCard;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.service.databank.*;
import hu.playmaker.database.service.system.LookupCodeService;
import hu.playmaker.database.service.system.TrainerRatingResultService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.database.service.trainingplan.TrainingPlanService;
import hu.playmaker.database.service.workout.AttendanceService;
import hu.playmaker.database.service.workout.WorkoutService;
import hu.playmaker.handler.SessionHandler;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Controller
@RequestMapping("/statistics/query")
public class StatisticsQueryController extends BaseController {

    private UserOrganizationService userOrganizationService;
    private UserService userService;
    private GoalsService goalsService;
    private YellowCardService yellowCardService;
    private RedCardService redCardService;
    private TurnService turnService;
    private LigaService ligaService;
    private AttendanceService attendanceService;
    private LookupCodeService lookupCodeService;
    private WorkoutService workoutService;
    private TrainingPlanService trainingPlanService;
    private TrainerRatingResultService trainerRatingResultService;

    public StatisticsQueryController(UserOrganizationService userOrganizationService, UserService userService, GoalsService goalsService, YellowCardService yellowCardService, RedCardService redCardService, TurnService turnService, LigaService ligaService, AttendanceService attendanceService, LookupCodeService lookupCodeService, WorkoutService workoutService, TrainingPlanService trainingPlanService, TrainerRatingResultService trainerRatingResultService) {
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
        this.goalsService = goalsService;
        this.yellowCardService = yellowCardService;
        this.redCardService = redCardService;
        this.turnService = turnService;
        this.ligaService = ligaService;
        this.attendanceService = attendanceService;
        this.lookupCodeService = lookupCodeService;
        this.workoutService = workoutService;
        this.trainingPlanService = trainingPlanService;
        this.trainerRatingResultService = trainerRatingResultService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if (hasPermission(Permissions.PLAYERS_STAT)) {
            ModelAndView view = new ModelAndView("play/StatisticsQuery");
            view.addObject("playerLeagueOptions", getSimpleDataOptions());
            view.addObject("trainerOptions", getOptions());
            view.addObject("trainers", getTrainers());
            view.addObject("trainerChartTypes",chartTypes());
            return view;
        }
        return new ModelAndView("403");
    }

    //region [Region] Init JSP Attributes
    private Map<String, String> getSimpleDataOptions() {
        Map<String, String> result = new TreeMap<>();
        result.put("goals", "Szerzett gólok a szezonban");
        result.put("yellow", "Sárgalapok a szezonban");
        result.put("red", "Piroslapok a szezonban");
        result.put("attendPercent", "Edzés jelenlét százalékban");
        result.put("playerIndex", "Játékos edzésmunka index");
        return result;
    }

    private Map<String, String> getOptions() {
        Map<String, String> result = new TreeMap<>();
        result.put("trainingplans", "Edzéstervek száma");
        result.put("trainerrating", "Edző értékelések eredménye");
        result.put("attendPercent", "Edzés látogatottság százalékban");
        return result;
    }

    private Map<String, String> getTrainers() {
        Map<String, String> result = new HashMap<>();
        Organization currentOrg = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
        ArrayList<UserOrganization> userOrganizations = userOrganizationService.getOrgListByOrg(currentOrg);
        for (UserOrganization userOrganization : userOrganizations) {
            User user = userOrganization.getUser();
            if (user.isTrainer() && user.isEnabled() && !user.isDeleted()) {
                result.put(user.getId().toString(), user.getName());
            }
        }
        return result;
    }

    private Map<String, String> chartTypes() {
        Map<String, String> result = new HashMap<>();
        result.put("sline", "Vonal diagram");
        result.put("sbar", "Oszlop diagram");
        result.put("cline", "Területi diagram");
        return  result;
    }
    //endregion

    //region [Region] PlayerQuery Methods
    @RequestMapping(value = "/getypes", method = RequestMethod.POST)
    @ResponseBody
    private String chartTypes(@RequestParam("option") String option) {
        if (Objects.nonNull(option) && option.trim().length() != 0) {
            JSONObject json = new JSONObject();
            JSONArray arrType = new JSONArray();
            JSONArray arrName = new JSONArray();
            JSONArray arrLigaName = new JSONArray();
            JSONArray arrLigaid = new JSONArray();
            JSONArray arrYears = new JSONArray();
            try {
                arrType.put("sline");
                arrType.put("sbar");
                arrType.put("cline");
                json.put("type", arrType);
                arrName.put("Vonal diagram");
                arrName.put("Oszlop diagram");
                arrName.put("Területi diagram");
                json.put("name", arrName);
                ArrayList<UserOrganization> ligas = userOrganizationService.getOrgListByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
                if (option.equals("goals") || option.equals("yellow") || option.equals("red")) {
                    json.put("liga", true);
                    ArrayList<Liga> ligaArrayList = new ArrayList<>();
                    ligas.forEach(liga -> {
                        if (!ligaArrayList.contains(liga.getLiga()))
                            ligaArrayList.add(liga.getLiga());
                    });
                    ligaArrayList.forEach(liga -> {
                        arrLigaid.put(liga.getId());
                        arrLigaName.put(liga.getLiga());
                    });
                    json.put("ligaId", arrLigaid);
                    json.put("ligaName", arrLigaName);
                } else if (option.equals("playerIndex") || option.equals("attendPercent")) {
                    json.put("liga", false);
                    ArrayList<LookupCode> lookupCodes = new ArrayList<>();
                    ligas.forEach(liga -> {
                        if (!lookupCodes.contains(liga.getType()))
                            lookupCodes.add(liga.getType());
                    });
                    lookupCodes.forEach(lookupCode -> {
                        arrLigaid.put(lookupCode.getId());
                        arrLigaName.put(lookupCode.getCode());
                    });
                    json.put("ligaId", arrLigaid);
                    json.put("ligaName", arrLigaName);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return json.toString();
        }
        return "";
    }

    @RequestMapping(value = "/getplayerfords", method = RequestMethod.POST)
    @ResponseBody
    private String fords(@RequestParam("liga") String id, @RequestParam("rule") String rule, @RequestParam("option") String option) {
        JSONObject json = new JSONObject();
        try {
            if (Boolean.parseBoolean(rule)) {
                if (Objects.nonNull(id) && id.trim().length() != 0) {
                    JSONArray scale = new JSONArray();
                    Integer max = turnService.findByLiga(ligaService.find(Integer.parseInt(id)));
                    if (Objects.nonNull(max)) {
                        for (int i = 1; i < max + 1; i++) {
                            scale.put(i);
                        }
                        json.put("scale", scale);
                        json.put("flag", true);
                    } else {
                        return "";
                    }
                }
            } else {
                JSONArray years = new JSONArray();
                LookupCode team = lookupCodeService.find(Integer.parseInt(id));
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy");
                int fromYear = 0;
                int toYear = 0;
                if (option.equals("playerIndex")) {
                    fromYear = Integer.parseInt(simpleDateFormat.format(workoutService.findMinByTeam(team).getCreationDate()));
                    toYear = Integer.parseInt(simpleDateFormat.format(workoutService.findMaxByTeam(team).getCreationDate()));
                }
                if (option.equals("attendPercent")) {
                    fromYear = Integer.parseInt(simpleDateFormat.format(attendanceService.findMinByTeam(team).getCreationDate()));
                    toYear = Integer.parseInt(simpleDateFormat.format(attendanceService.findMaxByTeam(team).getCreationDate()));
                }
                for (int i = fromYear; i <= toYear; i++) {
                    years.put(i);
                }
                json.put("scale", years);
                json.put("flag", false);
            }
            return json.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "/getplayers", method = RequestMethod.POST)
    @ResponseBody
    private String players(@RequestParam("liga") String id, @RequestParam("flag") String flag) {
        if (Objects.nonNull(id) && id.trim().length() != 0) {
            JSONObject json = new JSONObject();
            JSONArray playerId = new JSONArray();
            JSONArray playerName = new JSONArray();
            try {
                Organization currentOrg = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
                ArrayList<UserOrganization> userOrganizations = new ArrayList<>();
                if (Boolean.parseBoolean(flag)) {
                    userOrganizations = userOrganizationService.getOrgListByLiga(currentOrg, ligaService.find(Integer.parseInt(id)));
                } else {
                    userOrganizations = userOrganizationService.getOrgListByTeam(currentOrg, lookupCodeService.find(Integer.parseInt(id)));
                }
                for (UserOrganization userOrganization : userOrganizations) {
                    User user = userOrganization.getUser();
                    if (user.isPlayer() && user.isEnabled() && !user.isDeleted()) {
                        playerId.put(user.getId());
                        playerName.put(user.getName());
                    }
                }
                json.put("id", playerId);
                json.put("name", playerName);
            } catch (Exception e) {
                e.printStackTrace();
            }
            return json.toString();
        }
        return "";
    }

    @RequestMapping(value = "/getplayerstat", method = RequestMethod.POST)
    @ResponseBody
    private String simpleData(@RequestParam("flag") String flag, @RequestParam("option") String option, @RequestParam("type") String type, @RequestParam("player") String playerList, @RequestParam("from") String from, @RequestParam("to") String to, @RequestParam("liga") String liga) {
        String[] months = {"01/01", "02/01", "03/01", "04/01", "05/01", "06/01", "07/01", "08/01", "09/01", "10/01", "11/01", "12/01", "12/31"};
        String[] monthNames = {"Január", "Február", "Március", "Április", "Május", "Június", "Július", "Augusztus", "Szeptember", "Október", "November", "December"};
        if (hasPermission(Permissions.PLAYERS_STAT)) {
            LineChartBuilder chartBuilder = new LineChartBuilder();
            //Dataset template
            LineDataSet template = new LineDataSet();
            template.setBorderCapStyle(BorderCapStyle.ROUND);
            template.setBorderWidth(4);
            template.setPointRadius(2);
            template.setPointHoverRadius(4);
            template.setPointHitRadius(12);
            template.setPointHoverBorderWidth(8);
            template.setFill(type.startsWith("c"));
            //Create Datasets
            Data<LineDataSet> data = new Data<>();
            Color color = new Color(26, 188, 156, 0.2);
            Color hoverColor = new Color(26, 188, 156, 0.8);
            LineDataSet dataSet = new LineDataSet(template);
            dataSet.setBackgroundColor(color);
            dataSet.setHoverBackgroundColor(hoverColor);
            dataSet.setBorderColor(hoverColor);
            dataSet.setHoverBorderColor(hoverColor);
            dataSet.setPointBackgroundColor(color);
            dataSet.setPointHoverBackgroundColor(color);
            List<Object> datas = new ArrayList<>();
            if (Boolean.parseBoolean(flag)) {
                for (int i = Integer.parseInt(from); i < Integer.parseInt(to) + 1; i++) {
                    data.addLabel(i + ". forduló");
                }
                for (int i = 0; i < playerList.split(";").length; i++) {
                    String player = playerList.split(";")[i];
                    User user = userService.find(Integer.parseInt(player));
                    dataSet.setLabel(user.getName());
                    for (int j = Integer.parseInt(from); j < Integer.parseInt(to) + 1; j++) {
                        if (option.equals("goals")) {
                            Goals goal = goalsService.findUnique(ligaService.find(Integer.parseInt(liga)), userOrganizationService.getOrgByUser(user).getOrganization(), j, user.getName());
                            datas.add((Objects.nonNull(goal) && Objects.nonNull(goal.getGoalInFord())) ? goal.getGoalInFord() : 0);
                        } else if (option.equals("yellow")) {
                            //todo: ford
                            YellowCard yellowCard = yellowCardService.findUnique(ligaService.find(Integer.parseInt(liga)), userOrganizationService.getOrgByUser(user).getOrganization(), user.getName()).get(0);
                            datas.add((Objects.nonNull(yellowCard) && Objects.nonNull(yellowCard.getCard())) ? yellowCard.getCard() : 0);
                        } else if (option.equals("red")) {
                            //todo: ford
                            RedCard redCard = redCardService.findUnique(ligaService.find(Integer.parseInt(liga)), userOrganizationService.getOrgByUser(user).getOrganization(), user.getName()).get(0);
                            datas.add((Objects.nonNull(redCard) && Objects.nonNull(redCard.getCard())) ? redCard.getCard() : 0);
                        }
                    }
                }
            } else {
                Date fromDate = null;
                Date toDate = null;
                try {
                    fromDate = new SimpleDateFormat("yyyy/MM/dd").parse(from);
                    toDate = new SimpleDateFormat("yyyy/MM/dd").parse(to);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                long monthsBetween = ChronoUnit.MONTHS.between(
                        LocalDate.parse(from.replace('/','-')).withDayOfMonth(1),
                        LocalDate.parse(to.replace('/','-')).withDayOfMonth(1));
                for (int i = 0; i < monthsBetween + 1; i++) {
                    int num = (fromDate.getMonth()+i)%12;
                    data.addLabel(monthNames[num]);
                }
                for (int i = 0; i < playerList.split(";").length; i++) {
                    String player = playerList.split(";")[i];
                    User user = userService.find(Integer.parseInt(player));
                    dataSet.setLabel(user.getName());
                    if (option.equals("attendPercent")) {
                        for (int j = 0; j < monthsBetween + 1; j++) {
                            fromDate.setMonth(fromDate.getMonth()+j);
                            fromDate.setDate(1);
                            toDate.setMonth(fromDate.getMonth()+1);
                            toDate.setDate(1);
                            int count = attendanceService.count(user, fromDate, toDate).intValue();
                            int sum = attendanceService.sum(user, fromDate, toDate).intValue();
                            datas.add((sum > 0 && count > 0) ? count * 100 / sum : 0);
                        }
                    }
                    if (option.equals("playerIndex")) {
                        for (int j = 0; j < monthsBetween + 1; j++) {
                            fromDate.setMonth(fromDate.getMonth()+j);
                            toDate.setMonth(fromDate.getMonth()+1);
                            int count = (Objects.nonNull(workoutService.count(user, fromDate, toDate))) ? workoutService.count(user, fromDate, toDate).intValue() : 0;
                            int sum = (Objects.nonNull(workoutService.sum(user, fromDate, toDate))) ? workoutService.sum(user, fromDate, toDate).intValue() : 0;
                            datas.add((sum > 0 && count > 0) ? sum / count : 0);
                        }
                    }
                }
            }
            dataSet.setData(datas.toArray());
            data.addDataset(dataSet);
            chartBuilder.setData(data);
            return chartBuilder.build();
        }
        return "";
    }
    //endregion

    //region [Region] TrainerQuery Methods
    @RequestMapping(value = "/gettrainerfords", method = RequestMethod.POST)
    @ResponseBody
    private String fords(@RequestParam("option") String option) {
        JSONObject json = new JSONObject();
        try {
            JSONArray years = new JSONArray();
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy");
            int fromYear = 0;
            int toYear = 0;
            if(option.equals("trainingplans")){
                fromYear = Integer.parseInt(simpleDateFormat.format(trainingPlanService.findMin(organization).getCreationDate()));
                toYear = Integer.parseInt(simpleDateFormat.format(trainingPlanService.findMax(organization).getCreationDate()));
            }
            if (option.equals("trainerrating")) {
                fromYear = Integer.parseInt(simpleDateFormat.format(workoutService.findMinByOrg(organization).getCreationDate()));
                toYear = Integer.parseInt(simpleDateFormat.format(workoutService.findMaxByOrg(organization).getCreationDate()));
            }
            if (option.equals("attendPercent")) {
                fromYear = Integer.parseInt(simpleDateFormat.format(attendanceService.findMinByOrg(organization).getCreationDate()));
                toYear = Integer.parseInt(simpleDateFormat.format(attendanceService.findMaxByOrg(organization).getCreationDate()));
            }
            for (int i = fromYear; i <= toYear; i++) {
                years.put(i);
            }
            json.put("scale", years);
            json.put("flag", false);
            return json.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @RequestMapping(value = "/gettrainerstat", method = RequestMethod.POST)
    @ResponseBody
    private String simpleData(@RequestParam("option") String option, @RequestParam("type") String type, @RequestParam("player") String playerList, @RequestParam("from") String from, @RequestParam("to") String to) {
        String[] months = {"01/01", "02/01", "03/01", "04/01", "05/01", "06/01", "07/01", "08/01", "09/01", "10/01", "11/01", "12/01", "12/31"};
        String[] monthNames = {"Január", "Február", "Március", "Április", "Május", "Június", "Július", "Augusztus", "Szeptember", "Október", "November", "December"};
        if (hasPermission(Permissions.PLAYERS_STAT)) {
            LineChartBuilder chartBuilder = new LineChartBuilder();
            //Dataset template
            LineDataSet template = new LineDataSet();
            template.setBorderCapStyle(BorderCapStyle.ROUND);
            template.setBorderWidth(4);
            template.setPointRadius(2);
            template.setPointHoverRadius(4);
            template.setPointHitRadius(12);
            template.setPointHoverBorderWidth(8);
            template.setFill(type.startsWith("c"));
            //Create Datasets
            Data<LineDataSet> data = new Data<>();
            Color color = new Color(26, 188, 156, 0.2);
            Color hoverColor = new Color(26, 188, 156, 0.8);
            LineDataSet dataSet = new LineDataSet(template);
            dataSet.setBackgroundColor(color);
            dataSet.setHoverBackgroundColor(hoverColor);
            dataSet.setBorderColor(hoverColor);
            dataSet.setHoverBorderColor(hoverColor);
            dataSet.setPointBackgroundColor(color);
            dataSet.setPointHoverBackgroundColor(color);
            List<Object> datas = new ArrayList<>();
            Date fromDate = null;
            Date toDate = null;
            try {
                fromDate = new SimpleDateFormat("yyyy/MM/dd").parse(from);
                toDate = new SimpleDateFormat("yyyy/MM/dd").parse(to);
                long monthsBetween = ChronoUnit.MONTHS.between(
                        LocalDate.parse(from.replace('/','-')).withDayOfMonth(1),
                        LocalDate.parse(to.replace('/','-')).withDayOfMonth(1));
                for (int i = 0; i < monthsBetween + 1; i++) {
                    int num = (fromDate.getMonth()+i)%12;
                    data.addLabel(monthNames[num]);
                }
                for (int i = 0; i < playerList.split(";").length; i++) {
                    String player = playerList.split(";")[i];
                    User user = userService.find(Integer.parseInt(player));
                    Organization organization = userOrganizationService.getOrgByUser(user).getOrganization();
                    int month = fromDate.getMonth();
                    for (int j = 0; j < monthsBetween + 1; j++) {
                        int currentMonth = month+j;
                        fromDate.setMonth(currentMonth);
                        fromDate.setDate(1);
                        toDate.setMonth(currentMonth+1);
                        toDate.setDate(1);
                        if (option.equals("trainingplans")) {
                            int count = trainingPlanService.count(user.getUsername(), organization, fromDate, toDate).intValue();
                            datas.add(count);
                        }
                        if (option.equals("attendPercent")) {
                            int count = attendanceService.count(user.getUsername(), organization, fromDate, toDate).intValue();
                            int sum = attendanceService.sum(user.getUsername(), organization, fromDate, toDate).intValue();
                            datas.add((sum > 0 && count > 0) ? count * 100 / sum : 0);
                        }
                        if (option.equals("trainerrating")) {
                            Double avr = trainerRatingResultService.avr(organization, user, fromDate, toDate);
                            datas.add(Objects.nonNull(avr) ? avr : 0);
                        }
                    }
                    dataSet.setLabel(user.getName());
                    dataSet.setData(datas.toArray());
                    data.addDataset(dataSet);
                    chartBuilder.setData(data);
                }
                return chartBuilder.build();
            } catch (Exception e) {
                e.printStackTrace();
                return "";
            }
        }
        return "";
    }
    //endregion
}