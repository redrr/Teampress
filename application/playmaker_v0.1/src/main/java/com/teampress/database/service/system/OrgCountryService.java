package com.teampress.database.service.system;

import com.teampress.database.model.system.OrgCountry;
import com.teampress.database.model.system.Organization;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrgCountryService extends BaseService {

    public OrgCountry find(Integer id){
        return (OrgCountry) getEntityManager().createNamedQuery("OrgCountry.findById").setParameter("pid", id).getResultList().get(0);
    }

    public List<OrgCountry> findAll(){
        return getEntityManager().createNamedQuery("OrgCountry.findAll").getResultList();
    }

    public List<OrgCountry> find(Organization organization) {
        return getEntityManager().createNamedQuery("OrgCountry.findByOrganization").setParameter("porg", organization).getResultList();
    }
}
