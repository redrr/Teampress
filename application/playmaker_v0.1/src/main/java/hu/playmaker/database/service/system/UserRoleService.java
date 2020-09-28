package hu.playmaker.database.service.system;

import hu.playmaker.database.model.system.Role;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserRole;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class UserRoleService extends BaseService {

    public List<UserRole> findAll(){
        return (List<UserRole>) getEntityManager().createNamedQuery("UserRole.findAll").getResultList();
    }

    public List<UserRole> findAllByUserId(int userid){
        return (List<UserRole>) getEntityManager().createNamedQuery("UserRole.findAllByUserId").setParameter("puid", userid).getResultList();
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
        List result = getEntityManager().createNamedQuery("UserRole.findById").setParameter("pid", id).getResultList();
        return result.isEmpty() ? null : (UserRole)result.get(0);
    }

    public boolean existsByUserAndRole(User user, Role role) {
        return existsByUserIdAndRoleId(user.getId(), role.getId());
    }
}
