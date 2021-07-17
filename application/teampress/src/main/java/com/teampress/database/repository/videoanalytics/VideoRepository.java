package com.teampress.database.repository.videoanalytics;

import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.videoanalytics.Video;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface VideoRepository extends CrudRepository<Video, Long> {

    List<Video> findAll();

    Video findById(Integer id);

    List<Video> findAllByOrganizationAndTeamAndDeleted(Organization organization, LookupCode team, boolean deleted);

    List<Video> findAllByOrganizationAndTeamAndIsPublicAndDeleted(Organization organization, LookupCode team, boolean idPublic, boolean deleted);
}
