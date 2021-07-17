package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.system.UserRole;
import com.teampress.database.service.system.RoleService;
import com.teampress.database.service.system.UserRoleService;
import com.teampress.database.service.system.UserService;
import com.teampress.form.UserRoleForm;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

@Controller
@RequestMapping("/usr/userrole")
public class UserRoleController extends BaseController {

    private UserService userService;
    private RoleService roleService;
    private UserRoleService userRoleService;

    public UserRoleController(UserService userService, RoleService roleService, UserRoleService userRoleService) {
        this.userService = userService;
        this.roleService = roleService;
        this.userRoleService = userRoleService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/UserRole", "model", new UserRoleForm());
            view.addObject("datas",userRoleService.findAll());
            view.addObject("role",roleService.findAll());
            view.addObject("user",userService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("model") UserRoleForm form, BindingResult result, HttpServletRequest request){
        if(hasPermission(Permissions.ADMIN)){
            UserRole u = Objects.nonNull(form.getId()) ? userRoleService.find(form.getId()) : new UserRole();
            u.setRole(roleService.find(form.getRoleId()));
            u.setUser(userService.find(form.getUserId()));
            userRoleService.mergeFlush(u);
        }
        return "redirect:/usr/userrole";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            UserRole u = userRoleService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            try {
                json.put("id", u.getId());
                json.put("user", u.getUser().getId());
                json.put("role", u.getRole().getId());
            } catch (Exception e) {
                e.printStackTrace();
            }
            return json.toString();
        }
        return "redirect:/usr/userrole";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            UserRole u = userRoleService.find(Integer.parseInt(id));
            if (Objects.nonNull(u)) {
                userRoleService.delete(u);
                userRoleService.flush();
            }
        }
        return "redirect:/usr/userrole";
    }
}
