package com.teampress.database.repository.system;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.TrainerRatingResult;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TrainerRatingResultRepository extends CrudRepository<TrainerRatingResult, Long> {

    List<TrainerRatingResult> findAll();

    TrainerRatingResult findById(Integer id);

    boolean existsById(Integer id);
}
