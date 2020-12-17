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
        return null;
    }

    public boolean exist(Integer id){
        return false;
    }

    public List<AnalyticsAction> findBySourceVideo(Video video){
        return null;
    }
}
