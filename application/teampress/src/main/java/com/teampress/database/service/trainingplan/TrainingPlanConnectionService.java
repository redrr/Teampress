package com.teampress.database.service.trainingplan;

import com.teampress.database.model.trainingplan.TrainingPlan;
import com.teampress.database.model.trainingplan.TrainingPlanConnection;
import com.teampress.database.repository.trainingplan.TrainingPlanConnectionRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainingPlanConnectionService extends BaseService {

    @Autowired
    private TrainingPlanConnectionRepository repository;

    public List<TrainingPlanConnection> findAll(){
        return repository.findAll();
    }

    public TrainingPlanConnection find(Integer id) {
        return repository.findById(id);
    }

    public List<TrainingPlanConnection> findByTrainingPlanSorted(TrainingPlan trainingPlan) {
        return repository.findAllByTrainingPlanOrderBySortAsc(trainingPlan);
    }
}
