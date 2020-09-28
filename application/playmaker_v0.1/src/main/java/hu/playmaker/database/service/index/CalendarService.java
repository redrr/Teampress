package hu.playmaker.database.service.index;

import hu.playmaker.database.model.index.Calendar;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CalendarService extends BaseService {

    public List<Calendar> findAll(){
        return getEntityManager().createNamedQuery("Calendar.findAll").getResultList();
    }

    public String getEventsAsJSON(Organization org, LookupCode team){
        List result = getEntityManager().createNamedQuery("Calendar.findByOrgAndTeam").setParameter("porg",org).setParameter("pteam", team).getResultList();
        String events = "";
        for (int i = 0; i<result.size(); i++) {
            Calendar c = (Calendar) result.get(i);
            events += "    {\n" +
                    "      \"title\": \""+c.getEventName()+"\",\n" +
                    "      \"start\": \""+ c.getStartDateTime() +"\",\n" +
                    "      \"end\": \""+ c.getEndDateTime() +"\"\n" +
                    "    }";
            if(i+1<result.size()){
                events += ",\n";
            }
        }
        return  events;
    }

    public String getEventsAsJSON(Organization org){
        List result = getEntityManager().createNamedQuery("Calendar.findByOrg").setParameter("porg",org).getResultList();
        String events = "";
        for (int i = 0; i<result.size(); i++) {
            Calendar c = (Calendar) result.get(i);
            events += "    {\n" +
                    "      \"title\": \""+c.getEventName()+"\",\n" +
                    "      \"start\": \""+ c.getStartDateTime() +"\",\n" +
                    "      \"end\": \""+ c.getEndDateTime() +"\"\n" +
                    "    }";
            if(i+1<result.size()){
                events += ",\n";
            }
        }
        return  events;
    }
}
