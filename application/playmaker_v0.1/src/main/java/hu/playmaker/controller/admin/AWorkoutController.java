package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.workout.JelenletService;
import hu.playmaker.database.service.workout.WorkoutService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/wk/workout")
public class AWorkoutController extends BaseController {

    private WorkoutService workoutService;

    public AWorkoutController(WorkoutService workoutService) {
        this.workoutService = workoutService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Workout");
            view.addObject("datas", workoutService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
