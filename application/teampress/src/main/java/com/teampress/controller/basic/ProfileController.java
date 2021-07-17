package com.teampress.controller.basic;

import com.teampress.common.enums.Permissions;
import com.teampress.controller.BaseController;
import com.teampress.database.model.system.User;
import com.teampress.database.service.system.ParameterService;
import com.teampress.database.service.system.UserService;
import com.teampress.form.UserForm;
import com.teampress.handler.SessionHandler;
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

import static com.teampress.common.enums.Parameters.PROFILE_IMG;
import static com.teampress.common.enums.Parameters.SYSTEM;

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
                    profil.setEncodedPassword(form.getPassword());
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
