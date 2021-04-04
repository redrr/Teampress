package com.teampress.database.service.system;

import com.teampress.database.model.system.Role;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class RoleService extends BaseService {

    public Role find(Integer id){
        return (Role) getEntityManager().createNamedQuery("Role.findById").setParameter("pid", id).getResultList().get(0);
    }

    public List<Role> findAll(){
        return getEntityManager().createNamedQuery("Role.findAll").getResultList();
    }

    public Role findRoleByName(String name){
        List result = getEntityManager().createNamedQuery("Role.findByName").setParameter("pname", name).getResultList();
        return result.isEmpty() ? null : (Role)result.get(0);
    }

    public boolean existsByName(String name){
        return !Objects.isNull(findRoleByName(name));
    }
}
