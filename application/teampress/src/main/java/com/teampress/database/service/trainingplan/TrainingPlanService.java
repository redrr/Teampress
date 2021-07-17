package com.teampress.database.service.trainingplan;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.trainingplan.TrainingPlan;
import com.teampress.database.model.trainingplan.TrainingPlanConnection;
import com.teampress.database.repository.trainingplan.TrainingPlanRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class TrainingPlanService extends BaseService {

    @Autowired
    private TrainingPlanRepository repository;

    public TrainingPlan findUnique(Integer id) {
        return repository.findById(id);
    }

    public boolean existUnique(Organization o, LookupCode t, Date d) {
        return repository.existsByOrganizationAndTeamAndTrainingDate(o, t, d);
    }

    public TrainingPlan findUnique(Organization o, LookupCode t, Date d) {
        return repository.getFirstByOrganizationAndTeamAndTrainingDate(o, t, d);
    }

    public List<TrainingPlan> findAllCreatedBy(String username) {
        return repository.findAllByCreatedBy(username);
    }

    public List<TrainingPlan> findAllByTeam(LookupCode team, Organization organization) {
        return repository.findAllByOrganizationAndTeam(organization, team);
    }

    public List<TrainingPlan> findAllByOrg(Organization organization) {
        return repository.findAllByOrganization(organization);
    }

    public TrainingPlan findNextTrainingPlan(Organization organization, LookupCode team) {
        return repository.getFirstByOrganizationAndTeamAndTrainingDateGreaterThanOrderByTrainingDateDesc(organization, team, new Date());
    }
}
