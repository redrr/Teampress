package com.teampress.database.repository.system;

import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.TrainerRating;
import com.teampress.database.model.system.User;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface TrainerRatingRepository extends CrudRepository<TrainerRating, Long> {

    List<TrainerRating> findAll();

    TrainerRating findById(Integer id);

    boolean existsById(Integer id);

    List<TrainerRating> findAllByDoneIsNullAndOrganization(Organization organization);

    boolean existsByUserAndDoneIsNull(User user);

    TrainerRating findByDoneIsNullAndUserOrderByIdDesc(User user);
}
