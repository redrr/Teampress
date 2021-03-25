package hu.playmaker.database.service.videoanalytics;

import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.videoanalytics.Video;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VideoService extends BaseService {

    public List<Video> findAll(Organization organization){
        return getEntityManager().createNamedQuery("Video.findAll").setParameter("porg", organization).getResultList();
    }

    public List<Video> findAllPublished(Organization organization){
        return getEntityManager().createNamedQuery("Video.findAllPublished").setParameter("porg", organization).getResultList();
    }

    public Video find(Integer id){
        List videos = getEntityManager().createNamedQuery("Video.findById").setParameter("pid",id).getResultList();
        return (videos.size() == 1) ? (Video) videos.get(0) : null;
    }
}
