package hu.playmaker.controller.play;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.common.enums.Roles;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.trainingplan.Exercise;
import hu.playmaker.database.model.trainingplan.TrainingPlan;
import hu.playmaker.database.model.trainingplan.TrainingPlanConnection;
import hu.playmaker.database.service.index.CalendarService;
import hu.playmaker.database.service.system.LookupCodeService;
import hu.playmaker.database.service.system.UserNotificationService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.database.service.trainingplan.ExerciseService;
import hu.playmaker.database.service.trainingplan.TrainingPlanConnectionService;
import hu.playmaker.database.service.trainingplan.TrainingPlanService;
import hu.playmaker.form.TrainingPlanForm;
import hu.playmaker.form.validator.TrainingPlanFormValidator;
import hu.playmaker.handler.SessionHandler;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

import static java.util.Objects.isNull;

@Controller
@RequestMapping("/training/plan")
public class TrainingPlanController extends BaseController {

    private ExerciseService exerciseService;
    private UserOrganizationService userOrganizationService;
    private UserService userService;
    private LookupCodeService lookupCodeService;
    private TrainingPlanService trainingPlanService;
    private UserNotificationService userNotificationService;
    private CalendarService calendarService;
    private TrainingPlanConnectionService connectionService;

    public TrainingPlanController(ExerciseService exerciseService, UserOrganizationService userOrganizationService, UserService userService, LookupCodeService lookupCodeService, TrainingPlanService trainingPlanService, UserNotificationService userNotificationService, CalendarService calendarService, TrainingPlanConnectionService connectionService) {
        this.exerciseService = exerciseService;
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
        this.lookupCodeService = lookupCodeService;
        this.trainingPlanService = trainingPlanService;
        this.userNotificationService = userNotificationService;
        this.calendarService = calendarService;
        this.connectionService = connectionService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.TRAIN_TABLE)) {
            ModelAndView view = new ModelAndView("play/TrainingPlan", "modifyTrainingPlan", new TrainingPlanForm());
            if(hasPermission(Permissions.TRAIN_CREATE)){
                view.addObject("exercises", exerciseService.findAllByCreatedBy(SessionHandler.getUsernameFromCurrentSession()));
                view.addObject("teams", userOrganizationService.getOrgListByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()))); //find all orgtype
            }
            if(SessionHandler.userHasRole(Roles.OWNER.name())){
                view.addObject("datas", trainingPlanService.findAllByOrg(userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization()));
            } else {
                view.addObject("datas", trainingPlanService.findAllCreatedBy(SessionHandler.getUsernameFromCurrentSession()));
            }
            view.addObject("error", "");
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView doSubmit(@Valid @ModelAttribute("modifyTrainingPlan") TrainingPlanForm form, BindingResult result) {
        if(hasPermission(Permissions.TRAIN_CREATE)){
            //Validation
            TrainingPlanFormValidator validator = new TrainingPlanFormValidator();
            validator.validate(form, result);
            if(result.hasErrors()){
                ModelAndView errorView = show();
                errorView.getModel().replace("error", result.getFieldError("date").getDefaultMessage());
                return errorView;
            }

            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();


            //Create Training plan
            TrainingPlan trainingPlan = (isNull(form.id)) ? new TrainingPlan() : trainingPlanService.find(form.id);
            trainingPlan.setOrganization(organization);
            trainingPlan.setTeam(lookupCodeService.find(form.getTeam()));
            trainingPlan.setTrainingDate(form.getDate().replaceAll("\\s", "").replaceAll("-", "").replace('.', '/'));
            List<TrainingPlan> plans = trainingPlanService.findAll(trainingPlan.getOrganization(), trainingPlan.getTeam(), trainingPlan.getRealTrainingDate());
            if (isNull(form.id) && plans.size() != 0) {
                ModelAndView errorView = show();
                errorView.getModel().replace("error", "Már létezik erre az időpontra edzés");
                return errorView;
            }
            trainingPlanService.mergeFlush(trainingPlan);

            //Add Training plan data {id(connection),id(exercise);}
            if (Objects.nonNull(form.getData()) && !"".equals(form.getData())) {
                String[] exercises = form.getData().split(";");
                TrainingPlan plan = trainingPlanService.find(trainingPlan.getOrganization(), trainingPlan.getTeam(), trainingPlan.getRealTrainingDate());
                if (exercises.length > 0) {
                    for (TrainingPlanConnection connection : connectionService.findByTraining(plan)) {
                        connectionService.delete(connection);
                        connectionService.flush();
                    }
                    for (int i = 0; i < exercises.length; i++) {
                        String data = exercises[i];
                        String[] d = data.split(",");
                        if (d.length == 2 && !"".equals(d[0]) && !"".equals(d[1])) {
                            Exercise exercise = exerciseService.find(Integer.valueOf(d[0]));
                            TrainingPlanConnection planConnection = new TrainingPlanConnection();
                            planConnection.setTrainingPlan(plan);
                            planConnection.setExercise(exercise);
                            planConnection.setDuration(Integer.valueOf(d[1]));
                            planConnection.setSort(i+1);
                            connectionService.mergeFlush(planConnection);
                        }
                    }
                }
            }

            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            pushNotification(
                    "training/workout",
                    "Új edzés",
                    currentUser.getName()+" edzést vett fel!",
                    userOrganizationService.getUsersByOrgIfPlayer(organization, lookupCodeService.find(form.getTeam())),
                    userNotificationService,
                    currentUser
            );
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
            Date parsedDate = null;
            try {
                parsedDate = dateFormat.parse(form.getDate().replaceAll("\\s", "").replaceAll("-", "").replace('.', '/'));
                pushEvents(parsedDate, lookupCodeService.find(form.getTeam()).getCode()+" edzése", organization, lookupCodeService.find(form.getTeam()), calendarService);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return show();
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam String id) {
        if(hasPermission(Permissions.TRAIN_CREATE)){
            trainingPlanService.delete(trainingPlanService.find(Integer.parseInt(id)));
            trainingPlanService.flush();
        }
        return "redirect:/training/plan";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/connection/del")
    public void connectionDelete(@RequestParam String id) {
        if(hasPermission(Permissions.TRAIN_CREATE)){
            connectionService.delete(connectionService.find(Integer.parseInt(id)));
            connectionService.flush();
        }
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam String id) {
        if(hasPermission(Permissions.TRAIN_CREATE)){
            TrainingPlan trainingPlan = trainingPlanService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            JSONArray exercises = new JSONArray();
            JSONArray times = new JSONArray();
            try{
                json.put("date", trainingPlan.getTrainingDate());
                json.put("team", trainingPlan.getTeam().getId());
                for (TrainingPlanConnection planConnection : connectionService.findByTraining(trainingPlan)) {
                    exercises.put(
                            planConnection.getExercise().getId().toString().concat(",")
                            .concat(planConnection.getExercise().getName()).concat(",")
                            .concat(planConnection.getExercise().getType().getCode().concat(",")
                            .concat(planConnection.getId().toString()))
                    );
                    times.put(planConnection.getDuration());
                }
                json.put("exercises", exercises);
                json.put("time", times);
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "";
    }
}
