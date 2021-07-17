package com.teampress.database.repository.system;

import com.teampress.database.model.system.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserRepository extends CrudRepository<User, Long> {

    List<User> findAll();

    User findById(Integer id);

    boolean existsById(Integer id);

    List<User> findAllByEnabledAndPlayer(boolean enabled, boolean player);

    User findByUsernameAndEnabledAndDeleted(String username, boolean enabled, boolean deleted);

    User findByEmailAndEnabledAndDeleted(String mail, boolean enabled, boolean deleted);

    User findByUsername(String username);
}
