package com.teampress.database.service.trainingplan;

import com.teampress.database.model.trainingplan.TrainingPlan;
import com.teampress.database.model.trainingplan.TrainingPlanConnection;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainingPlanConnectionService extends BaseService {

    public List<TrainingPlanConnection> findByTraining(TrainingPlan trainingPlan) {
        return (List<TrainingPlanConnection>) getEntityManager().createNamedQuery("TrainingPlanConnection.findByTraining").setParameter("pt", trainingPlan).getResultList();
    }

    public TrainingPlanConnection find(Integer id) {
        return (TrainingPlanConnection) getEntityManager().createNamedQuery("TrainingPlanConnection.findById").setParameter("pid", id).getSingleResult();
    }
}
