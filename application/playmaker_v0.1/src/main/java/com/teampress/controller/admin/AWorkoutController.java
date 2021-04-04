package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.service.workout.WorkoutService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/train/workout")
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
