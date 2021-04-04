package com.teampress.database.service.videoanalytics;

import com.teampress.database.model.system.Organization;
import com.teampress.database.model.videoanalytics.AnalyticsAction;
import com.teampress.database.model.videoanalytics.Video;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnalyticsActionService extends BaseService {

    public AnalyticsAction find(Integer id){
        List list = getEntityManager().createNamedQuery("AnalyticsAction.findById").setParameter("pid", id).getResultList();
        return list.size() > 0 ? (AnalyticsAction) list.get(0) : null;
    }

    public boolean exist(Integer id){
        return getEntityManager().createNamedQuery("AnalyticsAction.findById").setParameter("pid", id).getResultList().size() > 0;
    }

    public List<AnalyticsAction> findBySourceVideo(Video video, Organization organization) {
        try {
            return getEntityManager()
                    .createNamedQuery("AnalyticsAction.findByVideo")
                    .setParameter("pvideo", video)
                    .setParameter("porg", organization)
                    .getResultList();
        } catch (Exception e) {
            return null;
        }
    }
}
