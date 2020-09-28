package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.databank.RedCardService;
import hu.playmaker.database.service.databank.YellowCardService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/db/yellow")
public class YellowCardController extends BaseController {

    private YellowCardService yellowCardService;

    public YellowCardController(YellowCardService yellowCardService) {
        this.yellowCardService = yellowCardService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/YellowCard");
            view.addObject("datas", yellowCardService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
