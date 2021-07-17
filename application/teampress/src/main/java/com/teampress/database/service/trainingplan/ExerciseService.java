package com.teampress.database.service.trainingplan;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.trainingplan.Exercise;
import com.teampress.database.repository.trainingplan.ExerciseRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExerciseService extends BaseService {

    @Autowired
    private ExerciseRepository repository;

    public List<Exercise> findAll(){
        return repository.findAll();
    }

    public Exercise findTrainingTypeByTypeAndName(LookupCode type, String name){
        return repository.getFirstByTypeAndName(type, name);
    }

    public boolean exist(LookupCode type, String name){
        return repository.existsByTypeAndName(type, name);
    }

    public Exercise find(Integer id){
        return repository.findById(id);
    }

    public boolean exist(Integer id){
        return repository.existsById(id);
    }

    public List<Exercise> findAllByCreatedBy(String username) {
        return repository.findAllByCreatedBy(username);
    }
}
