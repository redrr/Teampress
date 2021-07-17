package com.teampress.database.service.system;

import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserNotification;
import com.teampress.database.repository.system.UserNotificationRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserNotificationService extends BaseService {

    @Autowired
    private UserNotificationRepository repository;

    public List<UserNotification> findAll() {
        return repository.findAll();
    }

    public List<UserNotification> findAllByUser(User user){
        return repository.findAllByUserAndSeenOrderByCreationDateDesc(user, false);
    }

    public boolean exist(Integer id) {
        return repository.existsById(id);
    }

    public UserNotification find(Integer id) {
        return repository.findById(id);
    }

    public List<UserNotification> findAllByUUID(String uuid) {
        return repository.findAllByUuid(uuid);
    }
}
