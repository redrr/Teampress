package com.teampress.database.service.system;

import com.teampress.database.model.system.Log;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogService extends BaseService {

    public List<Log> findAll(){
        return getEntityManager().createNamedQuery("Log.findAll").getResultList();
    }
}
