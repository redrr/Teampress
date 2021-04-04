package com.teampress.database.service.trainingplan;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.trainingplan.Exercise;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ExerciseService extends BaseService {

    public List<Exercise> findAll(){
        return getEntityManager().createNamedQuery("Exercise.findAll").getResultList();
    }

    public Exercise findTrainingTypeByTypeAndName(LookupCode type, String name){
        List results = getEntityManager().createNamedQuery("Exercise.findByLocaleAndCode")
                .setParameter("ptype", type)
                .setParameter("pname", name)
                .getResultList();
        return results.isEmpty()?null:(Exercise)results.get(0);
    }

    public boolean exist(LookupCode type, String name){
        List results = getEntityManager().createNamedQuery("Exercise.findByLocaleAndCode")
                .setParameter("ptype", type)
                .setParameter("pname", name)
                .getResultList();
        return !results.isEmpty();
    }

    public Exercise find(Integer id){
        return (Exercise) getEntityManager().createNamedQuery("Exercise.findById").setParameter("pid", id).getSingleResult();
    }

    public boolean exist(Integer id){
        return getEntityManager().createNamedQuery("Exercise.findById").setParameter("pid", id).getResultList().size() > 0;
    }

    public ArrayList<Exercise> findByOrg(Organization organization) {
        return (ArrayList<Exercise>) getEntityManager().createNamedQuery("Exercise.findByOrg").setParameter("porg", organization).getResultList();
    }

    public ArrayList<Exercise> findAllByCreatedBy(String username) {
        return (ArrayList<Exercise>) getEntityManager().createNamedQuery("Exercise.findByCr").setParameter("pcrBy", username).getResultList();
    }
}
