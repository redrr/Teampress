package hu.playmaker.controller.admin;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.gameplan.CustomGameService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/game/customgames")
public class CustomGameController extends BaseController {

    private CustomGameService customGameService;

    public CustomGameController(CustomGameService customGameService) {
        this.customGameService = customGameService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/CustomGame");
            view.addObject("datas", customGameService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
