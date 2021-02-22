package hu.playmaker.database.service.trainingplan;

import hu.playmaker.database.model.trainingplan.TrainingPlan;
import hu.playmaker.database.model.trainingplan.TrainingPlanConnection;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TrainingPlanConnectionService extends BaseService {

    public List<TrainingPlanConnection> findByTraining(TrainingPlan trainingPlan) {
        return (List<TrainingPlanConnection>) getEntityManager().createNamedQuery("TrainingPlanConnection.findByTraining").setParameter("pt", trainingPlan).getResultList();
    }

    public TrainingPlanConnection find(Integer id) {
        return (TrainingPlanConnection) getEntityManager().createNamedQuery("TrainingPlanConnection.findById").setParameter("pid", id).getSingleResult();
    }
}
