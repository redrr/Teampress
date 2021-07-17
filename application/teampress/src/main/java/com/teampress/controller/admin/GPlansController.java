package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.service.gameplan.GamePlanService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/game/plans")
public class GPlansController extends BaseController {

    private GamePlanService gamePlanService;

    public GPlansController(GamePlanService gamePlanService) {
        this.gamePlanService = gamePlanService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/GamePlan");
            view.addObject("datas", gamePlanService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
