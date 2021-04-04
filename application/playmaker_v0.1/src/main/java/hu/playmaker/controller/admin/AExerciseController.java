package hu.playmaker.controller.admin;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.trainingplan.ExerciseService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/train/exercise")
public class AExerciseController extends BaseController {

    private ExerciseService exerciseService;

    public AExerciseController(ExerciseService exerciseService) {
        this.exerciseService = exerciseService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Exercise");
            view.addObject("datas", exerciseService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
