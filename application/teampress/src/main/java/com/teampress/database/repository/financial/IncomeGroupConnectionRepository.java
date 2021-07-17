package com.teampress.database.repository.financial;

import com.teampress.database.model.financial.Income;
import com.teampress.database.model.financial.IncomeGroup;
import com.teampress.database.model.financial.IncomeGroupConnection;
import com.teampress.database.model.system.Organization;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;

public interface IncomeGroupConnectionRepository extends CrudRepository<IncomeGroupConnection, Long> {

    List<IncomeGroupConnection> findAll();

    IncomeGroupConnection findById(Integer id);

    boolean existsById(Integer id);

    boolean existsByGroup(IncomeGroup group);

    boolean existsByIncome(Income income);

    IncomeGroupConnection findByIncome(Income income);

    @Query("SELECT conn FROM IncomeGroupConnection conn JOIN Income i ON conn.income = i WHERE conn.organization = :organization AND i.creationDate BETWEEN :fDate AND :tDate")
    List<IncomeGroupConnection> findAllByOrganizationAndBetweenDates(Organization organization, Date fDate, Date tDate);

    List<IncomeGroupConnection> findAllByCreatedBy(String by);
}
