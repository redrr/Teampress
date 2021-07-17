package com.teampress.database.repository.trainingplan;

import com.teampress.controller.admin.OrganizationController;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.trainingplan.TrainingPlan;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;

public interface TrainingPlanRepository extends CrudRepository<TrainingPlan, Long> {

    List<TrainingPlan> findAll();

    TrainingPlan findById(Integer id);

    boolean existsByOrganizationAndTeamAndTrainingDate(Organization organization, LookupCode team, Date date);

    TrainingPlan getFirstByOrganizationAndTeamAndTrainingDate(Organization organization, LookupCode team, Date date);

    List<TrainingPlan> findAllByCreatedBy(String by);

    List<TrainingPlan> findAllByOrganizationAndTeam(Organization organization, LookupCode team);

    List<TrainingPlan> findAllByOrganization(Organization organization);

    TrainingPlan getFirstByOrganizationAndTeamAndTrainingDateGreaterThanOrderByTrainingDateDesc(Organization organization, LookupCode team, Date today);
}
