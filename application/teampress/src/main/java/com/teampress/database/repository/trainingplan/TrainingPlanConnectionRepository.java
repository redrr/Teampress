package com.teampress.database.repository.trainingplan;

import com.teampress.database.model.index.Calendar;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.trainingplan.TrainingPlan;
import com.teampress.database.model.trainingplan.TrainingPlanConnection;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TrainingPlanConnectionRepository extends CrudRepository<TrainingPlanConnection, Long> {

    List<TrainingPlanConnection> findAll();

    TrainingPlanConnection findById(Integer id);

    List<TrainingPlanConnection> findAllByTrainingPlanOrderBySortAsc(TrainingPlan plan);
}
