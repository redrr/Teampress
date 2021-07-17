package com.teampress.database.service.system;

import com.teampress.database.model.system.User;
import com.teampress.database.repository.system.UserRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService extends BaseService {

    @Autowired
    private UserRepository repository;

    public List<User> findAll(){
        return repository.findAll();
    }

    public List<User> findAllPlayer(){
        return repository.findAllByEnabledAndPlayer(true, true);
    }

    public User findEnabledUserByUsername(String username) {
        return repository.findByUsernameAndEnabledAndDeleted(username, true, false);
    }

    public User findUserByEmail(String mail) {
        return repository.findByEmailAndEnabledAndDeleted(mail, true, false);
    }

    public User find(Integer id) {
        return repository.findById(id);
    }

    public User findByUsername(String username) {
        return repository.findByUsername(username);
    }
}
