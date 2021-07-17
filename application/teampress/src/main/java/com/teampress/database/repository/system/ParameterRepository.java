package com.teampress.database.repository.system;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Parameter;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface ParameterRepository extends CrudRepository<Parameter, Long> {

    List<Parameter> findAll();

    Parameter findById(Integer id);

    boolean existsByGroupAndCode(String group, String code);

    Parameter findByGroupAndCode(String group, String code);

    List<Parameter> findAllByGroup(String group);
}
