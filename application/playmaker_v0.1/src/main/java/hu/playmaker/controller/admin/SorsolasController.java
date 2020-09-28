package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.databank.SorsolasService;
import hu.playmaker.form.BaseForm;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@Controller
@RequestMapping("/db/sors")
public class SorsolasController extends BaseController {

    private SorsolasService sorsolasService;

    public SorsolasController(SorsolasService sorsolasService) {
        this.sorsolasService = sorsolasService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Sorsolas");
            view.addObject("datas",sorsolasService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
