package hu.playmaker.database.service.workout;

import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.trainingplan.Exercise;
import hu.playmaker.database.model.trainingplan.TrainingPlan;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.workout.Workout;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Service
public class WorkoutService extends BaseService {

    public Long count(User user, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Workout.findCount").setParameter("puser", user).setParameter("pd1", date1).setParameter("pd2", date2).getSingleResult();
    }

    public Long sum(User user, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Workout.findSum").setParameter("puser", user).setParameter("pd1", date1).setParameter("pd2", date2).getSingleResult();
    }

    public Long sum(String user, Organization organization, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Workout.findSumByTrainer").setParameter("pd1", date1).setParameter("pd2", date2).getSingleResult();
    }

    public Workout findMinByTeam(LookupCode lookupCode) {
        return (Workout) getEntityManager().createNamedQuery("Workout.findMinByTeam").setParameter("pteam", lookupCode).getResultList().get(0);
    }

    public Workout findMaxByTeam(LookupCode lookupCode) {
        return (Workout) getEntityManager().createNamedQuery("Workout.findMaxByTeam").setParameter("pteam", lookupCode).getResultList().get(0);
    }

    public Workout findMinByOrg(Organization organization) {
        return (Workout) getEntityManager().createNamedQuery("Workout.findMinByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public Workout findMaxByOrg(Organization organization) {
        return (Workout) getEntityManager().createNamedQuery("Workout.findMaxByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public List<Workout> findAll(){
        return getEntityManager().createNamedQuery("Workout.findAll").getResultList();
    }

    public boolean existsByTraining(TrainingPlan trainingPlan, User user) {
        return getEntityManager().createNamedQuery("Workout.findByUserAndTraining").setParameter("ptraining", trainingPlan).setParameter("puser", user).getResultList().size() > 0;
    }

    public boolean getStatus(TrainingPlan trainingPlan) {
        return getEntityManager().createNamedQuery("Workout.findByTraining").setParameter("ptraining", trainingPlan).getResultList().size() > 0;
    }

    public ArrayList<Workout> findAllByTraining(TrainingPlan trainingPlan, User user){
        return (ArrayList<Workout>) getEntityManager().createNamedQuery("Workout.findByUserAndTraining").setParameter("ptraining", trainingPlan).setParameter("puser", user).getResultList();
    }

    public int avgExercise(TrainingPlan trainingPlan, Exercise exercise){
        ArrayList<Workout> list = (ArrayList<Workout>) getEntityManager().createNamedQuery("Workout.findByExerciseAndTraining").setParameter("ptraining", trainingPlan).setParameter("pex", exercise).getResultList();
        return avgEx(list);
    }

    public Workout findLastByUser(User user){
        return (Workout) getEntityManager().createNamedQuery("Workout.findByUser").setParameter("pu", user).getResultList().get(0);
    }

    private int avgEx(ArrayList<Workout> list){
        int count = 0;
        double sum = 0.0;
        for (Workout workout : list){
            if(Objects.nonNull(workout.getResultPercent())) {
                sum += workout.getResultPercent();
                count++;
            }
        }
        return (int)Math.round(sum/count);
    }
}
