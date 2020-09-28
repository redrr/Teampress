package hu.playmaker.database.service.videoanalytics;

import hu.playmaker.database.model.videoanalytics.Video;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VideoService extends BaseService {

    public List<Video> findAll(){
        return getEntityManager().createNamedQuery("Video.findAll").getResultList();
    }

    public Video find(String name){
        return (Video) getEntityManager().createNamedQuery("Video.findByName").setParameter("pname",name).getResultList().get(0);
    }

    public Video find(Integer id){
        return (Video) getEntityManager().createNamedQuery("Video.findById").setParameter("pid",id).getResultList().get(0);
    }
}
