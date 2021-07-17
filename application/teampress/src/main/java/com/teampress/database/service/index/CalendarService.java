package com.teampress.database.service.index;

import com.teampress.database.model.index.Calendar;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.repository.index.CalendarRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalendarService extends BaseService {

    @Autowired
    private CalendarRepository repository;

    public List<Calendar> findAll(){
        return repository.findAll();
    }

    public String getEventsAsJSON(Organization org, LookupCode team){
        List result = repository.findAllByOrganizationAndTeam(org, team);
        String events = "";
        for (int i = 0; i < result.size(); i++) {
            Calendar c = (Calendar) result.get(i);
            events += "    {\n" +
                    "      \"title\": \""+c.getEventName()+"\",\n" +
                    "      \"start\": \""+ c.getFormattedStartDate() +"\",\n" +
                    "      \"end\": \""+ c.getFormattedEndDate() +"\"\n" +
                    "    }";
            if(i+1<result.size()){
                events += ",\n";
            }
        }
        return  events;
    }

    public String getEventsAsJSON(Organization org){
        List result = repository.findAllByOrganizationAndTeamIsNull(org);
        String events = "";
        for (int i = 0; i<result.size(); i++) {
            Calendar c = (Calendar) result.get(i);
            events += "    {\n" +
                    "      \"title\": \""+c.getEventName()+"\",\n" +
                    "      \"start\": \""+ c.getFormattedStartDate() +"\",\n" +
                    "      \"end\": \""+ c.getFormattedEndDate() +"\"\n" +
                    "    }";
            if(i+1<result.size()){
                events += ",\n";
            }
        }
        return  events;
    }

    public Calendar findByUUID(String uuid) {
        return repository.findByUuid(uuid);
    }
}
