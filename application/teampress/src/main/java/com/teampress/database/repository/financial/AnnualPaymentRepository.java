package com.teampress.database.repository.financial;

import com.teampress.database.model.financial.AnnualPayment;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface AnnualPaymentRepository extends CrudRepository<AnnualPayment, Long> {

    List<AnnualPayment> findAllByDeleted(boolean deleted);

    AnnualPayment findById(Integer id);

    boolean existsById(Integer id);

    List<AnnualPayment> findAllByDayAndDeleted(Integer day, boolean deleted);
}
