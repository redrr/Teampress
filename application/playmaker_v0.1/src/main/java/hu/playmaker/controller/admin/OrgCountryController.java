package hu.playmaker.controller.admin;

import hu.playmaker.common.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.system.OrgCountry;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.system.OrgCountryService;
import hu.playmaker.database.service.system.OrganizationService;
import hu.playmaker.form.BaseForm;
import hu.playmaker.form.OrgCountryForm;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

@Controller
@RequestMapping("/org/orgcountry")
public class OrgCountryController extends BaseController {

    private OrgCountryService orgCountryService;
    private OrganizationService organizationService;

    public OrgCountryController(OrgCountryService orgCountryService, OrganizationService organizationService) {
        this.orgCountryService = orgCountryService;
        this.organizationService = organizationService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/OrgCountry", "model", new OrgCountryForm());
            view.addObject("datas", orgCountryService.findAll());
            view.addObject("org", organizationService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("model") OrgCountryForm form, BindingResult result, HttpServletRequest request){
        if(hasPermission(Permissions.ADMIN)){
            OrgCountry o = Objects.nonNull(form.getId()) ? orgCountryService.find(form.getId()) : new OrgCountry();
            o.setOrganization(organizationService.find(form.getOrganizationId()));
            o.setName(form.getFullname());
            o.setCountry(form.getCountry());
            o.setCity(form.getCity());
            o.setPostCode(form.getPostCode());
            o.setStreet(form.getStreet());
            o.setStreet2(form.getStreet2());
            orgCountryService.mergeFlush(o);
        }
        return "redirect:/org/orgcountry";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            OrgCountry o = orgCountryService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            try {
                json.put("id", o.getId());
                json.put("orgId", o.getOrganization().getId());
                json.put("name", o.getName());
                json.put("country", o.getCountry());
                json.put("city", o.getCity());
                json.put("street", o.getStreet());
                json.put("street2", o.getStreet2());
                json.put("pcode", o.getPostCode());
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "redirect:/org/orgcountry";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            OrgCountry o = orgCountryService.find(Integer.parseInt(id));
            orgCountryService.delete(o);
            orgCountryService.flush();
        }
        return "redirect:/org/orgcountry";
    }
}
