package com.teampress.database.repository.financial;

import com.teampress.database.model.financial.IncomeGroup;
import com.teampress.database.model.system.Organization;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface IncomeGroupRepository extends CrudRepository<IncomeGroup, Long> {

    List<IncomeGroup> findAll();

    IncomeGroup findById(Integer id);

    boolean existsById(Integer id);

    List<IncomeGroup> findAllByOrganizationAndDeleted(Organization organization, boolean deleted);

    List<IncomeGroup> findAllByOrganizationAndDeletedAndCreatedBy(Organization organization, boolean deleted, String by);
}
