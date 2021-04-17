package com.teampress.database.service.system;

import com.teampress.database.model.system.Privilege;
import com.teampress.database.model.system.Role;
import com.teampress.database.model.system.RolePrivilege;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Objects;

@Service
public class RolePrivilegeService extends BaseService {

    public RolePrivilege find(Integer id){
        return (RolePrivilege) getEntityManager().createNamedQuery("RolePrivilege.findById").setParameter("pid", id).getResultList().get(0);
    }

    public List<RolePrivilege> findAll(){
        return getEntityManager().createNamedQuery("RolePrivilege.findAll").getResultList();
    }

    public List<RolePrivilege> findAllByRole(Collection<Role> roles){
        return (List<RolePrivilege>) getEntityManager().createNamedQuery("RolePrivilege.findAllByRoles").setParameter("proles", roles).getResultList();
    }

    public RolePrivilege findRolePrivilegeByRoleIdAndPrivilegeId(int roleId, int privilegeId) {
        List result = getEntityManager().createNamedQuery("RolePrivilege.findByRoleIdAndPrivilegeId")
                .setParameter("proleid", roleId)
                .setParameter("pprivilegeid", privilegeId)
                .getResultList();
        return result.isEmpty() ? null : (RolePrivilege) result.get(0);
    }

    public boolean existsByRoleIdAndPrivilegeId(int roleId, int privilegeId) {
        return Objects.nonNull(findRolePrivilegeByRoleIdAndPrivilegeId(roleId, privilegeId));
    }

    public boolean existsByRoleAndPrivilege(Role role, Privilege privilege) {
        return existsByRoleIdAndPrivilegeId(role.getId(), privilege.getId());
    }
}
