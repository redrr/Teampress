package hu.playmaker.database.service.gameplan;

import hu.playmaker.database.model.databank.Sorsolas;
import hu.playmaker.database.model.gameplan.CustomGame;
import hu.playmaker.database.model.gameplan.GamePlan;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CustomGameService extends BaseService {

    public List<CustomGame> findAll(){
        return getEntityManager().createNamedQuery("CustomGame.findAll").getResultList();
    }

    public List<CustomGame> find(User user, Sorsolas sorsolas){
        return getEntityManager().createNamedQuery("CustomGame.findByOrgAndTeam").setParameter("pteam", sorsolas).setParameter("porg",user).getResultList();
    }

    public boolean exist(LookupCode team, Date date){
        return !getEntityManager().createNamedQuery("CustomGame.findByTeamAndDate").setParameter("pteam", team).setParameter("pdate",date).getResultList().isEmpty();
    }

    public List<CustomGame> find(Organization organization){
        return getEntityManager().createNamedQuery("CustomGame.findByOrg").setParameter("porg",organization).getResultList();
    }

    public CustomGame find(int id){
        return (CustomGame) getEntityManager().createNamedQuery("CustomGame.findById").setParameter("pid",id).getResultList().get(0);
    }

    public List<CustomGame> findByCreated(String createdBy){
        return getEntityManager().createNamedQuery("CustomGame.findByCreated").setParameter("pby",createdBy).getResultList();
    }
}
