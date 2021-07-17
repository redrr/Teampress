package com.teampress.database.service.system;

import com.teampress.database.model.system.Privilege;
import com.teampress.database.model.system.Role;
import com.teampress.database.model.system.RolePrivilege;
import com.teampress.database.repository.system.RolePrivilegeRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;
import java.util.Objects;

@Service
public class RolePrivilegeService extends BaseService {

    @Autowired
    private RolePrivilegeRepository repository;

    public RolePrivilege find(Integer id){
        return repository.findById(id);
    }

    public List<RolePrivilege> findAll(){
        return repository.findAll();
    }

    public List<RolePrivilege> findAllByRole(List<Role> roles){
        return repository.findAllByRoleIn(roles);
    }
}
