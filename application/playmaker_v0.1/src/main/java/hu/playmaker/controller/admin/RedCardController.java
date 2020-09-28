package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.databank.RedCardService;
import hu.playmaker.form.BaseForm;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@Controller
@RequestMapping("/db/red")
public class RedCardController extends BaseController {

    private RedCardService redCardService;

    public RedCardController(RedCardService redCardService) {
        this.redCardService = redCardService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/RedCard");
            view.addObject("datas",redCardService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
