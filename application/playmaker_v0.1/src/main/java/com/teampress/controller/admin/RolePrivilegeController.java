package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.system.RolePrivilege;
import com.teampress.database.service.system.PrivilegeService;
import com.teampress.database.service.system.RolePrivilegeService;
import com.teampress.database.service.system.RoleService;
import com.teampress.form.RolePrivilegeForm;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

@Controller
@RequestMapping("/priv/rolepriv")
public class RolePrivilegeController extends BaseController {

    private RolePrivilegeService rolePrivilegeService;
    private RoleService roleService;
    private PrivilegeService privilegeService;

    public RolePrivilegeController(RolePrivilegeService rolePrivilegeService, RoleService roleService, PrivilegeService privilegeService) {
        this.rolePrivilegeService = rolePrivilegeService;
        this.roleService = roleService;
        this.privilegeService = privilegeService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/RolePrivilege", "model", new RolePrivilegeForm());
            view.addObject("datas",rolePrivilegeService.findAll());
            view.addObject("roles",roleService.findAll());
            view.addObject("privs",privilegeService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("model") RolePrivilegeForm form, BindingResult result, HttpServletRequest request){
        if(hasPermission(Permissions.ADMIN)){
            RolePrivilege r = Objects.nonNull(form.getId()) ? rolePrivilegeService.find(form.getId()) : new RolePrivilege();
            r.setPrivilege(privilegeService.find(form.getPrivId()));
            r.setRole(roleService.find(form.getRoleId()));
            rolePrivilegeService.mergeFlush(r);
        }
        return "redirect:/priv/rolepriv";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            RolePrivilege r = rolePrivilegeService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            try {
                json.put("id", r.getId());
                json.put("role", r.getRole().getId());
                json.put("priv", r.getPrivilege().getId());
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "redirect:/priv/rolepriv";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            RolePrivilege r = rolePrivilegeService.find(Integer.parseInt(id));
            rolePrivilegeService.delete(r);
            rolePrivilegeService.flush();
        }
        return "redirect:/priv/rolepriv";
    }
}
