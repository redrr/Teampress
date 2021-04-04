package hu.playmaker.controller.play;

import hu.playmaker.common.enums.LGroups;
import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.index.Calendar;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.service.index.CalendarService;
import hu.playmaker.database.service.system.LookupCodeService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
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
