package com.teampress.database.service.videoanalytics;

import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.model.videoanalytics.Video;
import com.teampress.database.repository.videoanalytics.VideoRepository;
import com.teampress.database.service.BaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class VideoService extends BaseService {

    @Autowired
    private VideoRepository repository;

    public List<Video> findAll(List<UserOrganization> userOrganizations){
        List<Video> videos = new ArrayList<>();
        for (UserOrganization userOrganization : userOrganizations) {
            videos.addAll(repository.findAllByOrganizationAndTeamAndDeleted(userOrganization.getOrganization(), userOrganization.getType(), false));
        }
        return videos;
    }

    public List<Video> findAllPublished(List<UserOrganization> userOrganizations){
        List<Video> videos = new ArrayList<>();
        for (UserOrganization userOrganization : userOrganizations) {
            videos.addAll(repository.findAllByOrganizationAndTeamAndIsPublicAndDeleted(userOrganization.getOrganization(), userOrganization.getType(), true, false));
        }
        return videos;
    }

    public Video find(Integer id){
        return repository.findById(id);
    }
}
