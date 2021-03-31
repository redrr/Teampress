package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.common.Roles;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.*;
import hu.playmaker.database.service.system.*;
import hu.playmaker.form.DataImportForm;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
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

    public ImportController(OrganizationService organizationService, LookupCodeService lookupCodeService, RoleService roleService, UserService userService, UserRoleService userRoleService, UserOrganizationService userOrganizationService, OrgCountryService orgCountryService) {
        this.organizationService = organizationService;
        this.lookupCodeService = lookupCodeService;
        this.roleService = roleService;
        this.userService = userService;
        this.userRoleService = userRoleService;
        this.userOrganizationService = userOrganizationService;
        this.orgCountryService = orgCountryService;
    }

    @RequestMapping(value = "/team")
    public String addTeamData(@Valid @ModelAttribute("data") DataImportForm form){
        if(hasPermission(Permissions.ADMIN)){
            Organization organization = organizationService.find(form.getOrganizationId());
            LookupCode team = lookupCodeService.find(form.getTeamId());
            Role role = roleService.findRoleByName(form.getRole());
            if (!form.getData().isEmpty()) {
                try {
                    HSSFWorkbook workbook = new HSSFWorkbook(form.getData().getInputStream());
                    HSSFSheet sheet = workbook.getSheetAt(0);
                    for(Row row: sheet) {
                        if (row.getPhysicalNumberOfCells() == 2) {
                            //create user
                            User userPOJO = new User();
                            String uuid = UUID.randomUUID().toString();
                            userPOJO.setUsername(uuid);
                            userPOJO.setName(row.getCell(0).getStringCellValue());
                            userPOJO.setPassword(uuid);
                            userPOJO.setEmail(row.getCell(1).getStringCellValue());
                            userPOJO.setPlayer(Roles.PLAYER.name().equals(form.getRole()));
                            userPOJO.setTrainer(Roles.TRAINER.name().equals(form.getRole()));
                            User user = userService.mergeFlush(userPOJO);
                            //create user - role connection
                            UserRole userRolePOJO = new UserRole();
                            userRolePOJO.setRole(role);
                            userRolePOJO.setUser(user);
                            userRoleService.mergeFlush(userRolePOJO);
                            //create user - sportclub connection
                            UserOrganization userOrganizationPOJO = new UserOrganization();
                            userOrganizationPOJO.setOrganization(organization);
                            userOrganizationPOJO.setType(team);
                            userOrganizationPOJO.setUser(user);
                            userOrganizationService.mergeFlush(userOrganizationPOJO);
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return "redirect:/home";
    }

    @RequestMapping(value = "/club")
    public String addClub(@RequestParam String teamType, @RequestParam String shortName, @RequestParam String longName, @RequestParam String country, @RequestParam String city, @RequestParam String postCode, @RequestParam String street1, @RequestParam String street2, @RequestParam String publicKey, @RequestParam String privateKey) {
        Organization organizationPOJO = new Organization();
        organizationPOJO.setType(teamType);
        organizationPOJO.setName(shortName);
        organizationPOJO.setStripePrivateKey(privateKey);
        organizationPOJO.setStripePublicKey(privateKey);
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
        return "";
    }
}
