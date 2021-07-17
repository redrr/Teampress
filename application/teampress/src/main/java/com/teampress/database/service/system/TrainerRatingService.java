package com.teampress.database.service.system;

import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.TrainerRating;
import com.teampress.database.model.system.User;
import com.teampress.database.repository.system.TrainerRatingRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TrainerRatingService extends BaseService {

    @Autowired
    private TrainerRatingRepository repository;

    public List<TrainerRating> findAll() {
        return repository.findAll();
    }

    public List<TrainerRating> findByNull(Organization organization) {
        return repository.findAllByDoneIsNullAndOrganization(organization);
    }

    public boolean exist(Integer id) {
        return repository.existsById(id);
    }

    public TrainerRating find(Integer id) {
        return repository.findById(id);
    }

    public boolean existByUser(User user) {
        return repository.existsByUserAndDoneIsNull(user);
    }

    public TrainerRating findByUser(User user) {
        return repository.findByDoneIsNullAndUserOrderByIdDesc(user);
    }
}
