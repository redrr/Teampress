package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.service.financial.IncomeGroupConnectionService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/fin/groupconn")
public class AGroupConnController extends BaseController {

    private IncomeGroupConnectionService incomeGroupConnectionService;

    public AGroupConnController(IncomeGroupConnectionService incomeGroupConnectionService) {
        this.incomeGroupConnectionService = incomeGroupConnectionService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/IncomeGroupConn");
            view.addObject("datas", incomeGroupConnectionService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
