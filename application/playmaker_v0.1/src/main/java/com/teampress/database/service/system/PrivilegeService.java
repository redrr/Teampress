package com.teampress.database.service.system;

import com.teampress.database.model.system.Privilege;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class PrivilegeService extends BaseService {

    public Privilege find(Integer id){
        return (Privilege) getEntityManager().createNamedQuery("Privilege.findById").setParameter("pid", id).getResultList().get(0);
    }

    public List<Privilege> findAll(){
        return getEntityManager().createNamedQuery("Privilege.findAll").getResultList();
    }

    public Privilege findPrivilegeByName(String name) {
        List privs = getEntityManager().createNamedQuery("Privilege.findByName")
                .setParameter("pname", name)
                .getResultList();
        return privs.isEmpty()?null:(Privilege)privs.get(0);
    }

    public boolean existsByName(String name) {
        return !Objects.isNull(findPrivilegeByName(name));
    }
}
