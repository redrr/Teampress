package com.teampress.database.service.system;

import com.teampress.database.model.system.Role;
import com.teampress.database.repository.system.RoleRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class RoleService extends BaseService {

    @Autowired
    private RoleRepository repository;

    public Role find(Integer id){
        return repository.findById(id);
    }

    public List<Role> findAll(){
        return repository.findAll();
    }

    public Role findRoleByName(String name){
        return repository.findByName(name);
    }

    public boolean existsByName(String name){
        return repository.existsByName(name);
    }
}
