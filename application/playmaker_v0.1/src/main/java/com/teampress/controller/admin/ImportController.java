package com.teampress.controller.admin;

import com.teampress.common.enums.Parameters;
import com.teampress.common.enums.Permissions;
import com.teampress.common.enums.Roles;
import com.teampress.common.template.MailTemplates;
import com.teampress.controller.BaseController;
import com.teampress.controller.basic.IndexController;
import com.teampress.database.model.system.*;
import com.teampress.database.service.system.*;
import com.teampress.form.DataImportForm;
import com.teampress.handler.EmailSender;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@Controller
@RequestMapping("/import")
public class ImportController extends BaseController {

    private final OrganizationService organizationService;
    private final LookupCodeService lookupCodeService;
    private final RoleService roleService;
    private final UserService userService;
    private final UserRoleService userRoleService;
    private final UserOrganizationService userOrganizationService;
    private final OrgCountryService orgCountryService;
    private final JavaMailSender emailSender;
    private final IndexController indexController;
    private final ParameterService parameterService;

    public ImportController(OrganizationService organizationService, LookupCodeService lookupCodeService, RoleService roleService, UserService userService, UserRoleService userRoleService, UserOrganizationService userOrganizationService, OrgCountryService orgCountryService, JavaMailSender emailSender, IndexController indexController, ParameterService parameterService) {
        this.organizationService = organizationService;
        this.lookupCodeService = lookupCodeService;
        this.roleService = roleService;
        this.userService = userService;
        this.userRoleService = userRoleService;
        this.userOrganizationService = userOrganizationService;
        this.orgCountryService = orgCountryService;
        this.emailSender = emailSender;
        this.indexController = indexController;
        this.parameterService = parameterService;
    }

    @RequestMapping(value = "/team")
    public ModelAndView addTeamData(@Valid @ModelAttribute("data") DataImportForm form){
        ModelAndView view = new ModelAndView("403");
        if(hasPermission(Permissions.ADMIN)){
            Organization organization = organizationService.find(form.getOrganizationId());
            LookupCode team = lookupCodeService.find(form.getTeamId());
            Role role = roleService.findRoleByName(form.getRole());
            view = indexController.showIndex();
            if (!form.getData().isEmpty()) {
                try {
                    HSSFWorkbook workbook = new HSSFWorkbook(form.getData().getInputStream());
                    HSSFSheet sheet = workbook.getSheetAt(0);
                    for(Row row: sheet) {
                        if (row.getPhysicalNumberOfCells() == 2 && !"".equals(row.getCell(0).getStringCellValue().trim()) && !"".equals(row.getCell(1).getStringCellValue().trim())) {
                            User user = userService.findUserByEmail(row.getCell(1).getStringCellValue());
                            if (Objects.nonNull(user)) {
                                view.addObject("error", view.getModel().get("error")+"<br>A(z) "+(row.getRowNum()+1)+" sorban található emailcímmel már szerepel felhasználó("+user.getName()+") a rendszerben.");
                            } else {
                                //create user
                                User userPOJO = new User();
                                String uuid = UUID.randomUUID().toString();
                                userPOJO.setUsername(uuid);
                                userPOJO.setName(row.getCell(0).getStringCellValue());
                                userPOJO.setPassword(uuid);
                                userPOJO.setEmail(row.getCell(1).getStringCellValue());
                                userPOJO.setPlayer(Roles.PLAYER.name().equals(form.getRole()));
                                userPOJO.setTrainer(Roles.TRAINER.name().equals(form.getRole()));
                                user = userService.mergeFlush(userPOJO);
                                //create user - role connection
                                UserRole userRolePOJO = new UserRole();
                                userRolePOJO.setRole(role);
                                userRolePOJO.setUser(user);
                                userRoleService.mergeFlush(userRolePOJO);
                                //Send Registration
                                new EmailSender(this.emailSender).sendHtmlMessage(user.getEmail(), "Regisztráció véglegesítés", MailTemplates.welcome(parameterService.findParameterByGroupAndCode(Parameters.SYSTEM, Parameters.DOMAIN).getValue()+"/newpassword/"+ user.getUsername()));
                            }
                            List<UserOrganization> userOrganizations = userOrganizationService.findByOrgAndTeamAndUser(organization, team, user);
                            if (userOrganizations.isEmpty()) {
                                //create user - sportclub connection
                                UserOrganization userOrganizationPOJO = new UserOrganization();
                                userOrganizationPOJO.setOrganization(organization);
                                userOrganizationPOJO.setType(team);
                                userOrganizationPOJO.setUser(user);
                                userOrganizationService.mergeFlush(userOrganizationPOJO);
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return view;
    }

    @RequestMapping(value = "/club")
    public void addClub(@RequestParam String teamType, @RequestParam String shortName, @RequestParam String longName, @RequestParam String country, @RequestParam String city, @RequestParam String postCode, @RequestParam String street1, @RequestParam String street2, @RequestParam String publicKey, @RequestParam String privateKey, @RequestParam String currency) {
        Organization organizationPOJO = new Organization();
        organizationPOJO.setType(teamType);
        organizationPOJO.setName(shortName);
        organizationPOJO.setStripePrivateKey(privateKey);
        organizationPOJO.setStripePublicKey(publicKey);
        organizationPOJO.setCurrency(currency);
        Organization organization = organizationService.mergeFlush(organizationPOJO);
        OrgCountry orgCountryPOJO = new OrgCountry();
        orgCountryPOJO.setCity(city);
        orgCountryPOJO.setCountry(country);
        orgCountryPOJO.setName(longName);
        orgCountryPOJO.setPostCode(postCode);
        orgCountryPOJO.setStreet(street1);
        orgCountryPOJO.setStreet2(street2);
        orgCountryPOJO.setOrganization(organization);
        orgCountryService.mergeFlush(orgCountryPOJO);
    }
}
