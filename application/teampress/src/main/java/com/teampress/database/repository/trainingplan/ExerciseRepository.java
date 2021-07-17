package com.teampress.database.repository.trainingplan;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.trainingplan.Exercise;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ExerciseRepository extends CrudRepository<Exercise, Long> {

    List<Exercise> findAll();

    Exercise findById(Integer id);

    boolean existsById(Integer id);

    Exercise getFirstByTypeAndName(LookupCode type, String name);

    boolean existsByTypeAndName(LookupCode type, String name);

    List<Exercise> findAllByCreatedBy(String by);
}
