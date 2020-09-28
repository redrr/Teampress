package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.Parameter;
import hu.playmaker.database.service.system.ParameterService;
import hu.playmaker.form.BaseForm;
import hu.playmaker.form.ParameterForm;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

@Controller
@RequestMapping("/sys/param")
public class ParameterController extends BaseController {

    private ParameterService parameterService;

    public ParameterController(ParameterService parameterService) {
        this.parameterService = parameterService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Parameter", "model", new ParameterForm());
            view.addObject("datas",parameterService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("model") ParameterForm form, BindingResult result, HttpServletRequest request){
        if(hasPermission(Permissions.ADMIN)){
            Parameter p = Objects.nonNull(form.getId()) ? parameterService.find(form.getId()) : new Parameter();
            p.setAttr1(form.getAttr1());
            p.setAttr2(form.getAttr2());
            p.setAttr3(form.getAttr3());
            p.setAttr4(form.getAttr4());
            p.setAttr5(form.getAttr5());
            p.setCode(form.getCode());
            p.setGroup(form.getGroup());
            p.setValue(form.getValue());
            parameterService.mergeFlush(p);
        }
        return "redirect:/sys/param";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            Parameter p = parameterService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            try {
                json.put("a1", p.getAttr1());
                json.put("a2", p.getAttr2());
                json.put("a3", p.getAttr3());
                json.put("a4", p.getAttr4());
                json.put("a5", p.getAttr5());
                json.put("code", p.getCode());
                json.put("group", p.getGroup());
                json.put("value", p.getValue());
                json.put("id", p.getId());
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "redirect:/sys/param";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            Parameter p = parameterService.find(Integer.parseInt(id));
            parameterService.delete(p);
            parameterService.flush();
        }
        return "redirect:/sys/param";
    }
}
