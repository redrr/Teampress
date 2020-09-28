package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.index.CalendarService;
import hu.playmaker.database.service.workout.JelenletService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/wk/jelen")
public class JelenController extends BaseController {

    private JelenletService jelenletService;

    public JelenController(JelenletService jelenletService) {
        this.jelenletService = jelenletService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Jelen");
            view.addObject("datas", jelenletService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
