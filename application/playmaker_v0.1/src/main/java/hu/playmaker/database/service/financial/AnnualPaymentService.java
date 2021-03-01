package hu.playmaker.database.service.financial;

import hu.playmaker.database.model.financial.AnnualPayment;
import hu.playmaker.database.model.financial.PaymentRequest;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnnualPaymentService extends BaseService {

    public List<AnnualPayment> findByDay(Integer day) {
        return getEntityManager().createNamedQuery("AnnualPayment.findByDay").setParameter("pd", day).getResultList();
    }

    public List<AnnualPayment> findByCreator(Organization organization, String name){
        return getEntityManager().createNamedQuery("AnnualPayment.findByCreator").setParameter("porg", organization).setParameter("pn", name).getResultList();
    }
}
