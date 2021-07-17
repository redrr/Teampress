package com.teampress.database.repository.system;

import com.teampress.database.model.system.Role;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserRole;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserRoleRepository extends CrudRepository<UserRole, Long> {

    List<UserRole> findAll();

    UserRole findById(Integer id);

    @Query("SELECT ur.role FROM UserRole ur WHERE ur.user = :user")
    List<Role> findAllRoleByUser(User user);
}
