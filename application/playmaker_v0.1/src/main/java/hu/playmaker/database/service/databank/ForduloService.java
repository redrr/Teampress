package hu.playmaker.database.service.databank;

import hu.playmaker.database.model.databank.Fordulo;
import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ForduloService extends BaseService {

    public List<Fordulo> findAll(){
        return getEntityManager().createNamedQuery("Fordulo.findAll").getResultList();
    }

    public Integer findByLiga(Liga liga){
        List<Fordulo> fordulos = getEntityManager().createNamedQuery("Fordulo.findByLiga").setParameter("pliga", liga).getResultList();
        if(fordulos.size() > 0){
            return fordulos.get(0).getMaxFordulo();
        }
        return null;
    }
}
