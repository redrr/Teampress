package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.trainingplan.ExerciseService;
import hu.playmaker.database.service.trainingplan.TrainingPlanService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/train/plans")
public class ATrainingPlanController extends BaseController {

    private TrainingPlanService trainingPlanService;

    public ATrainingPlanController(TrainingPlanService trainingPlanService) {
        this.trainingPlanService = trainingPlanService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/TrainingPlan");
            view.addObject("datas", trainingPlanService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
