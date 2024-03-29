package com.teampress.controller.play;

import com.teampress.common.enums.Permissions;
import com.teampress.common.enums.Roles;
import com.teampress.common.factory.excel.ExcelBuilder;
import com.teampress.controller.BaseController;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.model.trainingplan.Exercise;
import com.teampress.database.model.trainingplan.TrainingPlan;
import com.teampress.database.model.workout.Attendance;
import com.teampress.database.model.workout.Workout;
import com.teampress.database.service.system.LookupCodeService;
import com.teampress.database.service.system.UserNotificationService;
import com.teampress.database.service.system.UserOrganizationService;
import com.teampress.database.service.system.UserService;
import com.teampress.database.service.trainingplan.ExerciseService;
import com.teampress.database.service.trainingplan.TrainingPlanConnectionService;
import com.teampress.database.service.trainingplan.TrainingPlanService;
import com.teampress.database.service.workout.AttendanceService;
import com.teampress.database.service.workout.WorkoutService;
import com.teampress.handler.SessionHandler;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/training/workout")
public class WorkoutController extends BaseController {

    private TrainingPlanService trainingPlanService;
    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private ExerciseService exerciseService;
    private LookupCodeService lookupCodeService;
    private WorkoutService workoutService;
    private AttendanceService attendanceService;
    private UserNotificationService userNotificationService;
    private TrainingPlanConnectionService connectionService;

