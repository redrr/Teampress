package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.model.videoanalytics.*;
import hu.playmaker.database.service.databank.SorsolasService;
import hu.playmaker.database.service.gameplan.CustomGameService;
import hu.playmaker.database.service.system.LookupCodeService;
import hu.playmaker.database.service.system.ParameterService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.database.service.trainingplan.TrainingPlanService;
import hu.playmaker.database.service.videoanalytics.*;
import hu.playmaker.form.VideoAnalyticsForm;
import hu.playmaker.handler.SessionHandler;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Controller
@RequestMapping("/videoanalytics")
public class VideoAnalyticsController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private ParameterService parameterService;
    private VideoService videoService;
    private AnalyticsActionService analyticsActionService;

    public VideoAnalyticsController(UserService userService, UserOrganizationService userOrganizationService, ParameterService parameterService, VideoService videoService, AnalyticsActionService analyticsActionService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.parameterService = parameterService;
        this.videoService = videoService;
        this.analyticsActionService = analyticsActionService;
    }

    @RequestMapping("")
    public ModelAndView show(){
        if(hasPermission(Permissions.VIDEO_ANALYTICS)) {
            ModelAndView view = new ModelAndView("play/VideoAnalytics", "video", new VideoAnalyticsForm());
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            UserOrganization userOrganization = userOrganizationService.getOrgByUser(currentUser);
            view.addObject("data", videoService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String doSubmit(@Valid @ModelAttribute("video") VideoAnalyticsForm form, BindingResult result, HttpServletRequest request) {
        if(hasPermission(Permissions.VIDEO_ANALYTICS)) {
            String uploadFolder = parameterService.findParameterByGroupAndCode("SYSTEM", "UPLOAD_FOLDER").getValue();
            if(!form.getVideo().isEmpty() && form.getVideo().getContentType().contains("mp4")){
                Video video = new Video();
                String fileName = UUID.randomUUID()+".mp4";
                try {
                    byte[] bytes = form.getVideo().getBytes();
                    Path path = Paths.get(uploadFolder+fileName);
                    Files.write(path, bytes);
                    video.setName(fileName);
                } catch (Exception e){
                    e.printStackTrace();
                }
                videoService.mergeFlush(video);
            }
        }
        return "redirect:/videoanalytics";
    }


    @RequestMapping(method = RequestMethod.POST, value = "/getActionsAsArray")
    @ResponseBody
    public String getActionList(@RequestParam String videoId) {
        if(hasPermission(Permissions.VIDEO_ANALYTICS)) {
            if(videoId.trim().equals(""))   return "[]";
            Video video = videoService.find(Integer.parseInt(videoId));
            List<AnalyticsAction> analyticsActions = analyticsActionService.findBySourceVideo(video);
            JSONArray array = new JSONArray();
            try {
                for (AnalyticsAction action : analyticsActions) {
                    array.put(new JSONObject().put("id", action.getId()).put("time", action.getTime()));
                }
            } catch (Exception e) {
                return "[]";
            }
            return array.toString();
        }
        return "redirect:/403";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/getActionBlueprint")
    @ResponseBody
    public String getActionBlueprint(@RequestParam String analyticsActionId) {
        if(hasPermission(Permissions.VIDEO_ANALYTICS)) {
            if(!analyticsActionId.trim().equals("") && analyticsActionService.exist(Integer.parseInt(analyticsActionId))) {
                AnalyticsAction action = analyticsActionService.find(Integer.parseInt(analyticsActionId));
                return action.getBluePrint();
            }
            return "Empty Blueprint!";
        }
        return "redirect:/403";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/recordAction")
    @ResponseBody
    public String recordAction(@RequestParam String videoId, @RequestParam String time, @RequestParam String bluePrint){
        if(hasPermission(Permissions.VIDEO_ANALYTICS)) {
            if(videoId.trim().equals(""))   return "Video is missing!";
            Video video = videoService.find(Integer.parseInt(videoId));
            if(Objects.isNull(video))   return "Invalid video!";
            if(time.trim().equals(""))  return "Time is missing!";
            if(bluePrint.trim().equals("")) return "Analysis is missing!";
            try {
                AnalyticsAction action = new AnalyticsAction();
                action.setSourceVideo(video);
                action.setTime(time);
                action.setBluePrint(bluePrint);
                analyticsActionService.mergeFlush(action);
            } catch (Exception e) {
                return "Creation failed!";
            }
            return "";
        }
        return "redirect:/403";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    @ResponseBody
    public String deleteAction(@RequestParam String analyticsActionId) {
        if(hasPermission(Permissions.VIDEO_ANALYTICS)) {
            if(!analyticsActionId.trim().equals("") && analyticsActionService.exist(Integer.parseInt(analyticsActionId))) {
                try {
                    AnalyticsAction action = analyticsActionService.find(Integer.parseInt(analyticsActionId));
                    analyticsActionService.delete(action);
                } catch (Exception e) {
                    return "Delete failed!";
                }
                return "";
            }
            return "Delete failed!";
        }
        return "redirect:/403";
    }
}
