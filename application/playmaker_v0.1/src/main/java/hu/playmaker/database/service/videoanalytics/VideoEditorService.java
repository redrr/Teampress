package hu.playmaker.database.service.videoanalytics;

import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.videoanalytics.Video;
import hu.playmaker.database.model.videoanalytics.VideoEditor;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VideoEditorService extends BaseService {

    public List<VideoEditor> findAll(){
        return getEntityManager().createNamedQuery("VideoEditor.findAll").getResultList();
    }

    public List<VideoEditor> find(Organization organization){
        return getEntityManager().createNamedQuery("VideoEditor.findByOrg").setParameter("porg",organization).getResultList();
    }

    public List<VideoEditor> find(Video video){
        return getEntityManager().createNamedQuery("VideoEditor.findByVideo").setParameter("pvideo",video).getResultList();
    }

    public VideoEditor find(Integer id){
        return (VideoEditor) getEntityManager().createNamedQuery("VideoEditor.findById").setParameter("pid",id).getResultList().get(0);
    }
}
