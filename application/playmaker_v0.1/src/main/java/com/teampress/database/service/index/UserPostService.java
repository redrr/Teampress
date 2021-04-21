package com.teampress.database.service.index;

import com.teampress.database.model.index.UserPost;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.repository.index.UserPostRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserPostService extends BaseService {

    @Autowired
    UserPostRepository repository;

    public List<UserPost> findAll() {
        return repository.findAll();
    }

    public List<UserPost> findAllByOrgWithLimit(Organization organization, Integer offset) {
        return getEntityManager().createNamedQuery("UserPost.findByOrgOrdered")
                .setParameter("porg", organization)
                .setMaxResults(5)
                .setFirstResult(offset)
                .getResultList();
    }

    public UserPost find(Integer id) {
        return repository.findById(id);
    }
}
