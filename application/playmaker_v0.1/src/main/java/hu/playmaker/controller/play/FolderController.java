package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.model.trainingplan.Exercise;
import hu.playmaker.database.model.videoanalytics.Folder;
import hu.playmaker.database.service.system.ParameterService;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.database.service.videoanalytics.FolderService;
import hu.playmaker.form.ExerciseForm;
import hu.playmaker.form.FolderForm;
import hu.playmaker.form.VideoAnalyticsForm;
import hu.playmaker.form.validator.ExerciseFormValidator;
import hu.playmaker.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;

import static java.util.Objects.isNull;

@Controller
@RequestMapping("/folder")
public class FolderController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private FolderService folderService;
    private ParameterService parameterService;

    public FolderController(UserService userService, UserOrganizationService userOrganizationService, FolderService folderService, ParameterService parameterService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.folderService = folderService;
        this.parameterService = parameterService;
    }

    @RequestMapping("")
    public ModelAndView show(){
        if(hasPermission(Permissions.VIDEO_ANALYTICS)) {
            ModelAndView view = new ModelAndView("play/Folder", "modifyFolder", new FolderForm());
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(user).getOrganization();
            view.addObject("folders", folderService.findByOrg(organization));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String doSubmit(@Valid @ModelAttribute("modifyFolder") FolderForm form, BindingResult result, HttpServletRequest request) {
        if(hasPermission(Permissions.EXERCISE_CREATE)) {
            String uploadFolder = parameterService.findParameterByGroupAndCode("SYSTEM", "FOLDER_IMG").getValue();
            if(form.getName().trim().equals("") || form.getBgImg().isEmpty() || !form.getBgImg().getContentType().contains("image"))
                return "redirect:/folder";
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(user).getOrganization();
            Folder folder = (Objects.isNull(form.getId())) ? new Folder() : folderService.find(form.getId());
            folder.setOrganization(organization);
            folder.setName(form.getName());
            folder.setDescription(form.getDesc());
            try {
                byte[] bytes = form.getBgImg().getBytes();
                Path path = Paths.get(uploadFolder+user.getUsername()+"_"+form.getBgImg().getOriginalFilename());
                Files.write(path, bytes);
                folder.setUrl(user.getUsername()+"_"+form.getBgImg().getOriginalFilename());
            } catch (Exception e){
                e.printStackTrace();
                return "redirect:/folder";
            }
            folderService.mergeFlush(folder);
        }
        return "redirect:/folder";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(Integer id) {
        if(hasPermission(Permissions.EXERCISE_CREATE) && Objects.nonNull(id) && folderService.exist(id)) {
            folderService.delete(folderService.find(id));
            folderService.flush();
        }
        return "redirect:/exercise";
    }
}
