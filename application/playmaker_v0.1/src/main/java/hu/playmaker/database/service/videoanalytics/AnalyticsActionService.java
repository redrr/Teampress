package hu.playmaker.database.service.videoanalytics;

import hu.playmaker.database.model.videoanalytics.AnalyticsAction;
import hu.playmaker.database.model.videoanalytics.Video;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnalyticsActionService extends BaseService {

    public List<AnalyticsAction> findAll(){
        return null;
    }

    public AnalyticsAction find(Integer id){
        List list = getEntityManager().createNamedQuery("AnalyticsAction.findById").setParameter("pid", id).getResultList();
        return list.size() > 0 ? (AnalyticsAction) list.get(0) : null;
    }

    public boolean exist(Integer id){
        return getEntityManager().createNamedQuery("AnalyticsAction.findById").setParameter("pid", id).getResultList().size() > 0;
    }

    public List<AnalyticsAction> findBySourceVideo(Video video) {
        try {
            return getEntityManager().createNamedQuery("AnalyticsAction.findByVideo").setParameter("pvideo", video).getResultList();
        } catch (Exception e) {
            return null;
        }
    }
}
