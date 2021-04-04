package com.teampress.controller.mobile.system;

import com.teampress.controller.mobile.MobileController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class LoginMobileController extends MobileController {

    @GetMapping("/mobile/login")
    public String login() {
        return "Success";
    }
}
