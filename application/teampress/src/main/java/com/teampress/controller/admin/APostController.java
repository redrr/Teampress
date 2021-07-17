package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.service.index.UserPostService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/event/post")
public class APostController extends BaseController {

    private UserPostService userPostService;

    public APostController(UserPostService userPostService) {
        this.userPostService = userPostService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Post");
            view.addObject("datas", userPostService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
