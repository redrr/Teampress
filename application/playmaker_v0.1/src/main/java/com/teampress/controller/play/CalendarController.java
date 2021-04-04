package com.teampress.controller.play;

import com.teampress.common.enums.LGroups;
import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.index.Calendar;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.service.index.CalendarService;
import com.teampress.database.service.system.LookupCodeService;
import com.teampress.database.service.system.UserOrganizationService;
import com.teampress.database.service.system.UserService;
import com.teampress.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/calendar")
public class CalendarController extends BaseController {

    private CalendarService calendarService;
    private UserOrganizationService userOrganizationService;
    private UserService userService;
    private LookupCodeService lookupCodeService;

    public CalendarController(CalendarService calendarService, UserOrganizationService userOrganizationService, UserService userService, LookupCodeService lookupCodeService) {
        this.calendarService = calendarService;
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
        this.lookupCodeService = lookupCodeService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.LOGGED_IN) && !hasPermission(Permissions.ADMIN)) {
            ModelAndView view = new ModelAndView("play/Calendar");
            view.addObject("teams", userOrganizationService.getOrgListByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String doSubmit(@RequestParam String date, @RequestParam String name, @RequestParam String type) {
        if(hasPermission(Permissions.EVENT_CREATE) && !date.trim().equals("") && !name.trim().equals("") && !type.trim().equals("")) {
            UserOrganization userOrganization = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
            Calendar event = new Calendar();
            event.setEndDateTime(date.replace("/", "-"));
            event.setStartDateTime(date.replace("/", "-"));
            event.setEventName(name);
            event.setOrganization(userOrganization.getOrganization());
            if(!type.equals("0")) {
                event.setTeam(lookupCodeService.find(Integer.parseInt(type)));
                calendarService.mergeFlush(event);
            } else {
                List<LookupCode> teams = lookupCodeService.findAllLookupByLgroup(LGroups.TEAM_TYPE.name());
                for (LookupCode team : teams) {
                    Calendar singleEvent = event;
                    singleEvent.setTeam(team);
                    calendarService.mergeFlush(singleEvent);
                }
            }
        }
        return "redirect:/calendar";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/getevents")
    @ResponseBody
    public String getEvents() {
        if(hasPermission(Permissions.LOGGED_IN)){
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            List<UserOrganization> userOrganizations = userOrganizationService.getOrgListByUser(currentUser);
            StringBuilder events = new StringBuilder();
            boolean seenOrganization = false;
            for (UserOrganization userOrganization : userOrganizations) {
                if(!seenOrganization){
                    events.append(calendarService.getEventsAsJSON(userOrganization.getOrganization()));
                    seenOrganization = true;
                }
                events.append(calendarService.getEventsAsJSON(userOrganization.getOrganization(), userOrganization.getType()));
            }
            return "[\n" +events.toString()+ "]";
        }
        return "[]";
    }
}
