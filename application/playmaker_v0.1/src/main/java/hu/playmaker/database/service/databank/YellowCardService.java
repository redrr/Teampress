package hu.playmaker.database.service.databank;

import hu.playmaker.database.model.databank.Goals;
import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.model.databank.YellowCard;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class YellowCardService extends BaseService {

    public List<YellowCard> findByOrg(Liga liga, Organization organization){
        return getEntityManager().createNamedQuery("YellowCard.findByOrg").setParameter("pliga", liga).setParameter("porg", organization).getResultList();
    }

    public List<YellowCard> findUnique(Liga liga, Organization organization, String name){
        return getEntityManager().createNamedQuery("YellowCard.findUni").setParameter("pliga", liga).setParameter("porg", organization).setParameter("pname", name).getResultList();
    }

    public List<YellowCard> findAll(){
        return getEntityManager().createNamedQuery("YellowCard.findAll").getResultList();
    }
}
