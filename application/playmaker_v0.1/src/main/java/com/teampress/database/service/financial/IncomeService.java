package com.teampress.database.service.financial;

import com.teampress.database.model.financial.Income;
import com.teampress.database.model.system.Organization;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class IncomeService extends BaseService {

    public List<Income> findAll(){
        return getEntityManager().createNamedQuery("Income.findAll").getResultList();
    }

    public boolean exist(int id){
        return findById(id).size() > 0;
    }

    public Income find(int id){
        return findById(id).get(0);
    }

    private List<Income> findById(int id){
        return getEntityManager().createNamedQuery("Income.findById").setParameter("pid", id).getResultList();
    }

    public Income findByUUID(String id){
        return (Income) getEntityManager().createNamedQuery("Income.findByUUID").setParameter("pid", id).getSingleResult();
    }

    public List<Income> findByOrg(Organization organization){
        return getEntityManager().createNamedQuery("Income.findByOrg").setParameter("porg", organization).getResultList();
    }

    public List<Income> findByOrgAndAccept(Organization organization, boolean accept){
        return getEntityManager().createNamedQuery("Income.findByOrgAndAccept").setParameter("porg", organization).setParameter("pa", accept).getResultList();
    }

    public List<Income> findByOrgAcceptedDate(Organization organization, Date d1, Date d2){
        return getEntityManager().createNamedQuery("Income.findByOrgAcceptedDate").setParameter("porg", organization).setParameter("pd1", d1).setParameter("pd2", d2).getResultList();
    }

    public List<Income> findByOrgAndNotAcceptedYet(Organization organization){
        return getEntityManager().createNamedQuery("Income.findByOrgAndNotAcceptedYet").setParameter("porg", organization).getResultList();
    }

    public Object getValueBetweenDates(Organization organization, boolean isIncome, Date from, Date to){
        return getEntityManager().createNamedQuery("Income.sumPrizeByDate")
                .setParameter("porg", organization)
                .setParameter("pincome", isIncome)
                .setParameter("pd1", from)
                .setParameter("pd2", to)
                .getSingleResult();
    }
}
