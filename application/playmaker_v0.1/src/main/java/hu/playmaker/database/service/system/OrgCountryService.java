package hu.playmaker.database.service.system;

import hu.playmaker.database.model.system.OrgCountry;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

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
