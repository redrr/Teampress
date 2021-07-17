package com.teampress.database.service.system;

import com.teampress.database.model.system.OrgCountry;
import com.teampress.database.model.system.Organization;
import com.teampress.database.repository.system.OrgCountryRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrgCountryService extends BaseService {

    @Autowired
    private OrgCountryRepository repository;

    public OrgCountry find(Integer id){
        return repository.findById(id);
    }

    public List<OrgCountry> findAll(){
        return repository.findAll();
    }

    public OrgCountry find(Organization organization) {
        return repository.findByOrganization(organization);
    }
}
