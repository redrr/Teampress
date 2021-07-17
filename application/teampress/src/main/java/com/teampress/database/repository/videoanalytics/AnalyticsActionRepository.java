package com.teampress.database.repository.videoanalytics;

import com.teampress.database.model.system.Organization;
import com.teampress.database.model.videoanalytics.AnalyticsAction;
import com.teampress.database.model.videoanalytics.Video;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface AnalyticsActionRepository extends CrudRepository<AnalyticsAction, Long> {

    List<AnalyticsAction> findAll();

    boolean existsById(Integer id);

    AnalyticsAction findById(Integer id);

    List<AnalyticsAction> findAllByOrganizationAndSourceVideo(Organization organization, Video video);
}
