package hu.playmaker.controller.basic;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.index.UserPost;
import hu.playmaker.database.model.index.UserPostComment;
import hu.playmaker.database.model.system.*;
import hu.playmaker.database.model.trainingplan.TrainingPlan;
import hu.playmaker.database.service.databank.PlayerDataService;
import hu.playmaker.database.service.databank.SorsolasService;
import hu.playmaker.database.service.databank.TabellaService;
import hu.playmaker.database.service.index.UserPostCommentService;
import hu.playmaker.database.service.index.UserPostService;
import hu.playmaker.database.service.system.*;
import hu.playmaker.database.service.trainingplan.TrainingPlanService;
import hu.playmaker.database.service.workout.JelenletService;
import hu.playmaker.form.IndexForm;
import hu.playmaker.handler.SessionHandler;
import org.apache.commons.collections4.map.LinkedMap;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.*;

@Controller
public class IndexController extends BaseController {

    private PlayerDataService playerDataService;
    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private TabellaService tabellaService;
    private SorsolasService sorsolasService;
    private UserPostService userPostService;
    private UserPostCommentService userPostCommentService;
    private JelenletService jelenletService;
    private UserNotificationService notificationService;
    private TrainerRatingService trainerRatingService;
    private TrainerRatingResultService trainerRatingResultService;
    private TrainingPlanService trainingPlanService;
    private OrgCountryService orgCountryService;
    private static String UPLOADED_FOLDER = "C:\\Projects\\PlaymakerProjects\\playmaker_v0.1\\src\\main\\webapp\\content\\postImages\\";

    public IndexController(PlayerDataService playerDataService, UserService userService, UserOrganizationService userOrganizationService, TabellaService tabellaService, SorsolasService sorsolasService, UserPostService userPostService, UserPostCommentService userPostCommentService, JelenletService jelenletService, UserNotificationService notificationService, TrainerRatingService trainerRatingService, TrainerRatingResultService trainerRatingResultService, TrainingPlanService trainingPlanService, OrgCountryService orgCountryService) {
        this.playerDataService = playerDataService;
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.tabellaService = tabellaService;
        this.sorsolasService = sorsolasService;
        this.userPostService = userPostService;
        this.userPostCommentService = userPostCommentService;
        this.jelenletService = jelenletService;
        this.notificationService = notificationService;
        this.trainerRatingService = trainerRatingService;
        this.trainerRatingResultService = trainerRatingResultService;
        this.trainingPlanService = trainingPlanService;
        this.orgCountryService = orgCountryService;
    }

    @RequestMapping("/redirect")
    public String redirect() {
        return "redirect:/";
    }

    @RequestMapping("/")
    public String can() {
        return SessionHandler.canNavigate(Permissions.LOGGED_IN.name(), "/home");
    }

