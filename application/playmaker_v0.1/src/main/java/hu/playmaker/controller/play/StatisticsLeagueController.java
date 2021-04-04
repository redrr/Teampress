package hu.playmaker.controller.play;

import hu.playmaker.common.enums.Permissions;
import hu.playmaker.common.factory.mlsz.MLSZParser;
import hu.playmaker.controller.BaseController;
import hu.playmaker.database.model.databank.*;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.service.system.UserOrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.SessionHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("/statistics/league")
public class StatisticsLeagueController extends BaseController {

    private UserService userService;
    private UserOrganizationService userOrganizationService;

    public StatisticsLeagueController(UserService userService, UserOrganizationService userOrganizationService) {
        this.userService = userService;
        this.userOrganizationService = userOrganizationService;
    }

    @RequestMapping("")
    public ModelAndView show() {
        if(hasPermission(Permissions.CAREER_TABLE)) {
            User currentUser = userService.findEnabledUserByUsername(SessionHandler.getUsernameFromCurrentSession());
            Organization organization = userOrganizationService.getOrgByUser(currentUser).getOrganization();
            ModelAndView view = new ModelAndView("play/StatisticsLeague");
            view.addObject("ligas", getPlayerLigas(currentUser));
            view.addObject("tabellas", getTabellaByLiga(getPlayerLigas(currentUser)));
            view.addObject("sorsolas" , getSorsolasByLiga(getPlayerLigas(currentUser)));
            view.addObject("golok", getGoalsByLiga(getPlayerLigas(currentUser)));
            view.addObject("sargak", getYellowCardsByLiga(getPlayerLigas(currentUser)));
            view.addObject("pirosak", getRedCardsByLiga(getPlayerLigas(currentUser)));
            view.addObject("org", organization);
            view.addObject("user", currentUser);
            return view;
        }
        return new ModelAndView("403");
    }

    //region [Region] Helper Methods
    private ArrayList<Liga> getPlayerLigas(User currentUser) {
        List<UserOrganization> userOrganization = userOrganizationService.getOrgListByUser(currentUser);
        return userOrganization.stream().collect(ArrayList::new,(liga, userOrg) -> liga.add(userOrg.getLiga()),ArrayList::addAll);
    }

    private HashMap<Integer, List<Tabella>> getTabellaByLiga(ArrayList<Liga> ligas) {
        HashMap<Integer, List<Tabella>> result = new HashMap<>();
        for(Liga liga : ligas) {
            String klcUrl = "http://ada1bank.mlsz.hu/club?teamId=214928";
            List<Tabella> tabella = new MLSZParser(klcUrl).setLiga(liga).getTabellas();
            result.put(liga.getId(), tabella);
        }
        return result;
    }

    private HashMap<Integer, List<Sorsolas>> getSorsolasByLiga(ArrayList<Liga> ligas) {
        HashMap<Integer, List<Sorsolas>> result = new HashMap<>();
        for(Liga liga : ligas) {
            String klcUrl = "http://ada1bank.mlsz.hu/club?teamId=214928";
            List<Sorsolas> sorsolas = new MLSZParser(klcUrl).setLiga(liga).getLotteries();
            result.put(liga.getId(), sorsolas);
        }
        return result;
    }

    private HashMap<Integer, List<Goals>> getGoalsByLiga(ArrayList<Liga> playerLigas) {
        HashMap<Integer, List<Goals>> result = new HashMap<>();
        for(Liga liga : playerLigas) {
            String klcUrl = "http://ada1bank.mlsz.hu/club?teamId=214928";
            List<Goals> goals = new MLSZParser(klcUrl).setLiga(liga).getGoals();
            result.put(liga.getId(), goals);
        }
        return result;
    }

    private HashMap<Integer, List<YellowCard>> getYellowCardsByLiga(ArrayList<Liga> playerLigas) {
        HashMap<Integer, List<YellowCard>> result = new HashMap<>();
        for(Liga liga : playerLigas) {
            String klcUrl = "http://ada1bank.mlsz.hu/club?teamId=214928";
            List<YellowCard> yellowCards = new MLSZParser(klcUrl).setLiga(liga).getYellowCards();
            result.put(liga.getId(), yellowCards);
        }
        return result;
    }

    private HashMap<Integer, List<RedCard>> getRedCardsByLiga(ArrayList<Liga> playerLigas) {
        HashMap<Integer, List<RedCard>> result = new HashMap<>();
        for(Liga liga : playerLigas) {
            String klcUrl = "http://ada1bank.mlsz.hu/club?evad=54&szervezet=1&verseny=22535&fordulo=13&teamId=214928";
            List<RedCard> data = new MLSZParser(klcUrl).setLiga(liga).getRedCards();
            result.put(liga.getId(), data);
        }
        return result;
    }
    //endregion
}
