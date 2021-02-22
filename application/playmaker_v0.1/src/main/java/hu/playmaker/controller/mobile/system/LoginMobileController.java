package hu.playmaker.controller.mobile.system;

import hu.playmaker.controller.mobile.MobileController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginMobileController extends MobileController {

    @GetMapping("/mobile/login")
    public String login() {
        return "Success";
    }
}
