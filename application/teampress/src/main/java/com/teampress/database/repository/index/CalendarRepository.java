package com.teampress.database.repository.index;

import com.teampress.database.model.index.Calendar;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface CalendarRepository extends CrudRepository<Calendar, Long> {

    List<Calendar> findAll();

    Calendar findByUuid(String uuid);

    List<Calendar> findAllByOrganizationAndTeam(Organization organization, LookupCode team);

    List<Calendar> findAllByOrganizationAndTeamIsNull(Organization organization);
}
