package hu.playmaker.database.service.workout;

import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.trainingplan.TrainingPlan;
import hu.playmaker.database.model.workout.Jelenlet;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class JelenletService extends BaseService {

    public Long sum(User user, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Jelenlet.findSum").setParameter("pu", user).setParameter("pd1", date1).setParameter("pd2", date2).getResultList().get(0);
    }

    public Long count(User user, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Jelenlet.findCount").setParameter("pu", user).setParameter("pd1", date1).setParameter("pd2", date2).getResultList().get(0);
    }

    public Long sum(String user, Organization organization, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Jelenlet.findSumByTrainer").setParameter("pu", user).setParameter("porg", organization).setParameter("pd1", date1).setParameter("pd2", date2).getResultList().get(0);
    }

    public Long count(String user, Organization organization, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Jelenlet.findCountByTrainer").setParameter("pu", user).setParameter("porg", organization).setParameter("pd1", date1).setParameter("pd2", date2).getResultList().get(0);
    }

    public Jelenlet findMinByTeam(LookupCode lookupCode) {
        return (Jelenlet) getEntityManager().createNamedQuery("Jelenlet.findMinByTeam").setParameter("pteam", lookupCode).getResultList().get(0);
    }

    public Jelenlet findMaxByTeam(LookupCode lookupCode) {
        return (Jelenlet) getEntityManager().createNamedQuery("Jelenlet.findMaxByTeam").setParameter("pteam", lookupCode).getResultList().get(0);
    }

    public Jelenlet findMinByOrg(Organization organization) {
        return (Jelenlet) getEntityManager().createNamedQuery("Jelenlet.findMinByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public Jelenlet findMaxByOrg(Organization organization) {
        return (Jelenlet) getEntityManager().createNamedQuery("Jelenlet.findMaxByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public List<Jelenlet> findAll() {
        return getEntityManager().createNamedQuery("Jelenlet.findAll").getResultList();
    }

    public String[] findLastFiveTrainingJelenByUser(User user){
        List<Jelenlet> queryResult = getEntityManager().createNamedQuery("Jelenlet.findByUserLastFive").setParameter("puser", user).getResultList();
        return process(queryResult);
    }

    public List<Jelenlet> findByDateAndTeam(Organization organization, LookupCode team, Date date1, Date date2) {
        return getEntityManager().createNamedQuery("Jelenlet.findByDateAndTeam").setParameter("pteam", team).setParameter("porg", organization).setParameter("pd1", date1).setParameter("pd2", date2).getResultList();
    }

    public boolean existByTrainingPlan(TrainingPlan trainingPlan) {
        return getEntityManager().createNamedQuery("Jelenlet.findByTraining").setParameter("ptraining", trainingPlan).getResultList().size() > 0;
    }

    private String[] process(List<Jelenlet> queryResult) {
        String[] result = {"","","","",""};
        int length = Math.min(queryResult.size(), 5);
        for(int i = 0; i < length; i++) {
            Jelenlet jelenlet = queryResult.get(i);
            result[i] = (jelenlet.getJelen().equals("jelen")) ? "+" : "-";
        }
        return result;
    }
}
