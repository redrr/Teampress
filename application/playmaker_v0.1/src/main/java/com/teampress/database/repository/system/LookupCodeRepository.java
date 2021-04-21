package com.teampress.database.repository.system;

import com.teampress.database.model.system.LookupCode;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface LookupCodeRepository extends CrudRepository<LookupCode, Long> {

    List<LookupCode> findAll();

    LookupCode findById(Integer id);

    boolean existsById(Integer id);

    List<LookupCode> findAllByLgroup(String lgroup);

    LookupCode findByLgroupAndCode(String lgroup, String code);

    boolean existsByLgroupAndCode(String lgroup, String code);
}
