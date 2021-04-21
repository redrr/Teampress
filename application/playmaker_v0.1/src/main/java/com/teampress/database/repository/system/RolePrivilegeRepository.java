package com.teampress.database.repository.system;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Role;
import com.teampress.database.model.system.RolePrivilege;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface RolePrivilegeRepository extends CrudRepository<RolePrivilege, Long> {

    List<RolePrivilege> findAll();

    RolePrivilege findById(Integer id);

    List<RolePrivilege> findAllByRoleIn(List<Role> roles);
}
