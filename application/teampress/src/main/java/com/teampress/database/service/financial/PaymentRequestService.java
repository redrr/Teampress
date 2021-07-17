package com.teampress.database.service.financial;

import com.teampress.database.model.financial.PaymentRequest;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.repository.financial.PaymentRequestRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaymentRequestService extends BaseService {

    @Autowired
    private PaymentRequestRepository repository;

    public List<PaymentRequest> findByOrg(Organization organization, User user){
        return repository.findAllByOrganizationAndUserAndDeleted(organization, user, false);
    }

    public List<PaymentRequest> findByCreator(Organization organization, String name){
        return repository.findAllByOrganizationAndCreatedBy(organization, name);
    }

    public List<PaymentRequest> collectByUUID(){
        return getEntityManager().createNamedQuery("PaymentRequest.collectByUUID").getResultList();
    }

    public PaymentRequest find(Integer id) {
        return repository.findById(id);
    }
}
