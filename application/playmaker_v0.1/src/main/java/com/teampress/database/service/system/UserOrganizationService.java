package com.teampress.database.service.system;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class UserOrganizationService extends BaseService {

    public List<UserOrganization> findAll(){
        List<UserOrganization> result = getEntityManager().createNamedQuery("UserOrganization.findAll").getResultList();
        return Objects.nonNull(result) ? result : new ArrayList<>();
    }

    public UserOrganization find(Integer id){
        return (UserOrganization) getEntityManager().createNamedQuery("UserOrganization.findById").setParameter("pid", id).getResultList().get(0);
    }

    public boolean existsByOrgAndUser(int org, int user) {
        return getEntityManager().createNamedQuery("UserOrganization.findByOrgAndUser").setParameter("porg", org).setParameter("pu", user).getResultList().size() > 0;
    }

    public UserOrganization getOrgByUser(User user){
        return (UserOrganization) getEntityManager().createNamedQuery("UserOrganization.findByUser").setParameter("pu", user).getResultList().get(0);
    }

    public ArrayList<UserOrganization> getOrgListByUser(User user){
        return (ArrayList<UserOrganization>) getEntityManager().createNamedQuery("UserOrganization.findByUser").setParameter("pu", user).getResultList();
    }

    public ArrayList<UserOrganization> getOrgListByOrg(Organization organization){
        return (ArrayList<UserOrganization>) getEntityManager().createNamedQuery("UserOrganization.findByOrganization").setParameter("porg", organization).getResultList();
    }

    public ArrayList<UserOrganization> getUsersByOrgIfPlayer(Organization organization, LookupCode team){
        ArrayList<UserOrganization> arr = (ArrayList<UserOrganization>) getEntityManager().createNamedQuery("UserOrganization.findByOrganizationAndTeam").setParameter("porg", organization).setParameter("ptype", team).getResultList();
        ArrayList<UserOrganization> result = new ArrayList<>();
        for(UserOrganization userOrganization : arr){
            if(userOrganization.getUser().isPlayer()){
                result.add(userOrganization);
            }
        }
        return result;
    }

    public ArrayList<UserOrganization> getOrgListByTeam(Organization org, LookupCode team){
        return (ArrayList<UserOrganization>) getEntityManager().createNamedQuery("UserOrganization.findByOrgAndTeam").setParameter("pteam", team).setParameter("porg", org).getResultList();
    }

    public ArrayList<UserOrganization> findByOrgAndTeamAndUser(Organization org, LookupCode team, User user){
        return (ArrayList<UserOrganization>) getEntityManager().createNamedQuery("UserOrganization.findByOrgAndTeamAndUser").setParameter("porg", org).setParameter("pteam", team).setParameter("pu", user).getResultList();
    }
}
