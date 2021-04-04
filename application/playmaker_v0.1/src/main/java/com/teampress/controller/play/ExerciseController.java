package com.teampress.controller.play;

import com.teampress.common.enums.LGroups;
import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.trainingplan.Exercise;
import com.teampress.database.service.system.LookupCodeService;
import com.teampress.database.service.system.UserOrganizationService;
import com.teampress.database.service.system.UserService;
import com.teampress.database.service.trainingplan.ExerciseService;
import com.teampress.form.ExerciseForm;
import com.teampress.form.validator.ExerciseFormValidator;
import com.teampress.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.Objects;

import static java.util.Objects.isNull;

@Controller
@RequestMapping("/training/exercise")
public class ExerciseController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private ExerciseService exerciseService;
    private LookupCodeService lookupCodeService;

    public ExerciseController(UserService userService, UserOrganizationService userOrganizationService, ExerciseService exerciseService, LookupCodeService lookupCodeService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.exerciseService = exerciseService;
        this.lookupCodeService = lookupCodeService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.EXERCISE_TABLE)) {
            ModelAndView view = new ModelAndView("play/Exercise", "modifyExercise", new ExerciseForm());
            if(hasPermission(Permissions.EXERCISE_CREATE)){
                view.addObject("types", lookupCodeService.findAllLookupByLgroup(LGroups.EXERCISE_TYPE.name()));
            }
            view.addObject("datas", exerciseService.findAllByCreatedBy(SessionHandler.getUsernameFromCurrentSession()));
            view.addObject("error","");
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView doSubmit(@Valid @ModelAttribute("modifyTrainingType") ExerciseForm form, BindingResult result) {
        if(hasPermission(Permissions.EXERCISE_CREATE)){
            ExerciseFormValidator validator = new ExerciseFormValidator();
            validator.validate(form, result);
            ModelAndView errorView = show();
            if(result.hasErrors()){
                errorView.getModel().replace("error", Objects.requireNonNull(result.getFieldError("name")).getDefaultMessage());
                return errorView;
            } else if (exerciseService.exist(lookupCodeService.find(form.getTypeId()), form.getName())){
                errorView.getModel().replace("error", "Már létezik ilyen gyakorlat!");
                return errorView;
            } else {
                Exercise exercise = (isNull(form.getId())) ? new Exercise() : exerciseService.find(form.getId());
                exercise.setName(form.getName());
                exercise.setOrganization(userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization());
                exercise.setType(lookupCodeService.find(form.getTypeId()));
                exerciseService.mergeFlush(exercise);
            }
        }
        return show();
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(Integer id) {
        if(hasPermission(Permissions.EXERCISE_CREATE) && Objects.nonNull(id) && exerciseService.exist(id)) {
            exerciseService.delete(exerciseService.find(id));
            exerciseService.flush();
        }
        return "redirect:/training/exercise";
    }
}
