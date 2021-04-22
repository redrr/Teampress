package com.teampress.database.repository.gameplan;

import com.teampress.database.model.gameplan.CustomGame;
import com.teampress.database.model.system.LookupCode;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;

public interface CustomGameRepository extends CrudRepository<CustomGame, Long> {

    List<CustomGame> findAll();

    CustomGame findById(Integer id);

    List<CustomGame> findAllByCreatedByAndDeleted(String name, boolean deleted);

    boolean existsByTeamAndDate(LookupCode team, Date date);

}
