package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.common.Roles;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.trainingplan.TrainingPlan;
import hu.playmaker.database.service.index.CalendarService;
import hu.playmaker.database.service.system.LookupCodeService;
import hu.playmaker.database.service.system.UserNotificationService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.database.service.trainingplan.ExerciseService;
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

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

    public TrainingPlanController(ExerciseService exerciseService, UserOrganizationService userOrganizationService, UserService userService, LookupCodeService lookupCodeService, TrainingPlanService trainingPlanService, UserNotificationService userNotificationService, CalendarService calendarService) {
        this.exerciseService = exerciseService;
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
        this.lookupCodeService = lookupCodeService;
        this.trainingPlanService = trainingPlanService;
        this.userNotificationService = userNotificationService;
        this.calendarService = calendarService;
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
            TrainingPlanFormValidator validator = new TrainingPlanFormValidator();
            validator.validate(form, result);
            if(result.hasErrors()){
                ModelAndView errorView = show();
                errorView.getModel().replace("error", result.getFieldError("date").getDefaultMessage());
                return errorView;
            }
            Organization organization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization();
            TrainingPlan trainingPlan = (isNull(form.id)) ? new TrainingPlan() : trainingPlanService.find(form.id);
            trainingPlan.setOrganization(organization);
            trainingPlan.setTeam(lookupCodeService.find(form.getTeam()));
            trainingPlan.setExercise1((isNull(form.getExercise1())) ? null : exerciseService.find(form.getExercise1()));
            trainingPlan.setExercise2((isNull(form.getExercise2())) ? null : exerciseService.find(form.getExercise2()));
            trainingPlan.setExercise3((isNull(form.getExercise3())) ? null : exerciseService.find(form.getExercise3()));
            trainingPlan.setExercise4((isNull(form.getExercise4())) ? null : exerciseService.find(form.getExercise4()));
            trainingPlan.setExercise5((isNull(form.getExercise5())) ? null : exerciseService.find(form.getExercise5()));
            trainingPlan.setExercise6((isNull(form.getExercise6())) ? null : exerciseService.find(form.getExercise6()));
            trainingPlan.setExercise7((isNull(form.getExercise7())) ? null : exerciseService.find(form.getExercise7()));
            trainingPlan.setExercise8((isNull(form.getExercise8())) ? null : exerciseService.find(form.getExercise8()));
            trainingPlan.setExercise9((isNull(form.getExercise9())) ? null : exerciseService.find(form.getExercise9()));
            trainingPlan.setExercise10((isNull(form.getExercise10())) ? null : exerciseService.find(form.getExercise10()));
            trainingPlan.setExercise11((isNull(form.getExercise11())) ? null : exerciseService.find(form.getExercise11()));
            trainingPlan.setExercise12((isNull(form.getExercise12())) ? null : exerciseService.find(form.getExercise12()));
            trainingPlan.setExercise13((isNull(form.getExercise13())) ? null : exerciseService.find(form.getExercise13()));
            trainingPlan.setExercise14((isNull(form.getExercise14())) ? null : exerciseService.find(form.getExercise14()));
            trainingPlan.setExercise15((isNull(form.getExercise15())) ? null : exerciseService.find(form.getExercise15()));
            trainingPlan.setExercise16((isNull(form.getExercise16())) ? null : exerciseService.find(form.getExercise16()));
            trainingPlan.setExercise17((isNull(form.getExercise17())) ? null : exerciseService.find(form.getExercise17()));
            trainingPlan.setExercise18((isNull(form.getExercise18())) ? null : exerciseService.find(form.getExercise18()));
            trainingPlan.setExercise19((isNull(form.getExercise19())) ? null : exerciseService.find(form.getExercise19()));
            trainingPlan.setExercise20((isNull(form.getExercise20())) ? null : exerciseService.find(form.getExercise20()));
            trainingPlan.setExercise1Time(form.getExercise1Time());
            trainingPlan.setExercise2Time(form.getExercise2Time());
            trainingPlan.setExercise3Time(form.getExercise3Time());
            trainingPlan.setExercise4Time(form.getExercise4Time());
            trainingPlan.setExercise5Time(form.getExercise5Time());
            trainingPlan.setExercise6Time(form.getExercise6Time());
            trainingPlan.setExercise7Time(form.getExercise7Time());
            trainingPlan.setExercise8Time(form.getExercise8Time());
            trainingPlan.setExercise9Time(form.getExercise9Time());
            trainingPlan.setExercise10Time(form.getExercise10Time());
            trainingPlan.setExercise11Time(form.getExercise11Time());
            trainingPlan.setExercise12Time(form.getExercise12Time());
            trainingPlan.setExercise13Time(form.getExercise13Time());
            trainingPlan.setExercise14Time(form.getExercise14Time());
            trainingPlan.setExercise15Time(form.getExercise15Time());
            trainingPlan.setExercise16Time(form.getExercise16Time());
            trainingPlan.setExercise17Time(form.getExercise17Time());
            trainingPlan.setExercise18Time(form.getExercise18Time());
            trainingPlan.setExercise19Time(form.getExercise19Time());
            trainingPlan.setExercise20Time(form.getExercise20Time());
            trainingPlan.setTrainingDate(form.getDate().replaceAll("\\s", "").replaceAll("-", "").replace('.', '/'));
            trainingPlanService.mergeFlush(trainingPlan);
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
                pushEvents(parsedDate, lookupCodeService.find(form.getTeam()).getCode()+" edzése", organization, calendarService);
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
                if(!isNull(trainingPlan.getExercise1()))
                    exercises.put(trainingPlan.getExercise1().getId());
                if(!isNull(trainingPlan.getExercise2()))
                    exercises.put(trainingPlan.getExercise2().getId());
                if(!isNull(trainingPlan.getExercise3()))
                    exercises.put(trainingPlan.getExercise3().getId());
                if(!isNull(trainingPlan.getExercise4()))
                    exercises.put(trainingPlan.getExercise4().getId());
                if(!isNull(trainingPlan.getExercise5()))
                    exercises.put(trainingPlan.getExercise5().getId());
                if(!isNull(trainingPlan.getExercise6()))
                    exercises.put(trainingPlan.getExercise6().getId());
                if(!isNull(trainingPlan.getExercise7()))
                    exercises.put(trainingPlan.getExercise7().getId());
                if(!isNull(trainingPlan.getExercise8()))
                    exercises.put(trainingPlan.getExercise8().getId());
                if(!isNull(trainingPlan.getExercise9()))
                    exercises.put(trainingPlan.getExercise9().getId());
                if(!isNull(trainingPlan.getExercise10()))
                    exercises.put(trainingPlan.getExercise10().getId());
                if(!isNull(trainingPlan.getExercise11()))
                    exercises.put(trainingPlan.getExercise11().getId());
                if(!isNull(trainingPlan.getExercise12()))
                    exercises.put(trainingPlan.getExercise12().getId());
                if(!isNull(trainingPlan.getExercise13()))
                    exercises.put(trainingPlan.getExercise13().getId());
                if(!isNull(trainingPlan.getExercise14()))
                    exercises.put(trainingPlan.getExercise14().getId());
                if(!isNull(trainingPlan.getExercise15()))
                    exercises.put(trainingPlan.getExercise15().getId());
                if(!isNull(trainingPlan.getExercise16()))
                    exercises.put(trainingPlan.getExercise16().getId());
                if(!isNull(trainingPlan.getExercise17()))
                    exercises.put(trainingPlan.getExercise17().getId());
                if(!isNull(trainingPlan.getExercise18()))
                    exercises.put(trainingPlan.getExercise18().getId());
                if(!isNull(trainingPlan.getExercise19()))
                    exercises.put(trainingPlan.getExercise19().getId());
                if(!isNull(trainingPlan.getExercise20()))
                    exercises.put(trainingPlan.getExercise20().getId());
                json.put("exercises", exercises);
                if(!isNull(trainingPlan.getExercise1Time()))
                    times.put(trainingPlan.getExercise1Time());
                if(!isNull(trainingPlan.getExercise2Time()))
                    times.put(trainingPlan.getExercise2Time());
                if(!isNull(trainingPlan.getExercise3Time()))
                    times.put(trainingPlan.getExercise3Time());
                if(!isNull(trainingPlan.getExercise4Time()))
                    times.put(trainingPlan.getExercise4Time());
                if(!isNull(trainingPlan.getExercise5Time()))
                    times.put(trainingPlan.getExercise5Time());
                if(!isNull(trainingPlan.getExercise6Time()))
                    times.put(trainingPlan.getExercise6Time());
                if(!isNull(trainingPlan.getExercise7Time()))
                    times.put(trainingPlan.getExercise7Time());
                if(!isNull(trainingPlan.getExercise8Time()))
                    times.put(trainingPlan.getExercise8Time());
                if(!isNull(trainingPlan.getExercise9Time()))
                    times.put(trainingPlan.getExercise9Time());
                if(!isNull(trainingPlan.getExercise10Time()))
                    times.put(trainingPlan.getExercise10Time());
                if(!isNull(trainingPlan.getExercise11Time()))
                    times.put(trainingPlan.getExercise11Time());
                if(!isNull(trainingPlan.getExercise12Time()))
                    times.put(trainingPlan.getExercise12Time());
                if(!isNull(trainingPlan.getExercise13Time()))
                    times.put(trainingPlan.getExercise13Time());
                if(!isNull(trainingPlan.getExercise14Time()))
                    times.put(trainingPlan.getExercise14Time());
                if(!isNull(trainingPlan.getExercise15Time()))
                    times.put(trainingPlan.getExercise15Time());
                if(!isNull(trainingPlan.getExercise16Time()))
                    times.put(trainingPlan.getExercise16Time());
                if(!isNull(trainingPlan.getExercise17Time()))
                    times.put(trainingPlan.getExercise17Time());
                if(!isNull(trainingPlan.getExercise18Time()))
                    times.put(trainingPlan.getExercise18Time());
                if(!isNull(trainingPlan.getExercise19Time()))
                    times.put(trainingPlan.getExercise19Time());
                if(!isNull(trainingPlan.getExercise20Time()))
                    times.put(trainingPlan.getExercise20Time());
                json.put("time", times);
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "";
    }
}
