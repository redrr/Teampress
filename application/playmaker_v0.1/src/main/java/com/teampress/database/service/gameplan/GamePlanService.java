package com.teampress.database.service.gameplan;

import com.teampress.database.model.gameplan.CustomGame;
import com.teampress.database.model.gameplan.GamePlan;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.repository.gameplan.GamePlanRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GamePlanService extends BaseService {

    @Autowired
    private GamePlanRepository repository;

    public boolean exist(User user, CustomGame customGame){
        return repository.existsByCustomGameAndUser(customGame, user);
    }

    public boolean exist(CustomGame customGame){
        return repository.existsByCustomGame(customGame);
    }

    public List<GamePlan> findAll(){
        return repository.findAll();
    }

    public List<GamePlan> find(User user, CustomGame customGame){
        return repository.findAllByCustomGameAndUser(customGame, user);
    }

    public List<CustomGame> findByOrg(Organization organization){
        return repository.findCustomGamesByOrganization(organization);
    }
}
