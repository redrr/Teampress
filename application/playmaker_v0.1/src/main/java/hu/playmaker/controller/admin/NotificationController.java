package hu.playmaker.controller.admin;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.service.system.UserNotificationService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/sys/notification")
public class NotificationController extends BaseController {

    private UserNotificationService notificationService;

    public NotificationController(UserNotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/Notification");
            view.addObject("datas",notificationService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }
}
