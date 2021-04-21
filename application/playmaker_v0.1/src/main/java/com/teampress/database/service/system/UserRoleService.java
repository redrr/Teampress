package com.teampress.database.service.system;

import com.teampress.database.model.system.Role;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserRole;
import com.teampress.database.repository.system.UserRoleRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class UserRoleService extends BaseService {

    @Autowired
    private UserRoleRepository repository;

    public List<UserRole> findAll(){
        return repository.findAll();
    }

    public List<Role> findAllRoleByUser(User user) {
        return repository.findAllRoleByUser(user);
    }

    public UserRole find(Integer id){
        return repository.findById(id);
    }
}
