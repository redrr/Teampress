package hu.playmaker.controller.basic;

import hu.playmaker.common.LGroups;
import hu.playmaker.common.Permissions;
import hu.playmaker.common.Roles;
import hu.playmaker.common.template.PlayerHeaderTmp;
import hu.playmaker.common.template.SorsolasHeaderTmp;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.index.UserPost;
import hu.playmaker.database.model.index.UserPostComment;
import hu.playmaker.database.model.system.*;
import hu.playmaker.database.model.trainingplan.TrainingPlanConnection;
import hu.playmaker.database.service.index.UserPostCommentService;
import hu.playmaker.database.service.index.UserPostService;
import hu.playmaker.database.service.system.*;
import hu.playmaker.database.service.trainingplan.TrainingPlanService;
import hu.playmaker.database.service.workout.AttendanceService;
import hu.playmaker.form.DataImportForm;
import hu.playmaker.form.IndexForm;
import hu.playmaker.handler.SessionHandler;
import org.apache.commons.collections4.map.LinkedMap;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.*;

@Controller
public class IndexController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;
    private UserPostService userPostService;
    private UserPostCommentService userPostCommentService;
    private AttendanceService attendanceService;
    private UserNotificationService notificationService;
    private TrainerRatingService trainerRatingService;
    private TrainerRatingResultService trainerRatingResultService;
    private TrainingPlanService trainingPlanService;
    private OrgCountryService orgCountryService;
    private ParameterService parameterService;
    private OrganizationService organizationService;
    private LookupCodeService lookupCodeService;

    public IndexController(UserService userService, UserOrganizationService userOrganizationService, UserPostService userPostService, UserPostCommentService userPostCommentService, AttendanceService attendanceService, UserNotificationService notificationService, TrainerRatingService trainerRatingService, TrainerRatingResultService trainerRatingResultService, TrainingPlanService trainingPlanService, OrgCountryService orgCountryService, ParameterService parameterService, OrganizationService organizationService, LookupCodeService lookupCodeService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
        this.userPostService = userPostService;
        this.userPostCommentService = userPostCommentService;
        this.attendanceService = attendanceService;
        this.notificationService = notificationService;
        this.trainerRatingService = trainerRatingService;
        this.trainerRatingResultService = trainerRatingResultService;
        this.trainingPlanService = trainingPlanService;
        this.orgCountryService = orgCountryService;
        this.parameterService = parameterService;
        this.organizationService = organizationService;
        this.lookupCodeService = lookupCodeService;
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
            UserOrganization uOrg;
            if (hasPermission(Permissions.ADMIN)) {
                view = new ModelAndView("Index", "data", new DataImportForm());
                view.addObject("organizations", organizationService.findAll());
                view.addObject("teams", lookupCodeService.findAllLookupByLgroup(LGroups.TEAM_TYPE.name()));
                view.addObject("roles", Roles.values());
                return view;
            }
            if(hasPermission(Permissions.POST_COMMENT_CREATE)) {
                view = new ModelAndView("Index", "createPost", new IndexForm());
            } else {
                view = new ModelAndView("Index");
            }
            if(hasPermission(Permissions.HOME_HEADER_BUTTONS)) {
                uOrg = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
                view.addObject("nextTraining", trainingPlanService.findNext(uOrg.getOrganization(), uOrg.getType()));
                view.addObject("nextTrainingDay", getDay(trainingPlanService.findNext(uOrg.getOrganization(), uOrg.getType())));
                view.addObject("playerHeader", getPlayerHeader(
                        userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()),
                        attendanceService.findLastFiveTrainingJelenByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()))));
                view.addObject("teamHeader", getTeamHeader(uOrg.getOrganization()));
                view.addObject("sorsolasHeader", getSorsolas());
            }
            if(hasPermission(Permissions.HOME_WEATHER)){
                uOrg = userOrganizationService.getOrgByUser(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
                view.addObject("temp", weatherController(uOrg.getOrganization()));
                view.addObject("city", orgCountryService.find(uOrg.getOrganization()).get(0).getCity());
            }
            return view;
        }
        return new ModelAndView("403");
    }

    private String getDay(TrainingPlanConnection trainingPlan) {
        if(Objects.nonNull(trainingPlan)){
            String[] days = {"Vasárnap", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Péntek", "Szombat"};
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(trainingPlan.getTrainingPlan().getRealTrainingDate());
            return days[calendar.get(Calendar.DAY_OF_WEEK)-1];
        }
        return "";
    }

    public SorsolasHeaderTmp getSorsolas(){
        SorsolasHeaderTmp tmp = new SorsolasHeaderTmp();
        tmp.setHazaiUrl("haza_img_url");
        tmp.setEredmeny("game_date");
        tmp.setVendegUrl("vend_img_url");
        return tmp;
    }

    @RequestMapping(method = RequestMethod.POST, value = "/dopost")
    public String doPost(@Valid @ModelAttribute("createPost") IndexForm form) {
        if(hasPermission(Permissions.POST_COMMENT_CREATE) && (Objects.nonNull(form.getFile()) || !form.getPostText().trim().equals(""))){
            String uploadFolder = parameterService.findParameterByGroupAndCode("SYSTEM", "POST_IMG").getValue();
            UserPost post = new UserPost();
            User user = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            post.setUser(user);
            post.setOrganization(userOrganizationService.getOrgByUser(user).getOrganization());
            if(!form.getFile().isEmpty() && (form.getFile().getContentType().contains("image") || form.getFile().getContentType().contains("mp4"))){
                try {
                    byte[] bytes = form.getFile().getBytes();
                    Path path = Paths.get(uploadFolder+user.getUsername()+"_"+form.getFile().getOriginalFilename());
                    Files.write(path, bytes);
                    post.setImageUrl(user.getUsername()+"_"+form.getFile().getOriginalFilename());
                } catch (Exception e){
                    e.printStackTrace();
                }
            }
            if(!form.getPostText().trim().equals("")){
                post.setPost(form.getPostText());
            }
            if (post.getImageUrl() != null || post.getPost() != null)
                userPostService.mergeFlush(post);
        }
        return "redirect:/";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/docomment")
    public String doComment(Integer userPostId, String comment) {
        if(hasPermission(Permissions.POST_COMMENT_CREATE) && Objects.nonNull(userPostId) && !comment.trim().equals("")) {
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

    @RequestMapping(method = RequestMethod.POST, value = "/home/getposts")
    @ResponseBody
    public String getPosts(@RequestParam Integer offset) {
        if(hasPermission(Permissions.LOGGED_IN) && !hasPermission(Permissions.ADMIN)) {
            JSONArray array = new JSONArray();
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
            for(UserPost post : userPostService.findAllByOrgWithLimit(organization, offset)) {
                JSONObject postJSON = post.getJSONObject();
                JSONArray commentArray = new JSONArray();
                for(UserPostComment comment : userPostCommentService.getCommentByPost(post)) {
                    commentArray.put(comment.getJSONObject());
                }
                try {
                    postJSON.put("comments", commentArray);
                } catch (Exception e) {
                    e.printStackTrace();
                    return "";
                }
                array.put(postJSON);
            }
            return array.toString();
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
                    //orgCountryService.mergeFlush(country);
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

    //region [Player Header]
    public PlayerHeaderTmp getPlayerHeader(User user, String[] stat){
        PlayerHeaderTmp tmp = new PlayerHeaderTmp();
        tmp.setName(user.getName().split(" ")[0]+" "+ user.getName().split(" ")[1].charAt(0)+".");
        tmp.setProfImg(user.getProfilImg());
        tmp.setCssClass(setClassFromStat(stat));
        tmp.setData(stat);
        return tmp;
    }

    private String[] setClassFromStat(String[] stat) {
        String[] re = new String[5];
        for(int i = 0; i < stat.length; i++){
            re[i] = (stat[i].equals("")) ? "" : cssStyle(stat[i]);
        }
        return re;
    }

    public PlayerHeaderTmp getTeamHeader(Organization org){
        PlayerHeaderTmp tmp = new PlayerHeaderTmp();
        tmp.setProfImg(org.getUrl());
        tmp.setName(1 + ". helyezés");
        tmp.setCssClass(new String[]{cssStyle("GY"), cssStyle("GY"), cssStyle("GY"), cssStyle("GY"), cssStyle("GY")});
        tmp.setData(new String[]{"GY", "GY", "GY", "GY", "GY"});
        return tmp;
    }

    private String cssStyle(String lvl) {
        switch (lvl){
            case "GY" : return "primary";
            case "+" : return "primary";
            case "D" : return "warning";
            case "V" : return "danger";
            case "-" : return "danger";
            default: return "info";
        }
    }
    //endregion
}
