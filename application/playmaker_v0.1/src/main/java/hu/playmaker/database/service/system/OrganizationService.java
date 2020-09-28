package hu.playmaker.database.service.system;

import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class OrganizationService extends BaseService {

    public Organization find(Integer id){
        return (Organization) getEntityManager().createNamedQuery("Organization.findById").setParameter("pid", id).getResultList().get(0);
    }

    public List<Organization> findAll(){
        return getEntityManager().createNamedQuery("Organization.findAll").getResultList();
    }

    public Organization findByURL(String url){
        return (Organization) getEntityManager().createNamedQuery("Organization.findByURL").setParameter("purl", url).getResultList().get(0);
    }

    public Organization findOrganizationByName(String name){
        List result = getEntityManager().createNamedQuery("Organization.findByName").setParameter("pname", name).getResultList();
        return result.isEmpty()?null:(Organization) result.get(0);
    }

    public boolean existsByName(String name){
        return Objects.nonNull(findOrganizationByName(name));
    }
}
