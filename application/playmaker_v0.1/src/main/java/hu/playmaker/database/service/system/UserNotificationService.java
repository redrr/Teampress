package hu.playmaker.database.service.system;

import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserNotification;
import hu.playmaker.database.service.BaseService;
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
}