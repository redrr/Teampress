package hu.playmaker.controller.admin;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.system.LogService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/sys/log")
public class LogController extends BaseController {

    private LogService logService;

    public LogController(LogService logService) {
        this.logService = logService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Log");
            view.addObject("datas", logService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
