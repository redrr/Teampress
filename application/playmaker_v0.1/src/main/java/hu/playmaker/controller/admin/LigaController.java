package hu.playmaker.controller.admin;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.service.databank.LigaService;
import hu.playmaker.form.LeagueForm;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.Objects;

@Controller
@RequestMapping("/org/league")
public class LigaController extends BaseController {

    private LigaService ligaService;

    public LigaController(LigaService ligaService) {
        this.ligaService = ligaService;
    }

    @RequestMapping()
    public ModelAndView show(){
        if(hasPermission(Permissions.ADMIN)){
            ModelAndView view = new ModelAndView("admin/League", "model", new LeagueForm());
            view.addObject("datas", ligaService.findAll());
            return view;
        }
        return new ModelAndView("403");
    }

    @RequestMapping(method = RequestMethod.POST)
    public String create(@Valid @ModelAttribute("model") LeagueForm form, BindingResult result, HttpServletRequest request){
        if(hasPermission(Permissions.ADMIN)){
            Liga l = Objects.nonNull(form.getId()) ? ligaService.find(form.getId()) : new Liga();
            l.setEvad(form.getEvad());
            l.setKlubName(form.getKlubName());
            l.setLiga(form.getLiga());
            l.setSzervezo(form.getSzervezo());
            l.setTeam(form.getTeam());
            ligaService.mergeFlush(l);
        }
        return "redirect:/org/league";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/get")
    @ResponseBody
    public String get(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            Liga l = ligaService.find(Integer.parseInt(id));
            JSONObject json = new JSONObject();
            try {
                json.put("id", l.getId());
                json.put("ev", l.getEvad());
                json.put("klub", l.getKlubName());
                json.put("liga", l.getLiga());
                json.put("szerv", l.getSzervezo());
                json.put("team", l.getTeam());
            } catch (Exception e){
                e.printStackTrace();
            }
            return json.toString();
        }
        return "redirect:/org/league";
    }

    @RequestMapping(method = RequestMethod.POST, value = "/del")
    public String del(@RequestParam("id") String id) {
        if(hasPermission(Permissions.ADMIN)){
            Liga l = ligaService.find(Integer.parseInt(id));
            ligaService.delete(l);
            ligaService.flush();
        }
        return "redirect:/org/league";
    }
}
