package com.teampress.database.repository.index;

import com.teampress.database.model.index.UserPost;
import com.teampress.database.model.index.UserPostComment;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserPostCommentRepository extends CrudRepository<UserPostComment, Long> {

    List<UserPostComment> findAll();

    UserPostComment findById(Integer id);

    List<UserPostComment> findByUserPostAndDeleted(UserPost userPost, boolean deleted);
}
