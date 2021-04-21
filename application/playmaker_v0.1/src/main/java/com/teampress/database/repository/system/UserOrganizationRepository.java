package com.teampress.database.repository.system;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.model.system.UserOrganization;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface UserOrganizationRepository extends CrudRepository<UserOrganization, Long> {

    List<UserOrganization> findAll();

    UserOrganization findById(Integer id);

    boolean existsById(Integer id);

    UserOrganization getFirstByUser(User user);

    List<UserOrganization> findAllByUser(User user);

    List<UserOrganization> findAllByOrganization(Organization organization);

    @Query("SELECT uOrg FROM UserOrganization uOrg JOIN User u ON uOrg.user = u WHERE uOrg.organization = :organization AND uOrg.type = :team AND u.player = true ")
    List<UserOrganization> findAllPlayerByOrganizationAndTeam(Organization organization, LookupCode team);

    List<UserOrganization> findAllByOrganizationAndType(Organization organization, LookupCode team);

    List<UserOrganization> findAllByOrganizationAndTypeAndUser(Organization organization, LookupCode team, User user);

    @Query("SELECT distinct u.user FROM UserOrganization u WHERE u.organization = :organization AND u.type IN :teams")
    List<User> findAllUserByOrganizationAndTeamIn(Organization organization, List<LookupCode> teams);
}
