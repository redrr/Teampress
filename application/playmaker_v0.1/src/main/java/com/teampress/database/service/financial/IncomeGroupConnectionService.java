package com.teampress.database.service.financial;

import com.teampress.database.model.financial.Income;
import com.teampress.database.model.financial.IncomeGroup;
import com.teampress.database.model.financial.IncomeGroupConnection;
import com.teampress.database.model.system.Organization;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class IncomeGroupConnectionService extends BaseService {

    public List<IncomeGroupConnection> findAll(){
        return getEntityManager().createNamedQuery("IncomeGroupConnection.findAll").getResultList();
    }

    public List<IncomeGroupConnection> findByOrg(Organization organization, Date p1, Date d2){
        return getEntityManager().createNamedQuery("IncomeGroupConnection.findByOrg").setParameter("porg", organization).setParameter("pd1", p1).setParameter("pd2", d2).getResultList();
    }

    public boolean exist(int id){
        return findById(id).size() > 0;
    }

    public IncomeGroupConnection find(int id){
        return findById(id).get(0);
    }

    private List<IncomeGroupConnection> findById(int id){
        return getEntityManager().createNamedQuery("IncomeGroupConnection.findById").setParameter("pid", id).getResultList();
    }

    public boolean exist(IncomeGroup group){
        return findByGroup(group).size() > 0;
    }

    private List<IncomeGroupConnection> findByGroup(IncomeGroup group) {
        return getEntityManager().createNamedQuery("IncomeGroupConnection.findByGroup").setParameter("pgroup", group).getResultList();

    }

    public boolean exist(Income income){
        return findByIncome(income).size() > 0;
    }

    public IncomeGroupConnection find(Income income){
        return findByIncome(income).get(0);
    }

    private List<IncomeGroupConnection> findByIncome(Income income) {
        return getEntityManager().createNamedQuery("IncomeGroupConnection.findByIncome").setParameter("pincome", income).getResultList();

    }

    public List<IncomeGroupConnection> findAllCreatedBy(String createdBy){
        return getEntityManager().createNamedQuery("IncomeGroupConnection.findAllCreatedBy").setParameter("pby", createdBy).getResultList();
    }
}
