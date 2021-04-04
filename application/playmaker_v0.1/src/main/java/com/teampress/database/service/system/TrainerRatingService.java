package com.teampress.database.service.system;

import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.TrainerRating;
import com.teampress.database.model.system.User;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainerRatingService extends BaseService {

    public List<TrainerRating> findAll() {
        return getEntityManager().createNamedQuery("TrainerRating.findAll").getResultList();
    }

    public List<TrainerRating> findByNull(Organization organization) {
        return getEntityManager().createNamedQuery("TrainerRating.findByNull").setParameter("porg", organization).getResultList();
    }

    public boolean exist(Integer id) {
        return getEntityManager().createNamedQuery("TrainerRating.findById").setParameter("pid", id).getResultList().size() > 0;
    }

    public TrainerRating find(Integer id) {
        return (TrainerRating)getEntityManager().createNamedQuery("TrainerRating.findById").setParameter("pid", id).getResultList().get(0);
    }

    public boolean existByUser(User user) {
        return getEntityManager().createNamedQuery("TrainerRating.findByUser").setParameter("pu", user).getResultList().size() > 0;
    }

    public TrainerRating findByUser(User user) {
        return (TrainerRating)getEntityManager().createNamedQuery("TrainerRating.findByUser").setParameter("pu", user).getResultList().get(0);
    }
}
