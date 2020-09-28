package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.financial.IncomeGroupService;
import hu.playmaker.database.service.financial.IncomeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/fin/group")
public class AGroupController extends BaseController {

    private IncomeGroupService incomeGroupService;

    public AGroupController(IncomeGroupService incomeGroupService) {
        this.incomeGroupService = incomeGroupService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/IncomeGroup");
            view.addObject("datas", incomeGroupService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
