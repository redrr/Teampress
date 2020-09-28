package hu.playmaker.controller.basic;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@RequestMapping("/logout")
@Controller
public class LogoutController {

    @RequestMapping(method = RequestMethod.GET)
    public String doLogout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/login";
    }
}