    @RequestMapping("/home")
    public ModelAndView showIndex() {
        if(hasPermission(Permissions.LOGGED_IN)) {
            ModelAndView view;
            if(hasPermission(Permissions.POST_COMMENT_CREATE)) {
                view = new ModelAndView("Index", "createPost", new IndexForm());
            } else {
                view = new ModelAndView("Index");
            }
            if(hasPermission(Permissions.HOME_HEADER_BUTTONS)){
                UserOrganization uOrg = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
                view.addObject("nextTraining", trainingPlanService.findNext(uOrg.getOrganization(), uOrg.getType()));
                view.addObject("nextTrainingDay", getDay(trainingPlanService.findNext(uOrg.getOrganization(), uOrg.getType())));
                view.addObject("playerHeader", playerDataService.getPlayerHeader(
                        userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()),
                        jelenletService.findLastFiveTrainingJelenByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()))));
                view.addObject("teamHeader", playerDataService.getTeamHeader(uOrg.getOrganization(), tabellaService.getTabellaByTeamAndLiga(uOrg.getLiga(), uOrg.getOrganization().getName())));
                view.addObject("sorsolasHeader", sorsolasService.getSorsolas(uOrg.getLiga(), uOrg.getOrganization().getName()));
                view.addObject("temp", weatherController(uOrg.getOrganization()));
                view.addObject("city", orgCountryService.find(uOrg.getOrganization()).get(0).getCity());
            }
            if(hasPermission(Permissions.POST_COMMENT_READ)) {
                view.addObject("posts", readPosts());
            }
            return view;
        }
        return new ModelAndView("403");
    }

    private String getDay(TrainingPlan trainingPlan) {
        if(Objects.nonNull(trainingPlan)){
            String[] days = {"Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat"};
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(trainingPlan.getRealTrainingDate());
            return days[calendar.get(Calendar.DAY_OF_WEEK)-1];
        }
        return "";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/dopost")
    public String doPost(@Valid @ModelAttribute("createPost") IndexForm form, BindingResult result, HttpServletRequest request) {
        if(hasPermission(Permissions.POST_COMMENT_CREATE) && (Objects.nonNull(form.getFile()) || !form.getPostText().trim().equals(""))){
            UserPost post = new UserPost();
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            post.setUser(user);
            post.setOrganization(userOrganizationService.getOrgByUser(user).getOrganization());
            if(!form.getPostText().trim().equals("")){
                post.setPost("<div class=\"mb-4\">"+form.getPostText()+"</div>");
            }
            if(!form.getFile().isEmpty() && form.getFile().getContentType().contains("image")){
                try {
                    byte[] bytes = form.getFile().getBytes();
                    Path path = Paths.get(UPLOADED_FOLDER+user.getUsername()+"_"+form.getFile().getOriginalFilename());
                    Files.write(path, bytes);
                    post.setImageUrl(user.getUsername()+"_"+form.getFile().getOriginalFilename());
                } catch (Exception e){
                    e.printStackTrace();
                }
            }
            userPostService.mergeFlush(post);
        }
        return "redirect:/";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/docomment")
    public String doComment(Integer userPostId, String comment) {
        if(hasPermission(Permissions.POST_COMMENT_CREATE)){
            UserPostComment p = new UserPostComment();
            p.setUserPost(userPostService.find(userPostId));
            p.setUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
            p.setComment(comment);
            userPostCommentService.mergeFlush(p);
        }
        return "redirect:/";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/getnoti")
    @ResponseBody
    public String getTrainingFormData(){
        JSONObject json = new JSONObject();
        if(hasPermission(Permissions.LOGGED_IN)){
            List<UserNotification> notifications = notificationService.findAllByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
            StringBuilder list = new StringBuilder();
            StringBuilder id = new StringBuilder();
            for (int i = 0; i < notifications.size(); i++){
                UserNotification userNotification = notifications.get(i);
                list.append("/").append(userNotification.getLocation()).append("|").append(userNotification.getCreationDateAsString()).append("|").append(userNotification.getTitle()).append("|").append(userNotification.getDescription());
                id.append(userNotification.getId());
                if(i != notifications.size()-1){
                    list.append(";");
                    id.append(";");
                }
            }
            try {
                json.put("count", notifications.size());
                json.put("list", list);
                json.put("id", id);
            } catch (Exception e){
                e.printStackTrace();
            }
        }
        return json.toString();
    }

    @RequestMapping(method = RequestMethod.POST, value = "/readnotification")
    @ResponseBody
    public String read(@RequestParam("id") String id){
        if(hasPermission(Permissions.LOGGED_IN)){
            if(notificationService.exist(Integer.parseInt(id))){
                UserNotification notification = notificationService.find(Integer.parseInt(id));
                notification.setSeen(true);
                notificationService.mergeFlush(notification);
                return "success";
            } else {
                return "";
            }
        }
        return "";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/getratings")
    @ResponseBody
    public String rating(){
        if(hasPermission(Permissions.LOGGED_IN)){
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            if(trainerRatingService.existByUser(user)) {
                TrainerRating rating = trainerRatingService.findByUser(user);
                return rating.getId().toString();
            } else {
                return "";
            }
        }
        return "";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/sendrating")
    @ResponseBody
    public String sendrating(@RequestParam("id") String idInput, @RequestParam("value") String value){
        if(hasPermission(Permissions.LOGGED_IN)){
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            UserOrganization userOrganization = userOrganizationService.getOrgByUser(user);
            int id = Integer.parseInt(idInput);
            if(trainerRatingService.exist(id)) {
                TrainerRating rating = trainerRatingService.find(id);
                rating.setDone(true);

                TrainerRatingResult result = new TrainerRatingResult();
                result.setOrganization(userOrganization.getOrganization());
                result.setRatingDate(rating.getCreationDate());
                result.setTeam(userOrganization.getType());
                result.setTrainer(findTrainer(userOrganization));
                result.setResult(Integer.parseInt(value));

                trainerRatingResultService.mergeFlush(result);
                trainerRatingService.mergeFlush(rating);
                return "success";
            }
        }
        return "faild";
    }

    private User findTrainer(UserOrganization userOrganization) {
        List<UserOrganization> users = userOrganizationService.getOrgListByTeam(userOrganization.getOrganization(), userOrganization.getType());
        for(UserOrganization userOrg : users) {
            if(userOrg.getUser().isTrainer()){
                return userOrg.getUser();
            }
        }
        return null;
    }

    @RequestMapping(method = RequestMethod.POST, value = "/home/getimg")
    @ResponseBody
    public String getImg(){
        if(hasPermission(Permissions.LOGGED_IN)){
            try {
                User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
                JSONObject json = new JSONObject();
                json.put("name", user.getName());
                json.put("pic", user.getProfilImg());
                return json.toString();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "";
    }

    private Map<UserPost, Map<String, UserPostComment>> readPosts() {
        Map<UserPost, Map<String, UserPostComment>> result = new LinkedMap<>();
        User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
        Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
        for(UserPost post : userPostService.findAllByOrg(organization)) {
            Map<String, UserPostComment> comments = new TreeMap<>();
            for(UserPostComment comment : userPostCommentService.getCommentByPost(post)) {
                comments.put(comment.getId().toString(), comment);
            }
            result.put(post, comments);
        }
        return result;
    }

    private int weatherController(Organization organization) {
        List<OrgCountry> countries = orgCountryService.find(organization);
        LocalDate date = LocalDate.now();
        for(OrgCountry country : countries) {
            Date updateDate = country.getTempUpdateAt();
            if(true) {
                String url = "https://api.openweathermap.org/data/2.5/weather?q=Kecskemét&appid=a6de016d16c4c3eea60314cd92f3fcad";
                RestTemplate restTemplate = new RestTemplate();
                String jsonString = restTemplate.getForObject(url, String.class);
                JSONObject jsonObject = null;
                int temp = 0;
                try {
                    jsonObject = new JSONObject(jsonString);
                    JSONObject main = new JSONObject(String.valueOf(jsonObject.get("main")));
                    temp = Math.toIntExact(Math.round(Float.parseFloat(String.valueOf(main.get("temp"))) - 273.15));
                    country.setTemp(temp);
                    country.setTempUpdateAt(new Date(System.currentTimeMillis()));
                    orgCountryService.mergeFlush(country);
                    return temp;
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            } else {
                return country.getTemp();
            }
        }
        return 0;
    }
}
