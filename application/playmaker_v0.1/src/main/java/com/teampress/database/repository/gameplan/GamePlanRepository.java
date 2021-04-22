package com.teampress.database.repository.gameplan;

import com.teampress.database.model.gameplan.CustomGame;
import com.teampress.database.model.gameplan.GamePlan;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface GamePlanRepository extends CrudRepository<GamePlan, Long> {

    List<GamePlan> findAll();

    boolean existsByCustomGameAndUser(CustomGame game, User user);

    List<GamePlan> findAllByCustomGameAndUser(CustomGame game, User user);

    boolean existsByCustomGame(CustomGame game);

    @Query("SELECT p.customGame FROM GamePlan p WHERE p.organization=:organization GROUP BY p.customGame")
    List<CustomGame> findCustomGamesByOrganization(Organization organization);
}
