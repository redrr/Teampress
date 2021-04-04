package com.teampress.database.service.videoanalytics;

import com.teampress.database.model.system.UserOrganization;
import com.teampress.database.model.videoanalytics.Video;
import com.teampress.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class VideoService extends BaseService {

    public List<Video> findAll(List<UserOrganization> userOrganizations){
        List<Video> videos = new ArrayList<>();
        for (UserOrganization userOrganization : userOrganizations) {
            videos.addAll(getEntityManager().createNamedQuery("Video.findAll")
                    .setParameter("porg", userOrganization.getOrganization())
                    .setParameter("pteam", userOrganization.getType())
                    .getResultList());
        }
        return videos;
    }

    public List<Video> findAllPublished(List<UserOrganization> userOrganizations){
        List<Video> videos = new ArrayList<>();
        for (UserOrganization userOrganization : userOrganizations) {
            videos.addAll(getEntityManager().createNamedQuery("Video.findAllPublished")
                    .setParameter("porg", userOrganization.getOrganization())
                    .setParameter("pteam", userOrganization.getType())
                    .getResultList());
        }
        return videos;
    }

    public Video find(Integer id){
        List videos = getEntityManager().createNamedQuery("Video.findById").setParameter("pid",id).getResultList();
        return (videos.size() == 1) ? (Video) videos.get(0) : null;
    }
}
