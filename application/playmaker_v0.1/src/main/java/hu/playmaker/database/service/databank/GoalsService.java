package hu.playmaker.database.service.databank;

import hu.playmaker.database.model.databank.Goals;
import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoalsService extends BaseService {

    public List<Goals> findByOrg(Liga liga, Organization organization) {
        return getEntityManager().createNamedQuery("Goals.findByOrg").setParameter("pliga", liga).setParameter("porg", organization).getResultList();
    }

    public List<Goals> findAllUnique(Liga liga, Organization organization, Integer ford, String name){
        return getEntityManager().createNamedQuery("Goals.findUni").setParameter("pliga", liga).setParameter("porg", organization).setParameter("pford", ford).setParameter("pname", name).getResultList();
    }

    public List findLastByleagueAndClub(Liga liga, Organization organization){
        return getEntityManager().createNamedQuery("Goals.findForStat").setParameter("pliga", liga).setParameter("porg", organization).getResultList();
    }

    public Goals findUnique(Liga liga, Organization organization, Integer ford, String name) {
        return (findAllUnique(liga, organization, ford, name).size() > 0) ? findAllUnique(liga, organization, ford, name).get(0) : null;
    }

    public List<Goals> findAll(){
        return getEntityManager().createNamedQuery("Goals.findAll").getResultList();
    }
}
