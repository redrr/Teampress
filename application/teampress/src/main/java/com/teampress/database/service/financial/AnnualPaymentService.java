package com.teampress.database.service.financial;

import com.teampress.database.model.financial.AnnualPayment;
import com.teampress.database.repository.financial.AnnualPaymentRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnnualPaymentService extends BaseService {

    @Autowired
    private AnnualPaymentRepository repository;

    public boolean exist(Integer id) {
        return repository.existsById(id);
    }

    public AnnualPayment find(Integer id) {
        return repository.findById(id);
    }

    public List<AnnualPayment> findByDay(Integer day) {
        return repository.findAllByDayAndDeleted(day, false);
    }

    public List<AnnualPayment> findAll(){
        return repository.findAllByDeleted(false);
    }
}
