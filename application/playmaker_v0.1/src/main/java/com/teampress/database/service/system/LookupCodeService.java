package com.teampress.database.service.system;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.repository.system.LookupCodeRepository;
import com.teampress.database.service.BaseService;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

@Service
public class LookupCodeService extends BaseService {

    @Autowired
    private LookupCodeRepository repository;

    public List<LookupCode> findAll(){
        return repository.findAll();
    }

    public LookupCode getByCodeAndLgroup(String code, String lgroup){
        return repository.findByLgroupAndCode(lgroup, code);
    }

    public LookupCode findLookupCodeByLgroupAndCode(String lgroup, String code){
        return getByCodeAndLgroup(code.toUpperCase(), lgroup.toUpperCase());
    }

    public LookupCode find(Integer id){
        return repository.findById(id);
    }

    public boolean exists(Integer id) {
        return repository.existsById(id);
    }

    public boolean existsByLgroupAndCode(String lgroup, String code){
        return repository.existsByLgroupAndCode(lgroup, code);
    }

    public List<LookupCode> findAllLookupByLgroup(String lgroup){
        return repository.findAllByLgroup(lgroup);
    }

    public HashMap<Integer, String> getLookupCodeForEnum(String lgroup){
        HashMap<Integer, String> result = new HashMap<>();
        for (LookupCode s : findAllLookupByLgroup(lgroup)){
            result.put(s.getId(), s.getCode());
        }
        return result;
    }
}
