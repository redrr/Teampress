package hu.playmaker.database.service.databank;

import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.model.databank.RedCard;
import hu.playmaker.database.model.databank.YellowCard;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RedCardService extends BaseService {

    public List<RedCard> findByOrg(Liga liga, Organization organization){
        return getEntityManager().createNamedQuery("RedCard.findByOrg").setParameter("pliga", liga).setParameter("porg", organization).getResultList();
    }

    public List<RedCard> findUnique(Liga liga, Organization organization, String name){
        return getEntityManager().createNamedQuery("RedCard.findUni").setParameter("pliga", liga).setParameter("porg", organization).setParameter("pname", name).getResultList();
    }

    public List<RedCard> findAll(){
        return getEntityManager().createNamedQuery("RedCard.findAll").getResultList();
    }
}
