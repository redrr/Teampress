package com.teampress.database.repository.system;

import com.teampress.database.model.system.Organization;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface OrganizationRepository extends CrudRepository<Organization, Long> {

    List<Organization> findAll();

    Organization findById(Integer id);

    boolean existsByName(String name);

    Organization findByName(String name);
}
