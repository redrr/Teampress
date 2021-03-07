package hu.playmaker.database.service.index;

import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.system.UserOrganization;
import hu.playmaker.database.model.index.UserPost;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserPostService extends BaseService {

    public List<UserPost> findAll() {
        return getEntityManager().createNamedQuery("UserPost.findAll").getResultList();
    }

    public boolean existsByOrgAndUser(int org, int user) {
        return getEntityManager().createNamedQuery("UserPost.findByOrgAndUser")
                .setParameter("porg", org)
                .setParameter("pu", user)
                .getResultList().size() > 0;
    }

    public UserOrganization getOrgByUser(User user){
        return (UserOrganization) getEntityManager().createNamedQuery("UserPost.findByUser")
                .setParameter("pu", user)
                .getResultList().get(0);
    }

    public List<UserPost> findAllByOrg(Organization organization) {
        return getEntityManager().createNamedQuery("UserPost.findByOrgOrdered")
                .setParameter("porg", organization)
                .getResultList();
    }

    public List<UserPost> findAllByOrgWithLimit(Organization organization, Integer offset) {
        return getEntityManager().createNamedQuery("UserPost.findByOrgOrdered")
                .setParameter("porg", organization)
                .setMaxResults(5)
                .setFirstResult(offset)
                .getResultList();
    }

    public UserPost find(Integer id) {
        return (UserPost)getEntityManager().createNamedQuery("UserPost.findById")
                .setParameter("pid", id)
                .getSingleResult();
    }
}
