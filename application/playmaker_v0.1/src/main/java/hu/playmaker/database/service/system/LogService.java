package hu.playmaker.database.service.system;

import hu.playmaker.database.model.system.Log;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LogService extends BaseService {

    public List<Log> findAll(){
        return getEntityManager().createNamedQuery("Log.findAll").getResultList();
    }
}
