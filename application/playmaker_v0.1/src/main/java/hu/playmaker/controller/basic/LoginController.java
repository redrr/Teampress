package hu.playmaker.controller.basic;

import hu.playmaker.database.model.system.RolePrivilege;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.system.RolePrivilegeService;
import hu.playmaker.database.service.system.UserRoleService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.form.LoginForm;
import hu.playmaker.handler.SessionHandler;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import java.util.ArrayList;

import static java.util.Objects.isNull;

@Controller
@RequestMapping("/login")
public class LoginController {

    UserService userService;
    UserRoleService userRoleService;
    RolePrivilegeService rolePrivilegeService;

    public LoginController(UserService userService, UserRoleService userRoleService, RolePrivilegeService rolePrivilegeService) {
        this.userService = userService;
        this.userRoleService = userRoleService;
        this.rolePrivilegeService = rolePrivilegeService;
    }

    @RequestMapping(method = RequestMethod.GET)
    protected ModelAndView showForm(@RequestParam(name = "redirected", required = false) String redirected) {
        return new ModelAndView("Login", "login", new LoginForm());
    }

    @RequestMapping(method = RequestMethod.POST)
    protected String doLogin(@Valid @ModelAttribute("login") LoginForm login, BindingResult result, HttpServletRequest request, HttpServletResponse response) {
        if (!isNull(SessionHandler.getUsernameFromCurrentSession())) {
            return "/";
        }
        if (result.hasErrors()) {
            return "/login";
        }
        request.getSession().invalidate();
        User user = userService.findEnabledUserByUsername(login.getUsername());
        if(!isNull(user) && BCrypt.checkpw(login.getPassword(), user.getPassword())) {
            try{
                request.getSession().setAttribute("username", user.getUsername());
                ArrayList<String> permissions = new ArrayList<>();
                ArrayList<String> roles = new ArrayList<>();
                for(RolePrivilege rp : rolePrivilegeService.findAllByRoleId(userRoleService.findAllByUserId(user.getId()).get(0).getRole().getId())) {
                    permissions.add(rp.getPrivilege().getName());
                    roles.add(rp.getRole().getName());
                }
                request.getSession().setAttribute("permissions", permissions );
                request.getSession().setAttribute("roles", roles);
                return "redirect:/";
            } catch (Exception e) {
                //todo: into exception
                e.printStackTrace();
                return "redirect:/";
            }
        }
        return "redirect:/login";
    }
}
