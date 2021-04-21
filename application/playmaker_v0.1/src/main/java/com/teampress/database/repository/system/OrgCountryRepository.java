package com.teampress.database.repository.system;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.OrgCountry;
import com.teampress.database.model.system.Organization;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface OrgCountryRepository extends CrudRepository<OrgCountry, Long> {

    List<OrgCountry> findAll();

    OrgCountry findById(Integer id);

    OrgCountry findByOrganization(Organization organization);
}
