package com.teampress.database.service.gameplan;

import com.teampress.database.model.gameplan.CustomGame;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.repository.gameplan.CustomGameRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class CustomGameService extends BaseService {

    @Autowired
    private CustomGameRepository repository;

    public List<CustomGame> findAll(){
        return repository.findAll();
    }

    public boolean exist(LookupCode team, Date date){
        return repository.existsByTeamAndDate(team, date);
    }

    public CustomGame find(Integer id){
        return repository.findById(id);
    }

    public List<CustomGame> findByCreated(String createdBy){
        return repository.findAllByCreatedByAndDeleted(createdBy, false);
    }
}
