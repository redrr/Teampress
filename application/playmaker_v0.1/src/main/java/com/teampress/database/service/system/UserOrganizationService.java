package com.teampress.database.service.system;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.repository.system.UserOrganizationRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class UserOrganizationService extends BaseService {

    @Autowired
    private UserOrganizationRepository repository;

    public List<UserOrganization> findAll(){
        return repository.findAll();
    }

    public UserOrganization find(Integer id){
        return repository.findById(id);
    }

    public UserOrganization getOrgByUser(User user){
        return repository.getFirstByUser(user);
    }

    public ArrayList<UserOrganization> getOrgListByUser(User user){
        return new ArrayList<>(repository.findAllByUser(user));
    }

    public ArrayList<UserOrganization> getOrgListByOrg(Organization organization){
        return new ArrayList<>(repository.findAllByOrganization(organization));
    }

    public ArrayList<UserOrganization> getUsersByOrgIfPlayer(Organization organization, LookupCode team){
        return new ArrayList<>(repository.findAllPlayerByOrganizationAndTeam(organization, team));
    }

    public ArrayList<UserOrganization> getOrgListByTeam(Organization org, LookupCode team){
        return new ArrayList<>(repository.findAllByOrganizationAndType(org, team));
    }

    public ArrayList<UserOrganization> findByOrgAndTeamAndUser(Organization org, LookupCode team, User user){
        return new ArrayList<>(repository.findAllByOrganizationAndTypeAndUser(org, team, user));
    }

    public List<User> findUsersByOrgAndTeams(Organization organization, List<LookupCode> teams) {
        return repository.findAllUserByOrganizationAndTeamIn(organization, teams);
    }
}
