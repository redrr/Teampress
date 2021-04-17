package com.teampress.database.service.system;

import com.teampress.database.model.system.Role;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserRole;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class UserRoleService extends BaseService {

    public List<UserRole> findAll(){
        return (List<UserRole>) getEntityManager().createNamedQuery("UserRole.findAll").getResultList();
    }

    public List<Role> findAllRoleByUser(User user){
        return (List<Role>) getEntityManager().createNamedQuery("UserRole.findAllByUser").setParameter("pu", user).getResultList();
    }

    public UserRole findUserRoleByUserIdAndRoleId(int userid, int roleid) {
        List result = getEntityManager().createNamedQuery("UserRole.findByUserIdAndRoleId")
                .setParameter("prid", roleid)
                .setParameter("puid", userid)
                .getResultList();
        return result.isEmpty() ? null : (UserRole) result.get(0);
    }

    public boolean existsByUserIdAndRoleId(int userid, int roleid) {
        return Objects.nonNull(findUserRoleByUserIdAndRoleId(userid, roleid));
    }

    public UserRole find(Integer id){
        return (UserRole) getEntityManager().createNamedQuery("UserRole.findById").setParameter("pid", id).getSingleResult();
    }

    public boolean existsByUserAndRole(User user, Role role) {
        return existsByUserIdAndRoleId(user.getId(), role.getId());
    }
}
