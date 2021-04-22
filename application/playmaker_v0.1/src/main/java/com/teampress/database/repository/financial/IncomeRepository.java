package com.teampress.database.repository.financial;

import com.teampress.database.model.financial.Income;
import com.teampress.database.model.system.Organization;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;

public interface IncomeRepository extends CrudRepository<Income, Long> {

    List<Income> findAll();

    Income findById(Integer id);

    boolean existsById(Integer id);

    List<Income> findAllByOrganization(Organization organization);

    List<Income> findAllByOrganizationAndAcceptAndDeleted(Organization organization, boolean accepted, boolean deleted);

    List<Income> findAllByOrganizationAndCreationDateIsBetweenAndAcceptAndDeleted(Organization organization, Date from, Date to, boolean accept, boolean deleted);

    List<Income> findAllByOrganizationAndDeletedAndAcceptIsNull(Organization organization, boolean deleted);

    @Query("SELECT sum(p.prize) FROM Income p WHERE p.organization = :organization AND p.income = :isIncome AND p.accept = true AND p.deleted=false AND p.creationDate BETWEEN :dFrom AND :dTo")
    Integer sumAmountByOrganizationAndIncomeBetweenDates(Organization organization, boolean isIncome, Date dFrom, Date dTo);
}
