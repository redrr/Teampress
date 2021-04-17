package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.system.Organization;
import com.teampress.database.service.system.OrganizationService;
import com.teampress.form.OrganizationForm;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

@Controller
@RequestMapping("/org/organization")
public class OrganizationController extends BaseController {

    private OrganizationService organizationService;

    public OrganizationController(OrganizationService organizationService) {
        this.organizationService = organizationService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Organization", "model", new OrganizationForm());
            view.addObject("datas", organizationService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("model") OrganizationForm form, BindingResult result, HttpServletRequest request){
        if(hasPermission(Permissions.ADMIN)){
            Organization o = Objects.nonNull(form.getId()) ? organizationService.find(form.getId()) : new Organization();
            o.setName(form.getName());
            o.setType(form.getType());
            organizationService.mergeFlush(o);
        }
        return "redirect:/org/organization";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            Organization o = organizationService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            try {
                json.put("id", o.getId());
                json.put("name", o.getName());
                json.put("type", o.getType());
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "redirect:/org/organization";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            Organization o = organizationService.find(Integer.parseInt(id));
            if (Objects.nonNull(o)) {
                organizationService.delete(o);
                organizationService.flush();
            }
        }
        return "redirect:/org/organization";
    }
}
