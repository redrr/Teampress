package com.teampress.database.service.financial;

import com.teampress.database.model.financial.Income;
import com.teampress.database.model.system.Organization;
import com.teampress.database.repository.financial.IncomeRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class IncomeService extends BaseService {

    @Autowired
    private IncomeRepository repository;

    public List<Income> findAll(){
        return repository.findAll();
    }

    public boolean exist(Integer id){
        return repository.existsById(id);
    }

    public Income find(Integer id){
        return repository.findById(id);
    }

    public List<Income> findByOrg(Organization organization){
        return repository.findAllByOrganization(organization);
    }

    public List<Income> findByOrgAndAccept(Organization organization, boolean accept){
        return repository.findAllByOrganizationAndAcceptAndDeleted(organization, accept, false);
    }

    public List<Income> findByOrgAcceptedDate(Organization organization, Date d1, Date d2){
        return repository.findAllByOrganizationAndCreationDateIsBetweenAndAcceptAndDeleted(organization, d1, d2, true, false);
    }

    public List<Income> findByOrgAndNotAcceptedYet(Organization organization){
        return repository.findAllByOrganizationAndDeletedAndAcceptIsNull(organization, false);
    }

    public Integer getValueBetweenDates(Organization organization, boolean isIncome, Date from, Date to){
        return repository.sumAmountByOrganizationAndIncomeBetweenDates(organization, isIncome, from, to);
    }
}
