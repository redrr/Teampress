package hu.playmaker.database.service.databank;

import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Deprecated
public class LigaService extends BaseService {

    public Liga find(int liga){
        return (Liga) getEntityManager().createNamedQuery("Liga.findByLiga").setParameter("pliga", liga).getSingleResult();
    }

    public Liga findByName(String liga){
        return (Liga) getEntityManager().createNamedQuery("Liga.findByName").setParameter("pliga", liga).getSingleResult();
    }

    public List<Liga> findAll(){
        return getEntityManager().createNamedQuery("Liga.findAll").getResultList();
    }
}
