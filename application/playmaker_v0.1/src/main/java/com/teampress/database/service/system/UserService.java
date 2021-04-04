package com.teampress.database.service.system;

import com.teampress.database.model.system.User;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService extends BaseService {

    public List<User> findAll(){
        return getEntityManager().createNamedQuery("User.findAll").getResultList();
    }

    public List<User> findAllPlayer(){
        return getEntityManager().createNamedQuery("User.findAllPlayer").getResultList();
    }

    public User findEnabledUserByUsername(String username) {
        List result = getEntityManager().createNamedQuery("User.findEnabledUserByName").setParameter("pusername", username).getResultList();
        return result.size() == 1 ? (User) result.get(0) : null;
    }

    public User findUserByEmail(String mail) {
        List result = getEntityManager().createNamedQuery("User.findEnabledUserByMail").setParameter("pmail", mail).getResultList();
        return result.size() == 1 ? (User) result.get(0) : null;
    }

    public User find(Integer id) {
        List result = getEntityManager().createNamedQuery("User.findById").setParameter("pid", id).getResultList();
        return result.size() == 1 ? (User) result.get(0) : null;
    }

    public boolean existsByUsername(String username) {
        return getEntityManager().createNamedQuery("User.findEnabledUserByName").setParameter("pusername", username).getResultList().size() > 0;
    }

    public boolean existsByUsernameAndAllDeleted(String username) {
        List<User> result = getEntityManager().createNamedQuery("User.existsByUserName").setParameter("pusername", username).getResultList();
        if(result.size() > 0){
            int deleted = 0;
            for(User u : result){
                if (u.isDeleted()) deleted++;
            }
            if (deleted == result.size()) return true;
        }
        return false;
    }
}
