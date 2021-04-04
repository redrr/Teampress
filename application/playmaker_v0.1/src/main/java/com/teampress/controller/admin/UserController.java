package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.system.User;
import com.teampress.database.service.system.UserService;
import com.teampress.form.UserForm;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

@Controller
@RequestMapping("/usr/user")
public class UserController extends BaseController {

    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/User", "model", new UserForm());
            view.addObject("datas",userService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("model") UserForm form, BindingResult result, HttpServletRequest request){
        if(hasPermission(Permissions.ADMIN)){
            User u = Objects.nonNull(form.getId()) ? userService.find(form.getId()) : new User();
            u.setUsername(form.getUsername());
            u.setName(form.getName());
            u.setPassword(form.getPassword());
            u.setEmail(form.getEmail());
            u.setPhoneNumber(form.getPhone());
            u.setPlayer(form.isPlayer());
            u.setEnabled(form.isEnabled());
            u.setDeleted(form.isDeleted());
            userService.mergeFlush(u);
        }
        return "redirect:/usr/user";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            User u = userService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            try {
                json.put("id", u.getId());
                json.put("un", u.getUsername());
                json.put("n", u.getName());
                json.put("em", u.getEmail());
                json.put("ph", u.getPhoneNumber());
                json.put("p", u.isPlayer());
                json.put("e", u.isEnabled());
                json.put("d", u.isDeleted());
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "redirect:/usr/user";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            User u = userService.find(Integer.parseInt(id));
            userService.delete(u);
            userService.flush();
        }
        return "redirect:/usr/user";
    }
}
