package hu.playmaker.database.service.trainingplan;

import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.trainingplan.TrainingPlan;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class TrainingPlanService extends BaseService {

    public TrainingPlan findNext(Organization organization, LookupCode team) {
        List<TrainingPlan> result = getEntityManager().createNamedQuery("TrainingPlan.findNextTraining").setParameter("porg", organization).setParameter("pteam", team).setParameter("pdate", new Date()).getResultList();
        return result.size() == 0 ? null : result.get(0);
    }

    public Long count(String user,Organization organization , Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("TrainingPlan.findCount").setParameter("pu", user).setParameter("porg", organization).setParameter("pd1", date1).setParameter("pd2", date2).getResultList().get(0);
    }

    public List<TrainingPlan> findAll(){
        return getEntityManager().createNamedQuery("TrainingPlan.findAll").getResultList();
    }

    public boolean exist(Integer id) {
        return getEntityManager().createNamedQuery("TrainingPlan.findById").setParameter("pid", id).getResultList().size() > 0;
    }

    public TrainingPlan find(Integer id) {
        return (TrainingPlan) getEntityManager().createNamedQuery("TrainingPlan.findById").setParameter("pid", id).getSingleResult();
    }

    public TrainingPlan findMax(Organization organization) {
        return (TrainingPlan) getEntityManager().createNamedQuery("TrainingPlan.findMaxByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public TrainingPlan findMin(Organization organization) {
        return (TrainingPlan) getEntityManager().createNamedQuery("TrainingPlan.findMinByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public ArrayList<TrainingPlan> findAllCreatedBy(String username) {
        return (ArrayList<TrainingPlan>) getEntityManager().createNamedQuery("TrainingPlan.findAllCreatedBy").setParameter("pusername", username).getResultList();
    }

    public ArrayList<TrainingPlan> findAllByTeam(LookupCode team, Organization organization) {
        return (ArrayList<TrainingPlan>) getEntityManager().createNamedQuery("TrainingPlan.findByTeam").setParameter("pteam", team).setParameter("porg", organization).getResultList();
    }

    public ArrayList<TrainingPlan> findAllByOrg(Organization organization) {
        return (ArrayList<TrainingPlan>) getEntityManager().createNamedQuery("TrainingPlan.findByOrg").setParameter("porg", organization).getResultList();
    }
}
