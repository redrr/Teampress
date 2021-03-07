package hu.playmaker.database.service.financial;

import hu.playmaker.database.model.financial.PaymentRequest;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaymentRequestService extends BaseService {

    public List<PaymentRequest> findByOrg(Organization organization, User user){
        return getEntityManager().createNamedQuery("PaymentRequest.findByOrgAndUser").setParameter("porg", organization).setParameter("pu", user).getResultList();
    }

    public List<PaymentRequest> findByCreator(Organization organization, String name){
        return getEntityManager().createNamedQuery("PaymentRequest.findByCreator").setParameter("porg", organization).setParameter("pn", name).getResultList();
    }

    public List<PaymentRequest> collectByUUID(){
        return getEntityManager().createNamedQuery("PaymentRequest.collectByUUID").getResultList();
    }

    public PaymentRequest find(Integer id) {
        return (PaymentRequest) getEntityManager().createNamedQuery("PaymentRequest.findById").setParameter("pid", id).getSingleResult();
    }
}
