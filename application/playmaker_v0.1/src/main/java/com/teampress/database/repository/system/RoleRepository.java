package com.teampress.database.repository.system;

import com.teampress.database.model.system.Role;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface RoleRepository extends CrudRepository<Role, Long> {

    List<Role> findAll();

    Role findById(Integer id);

    boolean existsByName(String name);

    Role findByName(String name);
}
