package com.teampress.database.service.system;

import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserNotification;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserNotificationService extends BaseService {

    public List<UserNotification> findAll() {
        return getEntityManager().createNamedQuery("UserNotification.findAll").getResultList();
    }

    public List<UserNotification> findAllByUser(User user){
        return (List<UserNotification>) getEntityManager().createNamedQuery("UserNotification.findByUser").setParameter("pu", user).getResultList();
    }

    public boolean exist(Integer id) {
        return getEntityManager().createNamedQuery("UserNotification.findById").setParameter("pid", id).getResultList().size() > 0;
    }

    public UserNotification find(Integer id) {
        return (UserNotification)getEntityManager().createNamedQuery("UserNotification.findById").setParameter("pid", id).getResultList().get(0);
    }

    public List<UserNotification> findAllByUUID(String uuid) {
        return (List<UserNotification>)getEntityManager().createNamedQuery("UserNotification.findByUUID").setParameter("puuid", uuid).getResultList();
    }
}
