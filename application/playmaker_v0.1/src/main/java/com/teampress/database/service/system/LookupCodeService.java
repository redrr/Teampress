package com.teampress.database.service.system;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

@Service
public class LookupCodeService extends BaseService {

    public List<LookupCode> findAll(){
        return getEntityManager().createNamedQuery("LookupCode.findAll").getResultList();
    }

    public LookupCode getByCodeAndLgroup(String code, String lgroup){
        List result = getEntityManager().createNamedQuery("LookupCode.findByCodeAndLgroup")
                .setParameter("plgroup", lgroup)
                .setParameter("pcode", code)
                .getResultList();
        return !result.isEmpty() ? (LookupCode) result.get(0) : null;
    }


    public LookupCode findLookupCodeByLgroupAndCode(String lgroup, String code){
        return getByCodeAndLgroup(code.toUpperCase(), lgroup.toUpperCase());
    }

    public LookupCode find(Integer id){
        return (LookupCode) getEntityManager().createNamedQuery("LookupCode.findById").setParameter("pid", id).getSingleResult();
    }

    public boolean exists(Integer id) {
        return !getEntityManager().createNamedQuery("LookupCode.findById").setParameter("pid", id).getResultList().isEmpty();
    }

    public boolean existsByLgroupAndCode(String lgroup, String code){
        return Objects.nonNull(getByCodeAndLgroup(code, lgroup));
    }

    public List<LookupCode> findAllLookupByLgroup(String lgroup){
        return getEntityManager().createNamedQuery("LookupCode.findAllByLgroup").setParameter("plgroup", lgroup).getResultList();
    }

    public HashMap<Integer, String> getLookupCodeForEnum(String lgroup){
        HashMap<Integer, String> result = new HashMap<>();
        for (LookupCode s : (List<LookupCode>)findAllLookupByLgroup(lgroup)){
            result.put(s.getId(), s.getCode());
        }
        return result;
    }

    public Collection<LookupCode> getLookupsForLGroup(String lgroup) {
        return getEntityManager().createNamedQuery("LookupCode.findAllByLgroup").setParameter("plgroup", lgroup).getResultList();
    }
}
