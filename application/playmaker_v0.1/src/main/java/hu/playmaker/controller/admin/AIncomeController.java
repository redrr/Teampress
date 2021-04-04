package hu.playmaker.controller.admin;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.financial.IncomeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/fin/income")
public class AIncomeController extends BaseController {

    private IncomeService incomeService;

    public AIncomeController(IncomeService incomeService) {
        this.incomeService = incomeService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Income");
            view.addObject("datas", incomeService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
