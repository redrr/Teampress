package com.teampress.database.service.financial;

import com.teampress.database.model.financial.Income;
import com.teampress.database.model.financial.IncomeGroup;
import com.teampress.database.model.financial.IncomeGroupConnection;
import com.teampress.database.model.system.Organization;
import com.teampress.database.repository.financial.IncomeGroupConnectionRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class IncomeGroupConnectionService extends BaseService {

    @Autowired
    private IncomeGroupConnectionRepository repository;

    public List<IncomeGroupConnection> findAll(){
        return repository.findAll();
    }

    public boolean exist(Integer id){
        return repository.existsById(id);
    }

    public IncomeGroupConnection find(Integer id){
        return repository.findById(id);
    }

    public boolean exist(IncomeGroup group){
        return repository.existsByGroup(group);
    }

    public boolean exist(Income income){
        return repository.existsByIncome(income);
    }

    public IncomeGroupConnection find(Income income){
        return repository.findByIncome(income);
    }

    public List<IncomeGroupConnection> findByOrg(Organization organization, Date p1, Date d2){
        return repository.findAllByOrganizationAndBetweenDates(organization, p1, d2);
    }

    public List<IncomeGroupConnection> findAllCreatedBy(String createdBy){
        return repository.findAllByCreatedBy(createdBy);
    }
}