    public WorkoutController(TrainingPlanService trainingPlanService, UserService userService, UserOrganizationService userOrganizationService, ExerciseService exerciseService, LookupCodeService lookupCodeService, WorkoutService workoutService, AttendanceService attendanceService, UserNotificationService userNotificationService, TrainingPlanConnectionService connectionService) {
        this.trainingPlanService = trainingPlanService;
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.exerciseService = exerciseService;
        this.lookupCodeService = lookupCodeService;
        this.workoutService = workoutService;
        this.attendanceService = attendanceService;
        this.userNotificationService = userNotificationService;
        this.connectionService = connectionService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.WORKOUT_PLAYER_TABLE) || hasPermission(Permissions.WORKOUT_ALL_TABLE)) {
            ModelAndView view = new ModelAndView("play/Workout");
            if(hasPermission(Permissions.WORKOUT_CREATE)) {
                List<TrainingPlan> trainings = trainingPlanService.findAllCreatedBy(SessionHandler.getUsernameFromCurrentSession());
                view.addObject("trainingsForJSP", filterByAttendance(trainings));
            }
            if(hasPermission(Permissions.WORKOUT_PLAYER_TABLE)) {
                UserOrganization userOrg = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
                view.addObject("trainings", trainingPlanService.findAllByTeam(userOrg.getType(), userOrg.getOrganization()));
            }
            if(hasPermission(Permissions.WORKOUT_ALL_TABLE)){
                ArrayList<UserOrganization> teamList = userOrganizationService.getOrgListByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
                view.addObject("teams", teamList);
                ArrayList<TrainingPlan> trainingPlans = new ArrayList<>();
                for(UserOrganization userOrganization : teamList) {
                    if(SessionHandler.userHasRole(Roles.OWNER.name())){
                        trainingPlans.addAll(trainingPlanService.findAllByTeam(userOrganization.getType(),userOrganization.getOrganization()));
                    } else if(SessionHandler.userHasRole(Roles.TRAINER.name())){
                        trainingPlans.addAll(trainingPlanService.findAllCreatedBy(SessionHandler.getUsernameFromCurrentSession()));
                    }
                }
                view.addObject("trainings", trainingPlans);
            }
            return view;
        }
        return new ModelAndView("403");
    }

    private ArrayList<TrainingPlan> filterByAttendance(List<TrainingPlan> trainings) {
        ArrayList<TrainingPlan> result = new ArrayList<>();
        if(hasPermission(Permissions.WORKOUT_CREATE))
            trainings.forEach(trainingPlan -> {
                if(!attendanceService.existByTrainingPlan(trainingPlan))
                    result.add(trainingPlan);
            });
        return result;
    }

    @RequestMapping(method = RequestMethod.POST, value = "/getPlayers")
    @ResponseBody
    protected String getPlayersForJS(@RequestParam("team") String teamId){
        if(hasPermission(Permissions.WORKOUT_CREATE) || hasPermission(Permissions.WORKOUT_ALL_TABLE)){
            return getPlayers(Integer.parseInt(teamId));
        }
        return "";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/status")
    @ResponseBody
    protected String getStatus(@RequestParam("id") String id){
        JSONObject jsonObject = new JSONObject();
        if(hasPermission(Permissions.WORKOUT_PLAYER_TABLE) || hasPermission(Permissions.WORKOUT_ALL_TABLE)){
            try {
                if(workoutService.existByTrainingPlan(trainingPlanService.findUnique(Integer.parseInt(id)))){
                    jsonObject.put("css", "success");
                    jsonObject.put("val", "Értékelve");
                } else {
                    jsonObject.put("css", "warning");
                    jsonObject.put("val", "Értékelésre vár");
                }
            } catch (Exception e){
                e.printStackTrace();
            }
        }
        return jsonObject.toString();
    }

    private String getPlayers(Integer teamId) {
        StringBuilder result = new StringBuilder();
        User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
        Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
        ArrayList<UserOrganization> teamPlayers = userOrganizationService.getUsersByOrgIfPlayer(organization, lookupCodeService.find(teamId));
        for(UserOrganization userOrg : teamPlayers) {
            result.append(userOrg.getUser().getId()).append(",").append(userOrg.getUser().getName()).append(";");
        }
        return result.toString();
    }

    private JSONArray getPlayersUrls(Integer teamId) {
        JSONArray result = new JSONArray();
        User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
        Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
        ArrayList<UserOrganization> teamPlayers = userOrganizationService.getUsersByOrgIfPlayer(organization, lookupCodeService.find(teamId));
        for(UserOrganization userOrg : teamPlayers) {
            result.put(userOrg.getUser().getProfilImg());
        }
        return result;
    }

    //region [Edzés értékelés]
    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String getTrainingFormData(@RequestParam("id") String id,@RequestParam("team") String teamId){
        JSONObject json = new JSONObject();
        if(hasPermission(Permissions.WORKOUT_CREATE)){
            TrainingPlan training = trainingPlanService.findUnique(Integer.parseInt(id));
            String players = getPlayers(Integer.parseInt(teamId));
            try {
                json.put("players", (players.endsWith(";")) ? players.substring(0, players.length()-1) : players); //id,name;
                json.put("exercises", (connectionService.findByTrainingPlanSorted(training).stream().map(e -> e.getExercise().getId()+","+e.getExercise().getType().getCode()+","+e.getExercise().getName()).collect(Collectors.joining(";")))); //id,type,name;
                json.put("profile", getPlayersUrls(Integer.parseInt(teamId)));
            } catch (Exception e){
                e.printStackTrace();
            }
        }
        return json.toString();
    }

    @RequestMapping(method = RequestMethod.POST, value = "/post")
    @ResponseBody
    public String postTrainingFormData(@RequestParam("id") String id,@RequestParam("data") String data){
        if(hasPermission(Permissions.WORKOUT_CREATE)){
            TrainingPlan training = trainingPlanService.findUnique(Integer.parseInt(id));
            for(String playerResult : data.split(";")){
                if(!playerResult.equals("")){
                    String[] trainDatas = playerResult.split(",");
                    if(trainDatas.length > 2 && !trainDatas[0].equals("")) {
                        User currentUser = userService.find(Integer.parseInt(trainDatas[0]));
                        Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
                        training.setDeletable(false);
                        trainingPlanService.mergeFlush(training);
                        Attendance attendance = new Attendance();
                        attendance.setOrganization(organization);
                        attendance.setTeam(training.getTeam());
                        attendance.setTrainingPlan(training);
                        attendance.setUser(currentUser);
                        String jelen = trainDatas[1];
                        if(jelen.equals("0")){
                            //jelen volt
                            attendance.setJelen("jelen");
                            for(int i = 2; i < trainDatas.length; i++){
                                if(trainDatas[i].contains(":")){
                                    String exerciseId = trainDatas[i].split(":")[0];
                                    String result = (trainDatas[i].split(":").length == 2) ? trainDatas[i].split(":")[1] : "";
                                    Workout workout = new Workout();
                                    workout.setOrganization(organization);
                                    workout.setTrainingPlan(training);
                                    workout.setTeam(training.getTeam());
                                    workout.setUser(currentUser);
                                    Exercise exercise = exerciseService.find(Integer.parseInt(exerciseId));
                                    workout.setExercise(exercise);
                                    workout.setResult(result);
                                    if(!exercise.getType().getCode().equals("Szöveges értékelés")){
                                        if(exercise.getType().getCode().equals("Csillagok")){
                                            workout.setResultPercent(Integer.parseInt(result) * 100 /5);
                                        }
                                        if(exercise.getType().getCode().equals("1-10 -es skála")){
                                            workout.setResultPercent(Integer.parseInt(result) * 10);
                                        }
                                        if(exercise.getType().getCode().equals("Százalék")){
                                            workout.setResultPercent(Integer.parseInt(result));
                                        }
                                        if(exercise.getType().getCode().equals("Sikeres/darabszám")){
                                            String[] s = result.split("/");
                                            workout.setResultPercent((Integer.parseInt(s[0]) * 100 ) / Integer.parseInt(s[1]));
                                        }
                                    }
                                    workoutService.mergeFlush(workout);
                                }
                            }
                        } else {
                            if (jelen.equals("1"))
                                attendance.setJelen("igazolt");
                            else
                                attendance.setJelen("igazolatlan");
                            for(int i = 2; i < trainDatas.length; i++){
                                if(trainDatas[i].contains(":")){
                                    String exerciseId = trainDatas[i].split(":")[0];
                                    Workout workout = new Workout();
                                    workout.setOrganization(organization);
                                    workout.setTrainingPlan(training);
                                    workout.setTeam(training.getTeam());
                                    workout.setUser(currentUser);
                                    workout.setExercise(exerciseService.find(Integer.parseInt(exerciseId)));
                                    workout.setResult("H~h~H");
                                    workoutService.mergeFlush(workout);
                                }
                            }
                        }
                        attendanceService.mergeFlush(attendance);
                        pushNotificationToUser(
                                "training/workout",
                                "Értékelt edzés",
                                "Új edzés került értékelésre!",
                                currentUser,
                                userNotificationService

                        );
                    } else {
                        return "hiba: rossz data";
                    }
                }
            }
            return "end";
        }
        return "no rights";
    }
    //endregion

    //region [Edzés értékelés megtekintése]
    @RequestMapping(method = RequestMethod.POST, value = "/getModalDataForPlayer")
    @ResponseBody
    public String getTrainingModalDataForPlayer(@RequestParam("id") String id) {
        if(hasPermission(Permissions.WORKOUT_PLAYER_TABLE)){
            TrainingPlan training = trainingPlanService.findUnique(Integer.parseInt(id));
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            return processJSON(training, user, workoutService, connectionService);
        }
        return "";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/getModalData")
    @ResponseBody
    public String getTrainingModalData(@RequestParam("id") String id, @RequestParam("playerId") String userId) {
        if(hasPermission(Permissions.WORKOUT_ALL_TABLE)){
            TrainingPlan training = trainingPlanService.findUnique(Integer.parseInt(id));
            User user = userService.find(Integer.parseInt(userId));
            return processJSON(training, user, workoutService, connectionService);
        }
        return "";
    }
    //endregion

    @RequestMapping(value = "/export/{tid}/{id1}/{id2}")
    @ResponseBody
    public String exportStatement(HttpServletResponse response, @PathVariable String tid, @PathVariable String id1, @PathVariable String id2) throws IOException, ParseException {
        if(hasPermission(Permissions.LOGGED_IN)) {
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
            Date fromDate = new SimpleDateFormat("yyyy-MM-dd").parse(id1);
            Date toDate = new SimpleDateFormat("yyyy-MM-dd").parse(id2);
            LookupCode team = lookupCodeService.find(Integer.parseInt(tid));
            List<Attendance> attendances = attendanceService.findByDateAndTeam(organization, team, fromDate, toDate);
            if(attendances.size() > 0) {
                ExcelBuilder excel = new ExcelBuilder()
                        .setFileName("Teampress_"+organization.getName().replace(" ", "_")+"_jelenleti_iv_export.xls")
                        .setSheetName("Statement")
                        .addTitle("Sportoló", "Csapat", "Jelenlét", "Létrehozás ideje", "Létrehozó");
                for(Attendance attendance : attendances) {
                    excel.addData(attendance.getUser().getName(), attendance.getTeam().getCode(), attendance.getJelen(), attendance.getCreationDateAsString(), attendance.getCreatedBy());
                }
                File data = excel.build();
                response.setContentType("application/force-download");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + data.getName() + "\"");
                BufferedInputStream inStream = new BufferedInputStream(new FileInputStream(data));
                BufferedOutputStream outStream = new BufferedOutputStream(response.getOutputStream());

                byte[] buffer = new byte[1024];
                int bytesRead = 0;
                while ((bytesRead = inStream.read(buffer)) != -1) {
                    outStream.write(buffer, 0, bytesRead);
                }
                outStream.flush();
                inStream.close();
                return data.toString();
            }
        }
        return null;
    }
}
