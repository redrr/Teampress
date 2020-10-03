package hu.playmaker.database.service.databank;

import hu.playmaker.database.model.databank.Turn;
import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TurnService extends BaseService {

    public List<Turn> findAll(){
        return getEntityManager().createNamedQuery("Turn.findAll").getResultList();
    }

    public Integer findByLiga(Liga liga){
        List<Turn> turns = getEntityManager().createNamedQuery("Turn.findByLiga").setParameter("pliga", liga).getResultList();
        if(turns.size() > 0){
            return turns.get(0).getMaxFordulo();
        }
        return null;
    }
}
