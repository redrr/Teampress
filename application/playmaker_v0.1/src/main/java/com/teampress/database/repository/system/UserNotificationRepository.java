package com.teampress.database.repository.system;

import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserNotification;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserNotificationRepository extends CrudRepository<UserNotification, Long> {

    List<UserNotification> findAll();

    UserNotification findById(Integer id);

    boolean existsById(Integer id);

    List<UserNotification> findAllByUuid(String uuid);

    List<UserNotification> findAllByUserAndSeenOrderByCreationDateDesc(User user, boolean seen);
}
