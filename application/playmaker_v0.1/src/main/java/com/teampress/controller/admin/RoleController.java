package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.system.Role;
import com.teampress.database.service.system.RoleService;
import com.teampress.form.RoleForm;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

@Controller
@RequestMapping("/priv/role")
public class RoleController extends BaseController {

    private RoleService roleService;

    public RoleController(RoleService roleService) {
        this.roleService = roleService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Role", "model", new RoleForm());
            view.addObject("datas", roleService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("model") RoleForm form, BindingResult result, HttpServletRequest request){
        if(hasPermission(Permissions.ADMIN)) {
            Role r = Objects.nonNull(form.getId()) ? roleService.find(form.getId()) : new Role();
            r.setDescription(form.getDescription());
            r.setName(form.getName());
            roleService.mergeFlush(r);
        }
        return "redirect:/priv/role";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)) {
            Role r = roleService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            try {
                json.put("id", r.getId());
                json.put("name", r.getName());
                json.put("desc", r.getDescription());
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "redirect:/priv/role";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            Role r = roleService.find(Integer.parseInt(id));
            if (Objects.nonNull(r)) {
                roleService.delete(r);
                roleService.flush();
            }
        }
        return "redirect:/priv/role";
    }
}
