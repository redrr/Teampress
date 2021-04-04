package com.teampress.database.service.databank;

import com.teampress.database.model.databank.Liga;
import com.teampress.database.service.BaseService;
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
