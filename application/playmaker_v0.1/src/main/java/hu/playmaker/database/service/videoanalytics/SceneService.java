package hu.playmaker.database.service.videoanalytics;

import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.videoanalytics.Folder;
import hu.playmaker.database.model.videoanalytics.Scene;
import hu.playmaker.database.model.videoanalytics.VideoEditor;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SceneService extends BaseService {

    public List<Scene> findAll(){
        return getEntityManager().createNamedQuery("Scene.findAll").getResultList();
    }

    public List<Scene> find(Organization organization){
        return getEntityManager().createNamedQuery("Scene.findByOrg").setParameter("porg",organization).getResultList();
    }

    public List<Scene> find(Folder folder){
        return getEntityManager().createNamedQuery("Scene.findByFolder").setParameter("pfolder",folder).getResultList();
    }

    public Scene find(Integer id){
        return (Scene) getEntityManager().createNamedQuery("Scene.findById").setParameter("pid",id).getResultList().get(0);
    }
}
