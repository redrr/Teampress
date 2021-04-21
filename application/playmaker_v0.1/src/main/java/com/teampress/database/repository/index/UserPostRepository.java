package com.teampress.database.repository.index;

import com.teampress.database.model.index.UserPost;
import com.teampress.database.model.system.Role;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserPostRepository extends CrudRepository<UserPost, Long> {

    List<UserPost> findAll();

    UserPost findById(Integer id);
}
