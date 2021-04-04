package com.teampress.database.service.financial;

import com.teampress.database.model.financial.AnnualPayment;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnnualPaymentService extends BaseService {

    public boolean exist(Integer id) {
        return getEntityManager().createNamedQuery("AnnualPayment.findById").setParameter("pid", id).getResultList().size() > 0;
    }

    public AnnualPayment find(Integer id) {
        return (AnnualPayment) getEntityManager().createNamedQuery("AnnualPayment.findById").setParameter("pid", id).getSingleResult();
    }

    public List<AnnualPayment> findByDay(Integer day) {
        return getEntityManager().createNamedQuery("AnnualPayment.findByDay").setParameter("pd", day).getResultList();
    }

    public List<AnnualPayment> findAll(){
        return (List<AnnualPayment>) getEntityManager().createNamedQuery("AnnualPayment.findAll").getResultList();
    }
}
