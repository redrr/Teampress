package hu.playmaker.controller.basic;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.system.ParameterService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.form.UserForm;
import hu.playmaker.handler.SessionHandler;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;

import static hu.playmaker.common.enums.Parameters.PROFILE_IMG;
import static hu.playmaker.common.enums.Parameters.SYSTEM;

@Controller
@RequestMapping("/profile")
public class ProfileController extends BaseController {

    private UserService userService;
    private ParameterService parameterService;

    public ProfileController(UserService userService, ParameterService parameterService) {
        this.userService = userService;
        this.parameterService = parameterService;
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
    public String doSubmit(@Valid @ModelAttribute("modifyProfile") UserForm form) {
        if(hasPermission(Permissions.LOGGED_IN)){
            String uploadFolder = parameterService.findParameterByGroupAndCode(SYSTEM, PROFILE_IMG).getValue();
            if(Objects.nonNull(form.getId())) {
                User profil = userService.find(form.getId());
                profil.setName(form.getName());
                if(form.getPassword().equals(form.getRepassword()) && !form.getPassword().equals("") && !BCrypt.checkpw(form.getPassword(), profil.getPassword())){
                    profil.setPassword(form.getPassword());
                }
                if(!form.getEmail().trim().equals("")) {
                    profil.setEmail(form.getEmail());
                }
                if(!form.getPhone().isEmpty()){
                    profil.setPhoneNumber(form.getPhone());
                }
                if(!form.getProfileImg().isEmpty() && form.getProfileImg().getContentType().contains("image")){
                    try {
                        byte[] bytes = form.getProfileImg().getBytes();
                        Path path = Paths.get(uploadFolder+profil.getUsername()+"_"+form.getProfileImg().getOriginalFilename());
                        Files.write(path, bytes);
                        profil.setProfilImg(profil.getUsername()+"_"+form.getProfileImg().getOriginalFilename());
                    } catch (Exception e){
                        e.printStackTrace();
                    }
                }
                userService.mergeFlush(profil);
            }
        }
        return "Profile";
    }
}
