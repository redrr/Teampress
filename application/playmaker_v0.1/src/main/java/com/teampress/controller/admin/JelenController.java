package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.service.workout.AttendanceService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/train/jelen")
public class JelenController extends BaseController {

    private AttendanceService attendanceService;

    public JelenController(AttendanceService attendanceService) {
        this.attendanceService = attendanceService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Jelen");
            view.addObject("datas", attendanceService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
