package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.service.system.LookupCodeService;
import com.teampress.form.LookupCodeForm;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

@Controller
@RequestMapping("/sys/lookup")
public class LookupCodeController extends BaseController {

    private LookupCodeService lookupCodeService;

    public LookupCodeController(LookupCodeService lookupCodeService) {
        this.lookupCodeService = lookupCodeService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/LookupCode", "model", new LookupCodeForm());
            view.addObject("datas", lookupCodeService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("model") LookupCodeForm form, BindingResult result, HttpServletRequest request){
        if(hasPermission(Permissions.ADMIN)) {
            LookupCode l = Objects.nonNull(form.getId()) ? lookupCodeService.find(form.getId()) : new LookupCode();
            l.setName(form.getName());
            l.setCode(form.getCode());
            l.setLgroup(form.getLgroup());
            l.setDescription(form.getDescription());
            lookupCodeService.mergeFlush(l);
        }
        return "redirect:/sys/lookup";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            LookupCode l = lookupCodeService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            try {
                json.put("id", Objects.nonNull(l.getId()) ? l.getId() : "");
                json.put("name", Objects.nonNull(l.getName()) ? l.getName() : "");
                json.put("lgroup", Objects.nonNull(l.getLgroup()) ? l.getLgroup() : "");
                json.put("code", Objects.nonNull(l.getCode()) ? l.getCode() : "");
                json.put("description", Objects.nonNull(l.getDescription()) ? l.getDescription() : "");
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "redirect:/sys/lookup";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)) {
            LookupCode l = lookupCodeService.find(Integer.parseInt(id));
            lookupCodeService.delete(l);
            lookupCodeService.flush();
        }
        return "redirect:/sys/lookup";
    }
}
