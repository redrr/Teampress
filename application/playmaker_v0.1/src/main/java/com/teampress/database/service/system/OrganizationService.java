package com.teampress.database.service.system;

import com.teampress.database.model.system.Organization;
import com.teampress.database.repository.system.OrganizationRepository;
import com.teampress.database.service.BaseService;
import jdk.nashorn.internal.objects.annotations.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class OrganizationService extends BaseService {

    @Autowired
    private OrganizationRepository repository;

    public Organization find(Integer id){
        return repository.findById(id);
    }

    public List<Organization> findAll(){
        return repository.findAll();
    }

    public Organization findOrganizationByName(String name){
        return repository.findByName(name);
    }

    public boolean existsByName(String name){
        return repository.existsByName(name);
    }
}
