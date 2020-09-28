package hu.playmaker.database.service.index;

import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.model.index.UserPost;
import hu.playmaker.database.model.index.UserPostComment;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserPostCommentService extends BaseService {

    public boolean existsByOrgAndUser(int org, int user) {
        return getEntityManager().createNamedQuery("UserPostComment.findByOrgAndUser").setParameter("porg", org).setParameter("pu", user).getResultList().size() > 0;
    }

    public UserOrganization getOrgByUser(User user){
        return (UserOrganization) getEntityManager().createNamedQuery("UserPostComment.findByUser").setParameter("pu", user).getResultList().get(0);
    }

    public List<UserPostComment> findAll(){
        return getEntityManager().createNamedQuery("UserPostComment.findAll").getResultList();
    }

    public List<UserPostComment> getCommentByPost(UserPost userPost){
        return getEntityManager().createNamedQuery("UserPostComment.findByOrg").setParameter("porg", userPost).getResultList();
    }
}
