package hu.playmaker.database.service.system;

import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.TrainerRating;
import hu.playmaker.database.model.system.TrainerRatingResult;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.workout.Workout;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class TrainerRatingResultService extends BaseService {

    public List<TrainerRatingResult> findAll() {
        return getEntityManager().createNamedQuery("TrainerRatingResult.findAll").getResultList();
    }

    public boolean exist(Integer id) {
        return getEntityManager().createNamedQuery("TrainerRatingResult.findById").setParameter("pid", id).getResultList().size() > 0;
    }

    public TrainerRatingResult find(Integer id) {
        return (TrainerRatingResult)getEntityManager().createNamedQuery("TrainerRatingResult.findById").setParameter("pid", id).getResultList().get(0);
    }


    public TrainerRatingResult findMinByOrg(Organization organization) {
        return (TrainerRatingResult) getEntityManager().createNamedQuery("TrainerRatingResult.findMinByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public TrainerRatingResult findMaxByOrg(Organization organization) {
        return (TrainerRatingResult) getEntityManager().createNamedQuery("TrainerRatingResult.findMaxByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public Double avr(Organization organization, User user, Date fromDate, Date toDate) {
        return (Double) getEntityManager().createNamedQuery("TrainerRatingResult.findAvgByTrainer").setParameter("porg", organization).setParameter("pu", user).setParameter("pd1", fromDate).setParameter("pd2", toDate).getSingleResult();
    }
}