package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.databank.TabellaService;
import hu.playmaker.form.BaseForm;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@Controller
@RequestMapping("/db/tab")
public class TabellaController extends BaseController {

    private TabellaService tabellaService;

    public TabellaController(TabellaService tabellaService) {
        this.tabellaService = tabellaService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Tabella");
            view.addObject("datas",tabellaService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
