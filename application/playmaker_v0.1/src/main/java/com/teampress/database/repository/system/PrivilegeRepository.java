package com.teampress.database.repository.system;

import com.teampress.database.model.system.Privilege;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface PrivilegeRepository extends CrudRepository<Privilege, Long> {

    List<Privilege> findAll();

    Privilege findById(Integer id);

    boolean existsByName(String name);

    Privilege findByName(String name);
}
