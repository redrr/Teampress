package hu.playmaker.database.service.system;

import hu.playmaker.database.model.system.Parameter;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class ParameterService extends BaseService {

    public Parameter find(Integer id){
        return (Parameter) getEntityManager().createNamedQuery("Parameter.findById").setParameter("pid", id).getResultList().get(0);
    }

    public List<Parameter> findAll(){
        return getEntityManager().createNamedQuery("Parameter.findAll").getResultList();
    }

    public Parameter findParameterByGroupAndCode(String group, String code){
        List result = getEntityManager().createNamedQuery("Parameter.findByGroupAndCode")
                .setParameter("pgroup", group)
                .setParameter("pcode", code)
                .getResultList();
        return result.isEmpty()?null:(Parameter)result.get(0);
    }

    public List<Parameter> findParameterByGroup(String group){
        return getEntityManager().createNamedQuery("Parameter.findByGroup").setParameter("pgroup", group).getResultList();
    }

    public boolean existsByGroupAndCode(String group, String code){
        return Objects.nonNull(findParameterByGroupAndCode(group, code));
    }
}
