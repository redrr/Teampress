package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.model.videoanalytics.Scene;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.database.service.videoanalytics.FolderService;
import hu.playmaker.database.service.videoanalytics.SceneService;
import hu.playmaker.form.VideoAnalyticsForm;
import hu.playmaker.handler.SessionHandler;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("/videocloud")
public class VideoCloudController extends BaseController {

    private FolderService folderService;
    private UserOrganizationService userOrganizationService;
    private UserService userService;
    private SceneService sceneService;

    public VideoCloudController(FolderService folderService, UserOrganizationService userOrganizationService, UserService userService, SceneService sceneService) {
        this.folderService = folderService;
        this.userOrganizationService = userOrganizationService;
        this.userService = userService;
        this.sceneService = sceneService;
    }

    @RequestMapping("")
    public ModelAndView show(){
        if(hasPermission(Permissions.VIDEO_CLOUD) || hasPermission(Permissions.VIDEO_ANALYTICS)) {
            ModelAndView view = new ModelAndView("play/VideoCloud");
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(user).getOrganization();
            view.addObject("folders", folderService.findByOrg(organization));
            view.addObject("isFolderPage", true);
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping("/{id}")
    public ModelAndView folder(@PathVariable String id){
        if(hasPermission(Permissions.VIDEO_CLOUD) || hasPermission(Permissions.VIDEO_ANALYTICS)) {
            ModelAndView view = show();
            view.getModel().replace("isFolderPage", false);
            view.addObject("videos", sceneService.find(folderService.find(Integer.parseInt(id))));
            view.addObject("currentFolder", folderService.find(Integer.parseInt(id)));
            return view;
        }
        return new ModelAndView("403");
    }
}
