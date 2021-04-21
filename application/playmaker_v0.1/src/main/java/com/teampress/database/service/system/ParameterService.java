package com.teampress.database.service.system;

import com.teampress.common.enums.Parameters;
import com.teampress.database.model.system.Parameter;
import com.teampress.database.repository.system.ParameterRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class ParameterService extends BaseService {

    @Autowired
    private ParameterRepository repository;

    public Parameter find(Integer id){
        return repository.findById(id);
    }

    public List<Parameter> findAll(){
        return repository.findAll();
    }

    public Parameter findParameterByGroupAndCode(Parameters group, Parameters code){
        return repository.findByGroupAndCode(group.name(), code.name());
    }

    public List<Parameter> findParameterByGroup(String group){
        return repository.findAllByGroup(group);
    }

    public boolean existsByGroupAndCode(Parameters group, Parameters code){
        return repository.existsByGroupAndCode(group.name(), code.name());
    }
}
