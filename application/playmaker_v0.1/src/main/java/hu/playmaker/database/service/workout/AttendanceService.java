package hu.playmaker.database.service.workout;

import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.trainingplan.TrainingPlan;
import hu.playmaker.database.model.workout.Attendance;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class AttendanceService extends BaseService {

    public Long sum(User user, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Attendance.findSum").setParameter("pu", user).setParameter("pd1", date1).setParameter("pd2", date2).getResultList().get(0);
    }

    public Long count(User user, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Attendance.findCount").setParameter("pu", user).setParameter("pd1", date1).setParameter("pd2", date2).getResultList().get(0);
    }

    public Long sum(String user, Organization organization, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Attendance.findSumByTrainer").setParameter("pu", user).setParameter("porg", organization).setParameter("pd1", date1).setParameter("pd2", date2).getResultList().get(0);
    }

    public Long count(String user, Organization organization, Date date1, Date date2) {
        return (Long) getEntityManager().createNamedQuery("Attendance.findCountByTrainer").setParameter("pu", user).setParameter("porg", organization).setParameter("pd1", date1).setParameter("pd2", date2).getResultList().get(0);
    }

    public Attendance findMinByTeam(LookupCode lookupCode) {
        return (Attendance) getEntityManager().createNamedQuery("Attendance.findMinByTeam").setParameter("pteam", lookupCode).getResultList().get(0);
    }

    public Attendance findMaxByTeam(LookupCode lookupCode) {
        return (Attendance) getEntityManager().createNamedQuery("Attendance.findMaxByTeam").setParameter("pteam", lookupCode).getResultList().get(0);
    }

    public Attendance findMinByOrg(Organization organization) {
        return (Attendance) getEntityManager().createNamedQuery("Attendance.findMinByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public Attendance findMaxByOrg(Organization organization) {
        return (Attendance) getEntityManager().createNamedQuery("Attendance.findMaxByOrg").setParameter("porg", organization).getResultList().get(0);
    }

    public List<Attendance> findAll() {
        return getEntityManager().createNamedQuery("Attendance.findAll").getResultList();
    }

    public String[] findLastFiveTrainingJelenByUser(User user){
        List<Attendance> queryResult = getEntityManager().createNamedQuery("Attendance.findByUserLastFive").setParameter("puser", user).getResultList();
        return process(queryResult);
    }

    public List<Attendance> findByDateAndTeam(Organization organization, LookupCode team, Date date1, Date date2) {
        return getEntityManager().createNamedQuery("Attendance.findByDateAndTeam").setParameter("pteam", team).setParameter("porg", organization).setParameter("pd1", date1).setParameter("pd2", date2).getResultList();
    }

    public boolean existByTrainingPlan(TrainingPlan trainingPlan) {
        return getEntityManager().createNamedQuery("Attendance.findByTraining").setParameter("ptraining", trainingPlan).getResultList().size() > 0;
    }

    private String[] process(List<Attendance> queryResult) {
        String[] result = {"","","","",""};
        int length = Math.min(queryResult.size(), 5);
        for(int i = 0; i < length; i++) {
            Attendance attendance = queryResult.get(i);
            result[i] = (attendance.getJelen().equals("jelen")) ? "+" : "-";
        }
        return result;
    }
}
