package com.teampress.database.service.gameplan;

import com.teampress.database.model.gameplan.CustomGame;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CustomGameService extends BaseService {

    public List<CustomGame> findAll(){
        return getEntityManager().createNamedQuery("CustomGame.findAll").getResultList();
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
