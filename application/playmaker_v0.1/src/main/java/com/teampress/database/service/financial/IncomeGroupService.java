package com.teampress.database.service.financial;

import com.teampress.database.model.financial.IncomeGroup;
import com.teampress.database.model.system.Organization;
import com.teampress.database.repository.financial.IncomeGroupRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IncomeGroupService extends BaseService {

    @Autowired
    private IncomeGroupRepository repository;

    public List<IncomeGroup> findAll(){
        return repository.findAll();
    }

    public List<IncomeGroup> findAll(Organization organization){
        return repository.findAllByOrganizationAndDeleted(organization, false);
    }

    public boolean exist(Integer id){
        return repository.existsById(id);
    }

    public IncomeGroup find(Integer id){
        return repository.findById(id);
    }

    public List<IncomeGroup> findAllCreatedBy(String createdBy, Organization organization){
        return repository.findAllByOrganizationAndDeletedAndCreatedBy(organization, false, createdBy);
    }
}
