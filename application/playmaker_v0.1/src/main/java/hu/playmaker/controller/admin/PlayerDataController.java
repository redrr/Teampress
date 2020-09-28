package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.databank.PlayerDataService;
import hu.playmaker.form.BaseForm;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@Controller
@RequestMapping("/db/playerdata")
public class PlayerDataController extends BaseController {

    private PlayerDataService playerDataService;

    public PlayerDataController(PlayerDataService playerDataService) {
        this.playerDataService = playerDataService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/PlayerData");
            view.addObject("datas",playerDataService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
