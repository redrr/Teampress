package com.teampress.controller.admin;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.service.index.CalendarService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/event/calendar")
public class ACalendarController extends BaseController {

    private CalendarService calendarService;

    public ACalendarController(CalendarService calendarService) {
        this.calendarService = calendarService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Calendar");
            view.addObject("datas", calendarService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
