package hu.playmaker.controller.play;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.databank.Sorsolas;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.model.trainingplan.TrainingPlan;
import hu.playmaker.database.model.videoanalytics.Folder;
import hu.playmaker.database.model.videoanalytics.Scene;
import hu.playmaker.database.model.videoanalytics.Video;
import hu.playmaker.database.model.videoanalytics.VideoEditor;
import hu.playmaker.database.service.databank.LigaService;
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
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Controller
@RequestMapping("/videoeditor")
public class VideoEditorController extends BaseController {

    private SorsolasService sorsolasService;
    private CustomGameService customGameService;
    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private VideoService videoService;
    private VideoEditorService videoEditorService;
    private TrainingPlanService trainingPlanService;
    private FolderService folderService;
    private SceneService sceneService;
    private LookupCodeService lookupCodeService;
    private ParameterService parameterService;

    public VideoEditorController(SorsolasService sorsolasService, CustomGameService customGameService, UserService userService, UserOrganizationService userOrganizationService, VideoService videoService, VideoEditorService videoEditorService, TrainingPlanService trainingPlanService, FolderService folderService, SceneService sceneService, LookupCodeService lookupCodeService, ParameterService parameterService) {
        this.sorsolasService = sorsolasService;
        this.customGameService = customGameService;
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.videoService = videoService;
        this.videoEditorService = videoEditorService;
        this.trainingPlanService = trainingPlanService;
        this.folderService = folderService;
        this.sceneService = sceneService;
        this.lookupCodeService = lookupCodeService;
        this.parameterService = parameterService;
    }

    @RequestMapping("")
    public ModelAndView show(){
        if(hasPermission(Permissions.VIDEO_ANALYTICS)) {
            ModelAndView view = new ModelAndView("play/VideoEditor", "video", new VideoAnalyticsForm());
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            UserOrganization userOrganization = userOrganizationService.getOrgByUser(currentUser);
            view.addObject("sors", sorsolasService.getLigaAndTeam(userOrganization.getLiga(), userOrganization.getOrganization().getName()));
            view.addObject("other", customGameService.find(userOrganization.getOrganization()));
            view.addObject("data", videoEditorService.find(userOrganization.getOrganization()));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String doSubmit(@Valid @ModelAttribute("video") VideoAnalyticsForm form, BindingResult result, HttpServletRequest request) {
        if(hasPermission(Permissions.VIDEO_ANALYTICS)) {
            String uploadFolder = parameterService.findParameterByGroupAndCode("SYSTEM", "UPLOAD_FOLDER").getValue();
            if(!form.getVideo().isEmpty() && (Objects.nonNull(form.getCustomId()) || Objects.nonNull(form.getSorsId())) && form.getVideo().getContentType().contains("mp4")){
                Video video = new Video();
                int id = (Objects.nonNull(form.getCustomId())) ? form.getCustomId() : form.getSorsId();
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

                VideoEditor videoEditor = new VideoEditor();
                videoEditor.setVideo(videoService.find(fileName));
                if(Objects.nonNull(form.getSorsId())){
                    videoEditor.setTeam(lookupCodeService.findLookupCodeByLgroupAndCode("TEAM_TYPE",sorsolasService.findById(form.getSorsId()).getLiga().getTeam()));
                    videoEditor.setLigaGame(sorsolasService.findById(form.getSorsId()));
                }
                if(Objects.nonNull(form.getCustomId())) {
                    videoEditor.setCustomGame(customGameService.find(form.getCustomId()));
                    videoEditor.setTeam(customGameService.find(form.getCustomId()).getTeam());
                }
                if(Objects.nonNull(form.getTrainingId())){
                    videoEditor.setTeam(trainingPlanService.find(form.getTrainingId()).getTeam());
                    videoEditor.setTraining(trainingPlanService.find(form.getTrainingId()));
                }
                videoEditor.setOrganization(userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession())).getOrganization());
                videoEditorService.mergeFlush(videoEditor);
            }
        }
        return "redirect:/videoeditor";
    }

    @RequestMapping(value = "/cut" ,method = RequestMethod.POST)
    @ResponseBody
    public String doCut(@RequestParam("videoId") String videoId, @RequestParam("folderId") String folderId, @RequestParam("userId") String userId, @RequestParam("start") String start, @RequestParam("end") String end, @RequestParam("name") String name, @RequestParam("desc") String desc) {
        if(hasPermission(Permissions.VIDEO_ANALYTICS)){
            String uploadFolder = parameterService.findParameterByGroupAndCode("SYSTEM", "UPLOAD_FOLDER").getValue();
            String sceneFolder = parameterService.findParameterByGroupAndCode("SYSTEM", "SCENE_FOLDER").getValue();

            VideoEditor videoEditor = videoEditorService.find(videoService.find(Integer.parseInt(videoId))).get(0);
            Scene scene = new Scene();
            Folder folder = folderService.find(Integer.parseInt(folderId));
            scene.setFolder(folder);
            scene.setName(name);
            scene.setDescription(desc);
            scene.setOrganization(videoEditor.getOrganization());
            scene.setTeam(videoEditor.getTeam());
            scene.setUser(userService.find(Integer.parseInt(userId)));

            Video video = new Video();
            int startTime = (int) Double.parseDouble(start);
            int endTime = (int) Double.parseDouble(end);
            try {
                Runtime rt = Runtime.getRuntime();
                String sceneVideoName = UUID.randomUUID().toString();
                String[] cmd={"ffmpeg","-ss" , startTime+"","-i", uploadFolder+videoEditor.getVideo().getName(), "-t", (endTime-startTime)+"", "-c", "copy", sceneFolder+ sceneVideoName+".mp4"};
                Process p = rt.exec(cmd);
                BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
                String line;
                while (true) {
                    line = r.readLine();
                    if (line == null) { break; }
                    System.out.println(line);
                }
                video.setName(sceneVideoName+".mp4");
                videoService.mergeFlush(video);

                scene.setVideo(videoService.find(sceneVideoName+".mp4"));
                sceneService.mergeFlush(scene);
                return "done";
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "";
    }

    @RequestMapping(value = "/getusers", method = RequestMethod.POST)
    @ResponseBody
    public String getUsers(@RequestParam String videoId){
        if(hasPermission(Permissions.VIDEO_ANALYTICS)){
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
            LookupCode team = videoEditorService.find(videoService.find(Integer.parseInt(videoId))).get(0).getTeam();
            List<UserOrganization> userOrganizationList = userOrganizationService.getUsersByOrgIfPlayer(organization, team);
            try{
                JSONArray array = new JSONArray();
                for(UserOrganization userOrganization : userOrganizationList) {
                    JSONObject json = new JSONObject();
                    json.put("id", userOrganization.getUser().getId());
                    json.put("name", userOrganization.getUser().getName());
                    array.put(json);
                }
                return array.toString();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "";
    }

    @RequestMapping(value = "/getfolders", method = RequestMethod.POST)
    @ResponseBody
    public String getFolders(@RequestParam String videoId){
        if(hasPermission(Permissions.VIDEO_ANALYTICS)){
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
            List<Folder> folderList = folderService.findByOrg(organization);
            try{
                JSONArray array = new JSONArray();
                for(Folder folder : folderList) {
                    JSONObject json = new JSONObject();
                    json.put("id", folder.getId());
                    json.put("name", folder.getName());
                    array.put(json);
                }
                return array.toString();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "";
    }
}
