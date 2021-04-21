package com.teampress.database.service.system;

import com.teampress.database.model.system.TrainerRatingResult;
import com.teampress.database.repository.system.TrainerRatingResultRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainerRatingResultService extends BaseService {

    @Autowired
    private TrainerRatingResultRepository repository;

    public List<TrainerRatingResult> findAll() {
        return repository.findAll();
    }

    public boolean exist(Integer id) {
        return repository.existsById(id);
    }

    public TrainerRatingResult find(Integer id) {
        return repository.findById(id);
    }
}
