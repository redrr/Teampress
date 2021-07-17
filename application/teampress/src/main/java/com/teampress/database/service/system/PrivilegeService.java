package com.teampress.database.service.system;

import com.teampress.database.model.system.Privilege;
import com.teampress.database.repository.system.PrivilegeRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class PrivilegeService extends BaseService {

    @Autowired
    private PrivilegeRepository repository;

    public Privilege find(Integer id){
        return repository.findById(id);
    }

    public List<Privilege> findAll(){
        return repository.findAll();
    }

    public Privilege findPrivilegeByName(String name) {
        return repository.findByName(name);
    }

    public boolean existsByName(String name) {
        return repository.existsByName(name);
    }
}
