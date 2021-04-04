package hu.playmaker.controller.system;

import hu.playmaker.common.template.MailTemplates;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.system.ParameterService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.form.PasswordForm;
import hu.playmaker.handler.EmailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.MessagingException;
import javax.validation.Valid;
import java.util.Objects;

import static hu.playmaker.common.enums.Parameters.DOMAIN;
import static hu.playmaker.common.enums.Parameters.SYSTEM;
import static java.util.Objects.isNull;

@Controller
public class PasswordController {

    private final UserService userService;
    private final JavaMailSender mailSender;
    private final ParameterService parameterService;

    public PasswordController(UserService userService, JavaMailSender mailSender, ParameterService parameterService) {
        this.userService = userService;
        this.mailSender = mailSender;
        this.parameterService = parameterService;
    }

    @GetMapping("/newpassword/{username}")
    public ModelAndView newPasswordView(@PathVariable String username) {
        String uuid = username;
        User user = userService.findEnabledUserByUsername(uuid);
        if(!isNull(user) && BCrypt.checkpw(uuid, user.getPassword())) {
            ModelAndView view = new ModelAndView("Password", "change", new PasswordForm());
            view.addObject("mail", user.getEmail());
            view.addObject("username", uuid);
            return view;
        } else {
            return new ModelAndView("404");
        }
    }

    @PostMapping("/changepassword")
    public String changePassword(@Valid @ModelAttribute("change") PasswordForm form) {
        User user = userService.findEnabledUserByUsername(form.getUsername());
        if (Objects.nonNull(user) && Objects.nonNull(form.getPassword1()) && Objects.nonNull(form.getPassword2()) && form.getPassword1().equals(form.getPassword2())) {
            user.setPassword(form.getPassword1());
            userService.mergeFlush(user);
            return "redirect:/";
        }
        return "redirect:/newpassword/"+form.getUsername();
    }

    @GetMapping("/forgetpassword/{mail}")
    public String changePassword(@PathVariable String mail) {
        User user = userService.findUserByEmail(mail);
        if (Objects.nonNull(user)) {
            user.setPassword(user.getUsername());
            userService.mergeFlush(user);
            try {
                //new EmailSender(mailSender).sendHtmlMessage(mail, "Jelszó módosítás", "Kedves "+user.getName()+"!<br><br>Az alábbi linken keresztül módosíthatja jelszavát: <a href=\"http://localhost:8080/newpassword/"+user.getUsername() +"\" target=\"_blank\">Új jelszó</a>");
                new EmailSender(mailSender).sendHtmlMessage(mail, "Jelszó módosítás", MailTemplates.changePassword(user.getName(),parameterService.findParameterByGroupAndCode(SYSTEM, DOMAIN).getValue()+"/newpassword/"+user.getUsername()));
            } catch (MessagingException e) {
                e.printStackTrace();
            }
        }
        return "redirect:/";
    }
}
