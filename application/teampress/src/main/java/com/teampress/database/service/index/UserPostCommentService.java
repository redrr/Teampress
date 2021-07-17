package com.teampress.database.service.index;

import com.teampress.database.model.index.UserPost;
import com.teampress.database.model.index.UserPostComment;
import com.teampress.database.repository.index.UserPostCommentRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserPostCommentService extends BaseService {

    @Autowired
    private UserPostCommentRepository repository;

    public List<UserPostComment> findAll(){
        return repository.findAll();
    }

    public List<UserPostComment> getCommentByPost(UserPost userPost){
        return repository.findByUserPostAndDeleted(userPost, false);
    }

    public UserPostComment find(Integer id) {
        return repository.findById(id);
    }
}
