package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.model.videoanalytics.Folder;
import hu.playmaker.database.model.videoanalytics.Scene;
import hu.playmaker.database.model.videoanalytics.Video;
import hu.playmaker.database.model.videoanalytics.VideoEditor;
import hu.playmaker.database.service.databank.SorsolasService;
import hu.playmaker.database.service.gameplan.CustomGameService;
import hu.playmaker.database.service.system.LookupCodeService;
import hu.playmaker.database.service.system.ParameterService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.database.service.trainingplan.TrainingPlanService;
import hu.playmaker.database.service.videoanalytics.FolderService;
import hu.playmaker.database.service.videoanalytics.SceneService;
import hu.playmaker.database.service.videoanalytics.VideoEditorService;
import hu.playmaker.database.service.videoanalytics.VideoService;
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
    private LookupCodeService lookupCodeService;
    private ParameterService parameterService;
    private VideoService videoService;

    public VideoAnalyticsController(UserService userService, UserOrganizationService userOrganizationService, LookupCodeService lookupCodeService, ParameterService parameterService, VideoService videoService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.lookupCodeService = lookupCodeService;
        this.parameterService = parameterService;
        this.videoService = videoService;
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

    public String createAction(@RequestParam String id, @RequestParam String time, @RequestParam String data) {
        return "";
    }
}
