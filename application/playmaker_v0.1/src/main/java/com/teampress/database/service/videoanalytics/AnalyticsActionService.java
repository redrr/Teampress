package com.teampress.database.service.videoanalytics;

import com.teampress.database.model.system.Organization;
import com.teampress.database.model.videoanalytics.AnalyticsAction;
import com.teampress.database.model.videoanalytics.Video;
import com.teampress.database.repository.videoanalytics.AnalyticsActionRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnalyticsActionService extends BaseService {

    @Autowired
    private AnalyticsActionRepository repository;

    public AnalyticsAction find(Integer id){
        return repository.findById(id);
    }

    public boolean exist(Integer id){
        return repository.existsById(id);
    }

    public List<AnalyticsAction> findBySourceVideo(Video video, Organization organization) {
        return repository.findAllByOrganizationAndSourceVideo(organization, video);
    }
}
