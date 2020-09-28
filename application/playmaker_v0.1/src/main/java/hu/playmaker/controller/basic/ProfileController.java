package hu.playmaker.controller.basic;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.form.UserForm;
import hu.playmaker.handler.SessionHandler;
import org.springframework.security.crypto.bcrypt.BCrypt;
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

@Controller
@RequestMapping("/profile")
public class ProfileController extends BaseController {

    private UserService userService;
    private static String UPLOADED_FOLDER = "C:\\Projects\\PlaymakerProjects\\playmaker\\src\\main\\webapp\\content\\profileImages\\";

    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.LOGGED_IN)) {
            ModelAndView view = new ModelAndView("Profile","modifyProfile", new UserForm());
            view.addObject(userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession()));
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String doSubmit(@Valid @ModelAttribute("modifyProfile") UserForm form, BindingResult result, HttpServletRequest request) {
        //:TODO validáció!!!
        if(hasPermission(Permissions.LOGGED_IN)){
            User profil = userService.find(form.getId());
            profil.setName(form.getName());
            if(form.getPassword().equals(form.getRepassword()) && !form.getPassword().equals("") && !BCrypt.checkpw(form.getPassword(), profil.getPassword())){
                profil.setPassword(form.getPassword());
            }
            profil.setEmail((form.getEmail().equals("") || form.getEmail().equals("példa@email.com")) ? profil.getEmail() : form.getEmail());
            if(!form.getPhone().isEmpty()){
                profil.setPhoneNumber(form.getPhone());
            }
            if(!form.getProfileImg().isEmpty() && form.getProfileImg().getContentType().contains("image")){
                try {
                    byte[] bytes = form.getProfileImg().getBytes();
                    Path path = Paths.get(UPLOADED_FOLDER+profil.getUsername()+"_"+form.getProfileImg().getOriginalFilename());
                    Files.write(path, bytes);
                    String oldImg = profil.getProfilImg();
                    profil.setProfilImg(profil.getUsername()+"_"+form.getProfileImg().getOriginalFilename());
                    if(!oldImg.equals("userphoto.png")){
                        Files.delete(Paths.get(UPLOADED_FOLDER+oldImg));
                    }
                } catch (Exception e){
                    e.printStackTrace();
                }
            }
            userService.mergeFlush(profil);
        }
        return "Profile";
    }
}
