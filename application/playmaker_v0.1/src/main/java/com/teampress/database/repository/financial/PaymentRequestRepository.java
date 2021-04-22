package com.teampress.database.repository.financial;

import com.teampress.database.model.financial.PaymentRequest;
import com.teampress.database.model.gameplan.CustomGame;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;

public interface PaymentRequestRepository extends CrudRepository<PaymentRequest, Long> {

    List<PaymentRequest> findAll();

    PaymentRequest findById(Integer id);

    List<PaymentRequest> findAllByOrganizationAndUserAndDeleted(Organization organization, User user, boolean deleted);

    List<PaymentRequest> findAllByOrganizationAndCreatedBy(Organization organization, String by);
}
