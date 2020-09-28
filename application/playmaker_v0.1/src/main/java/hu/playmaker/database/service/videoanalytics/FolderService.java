package hu.playmaker.database.service.videoanalytics;

import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.videoanalytics.Folder;
import hu.playmaker.database.model.videoanalytics.Video;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FolderService extends BaseService {

    public List<Folder> findAll(){
        return getEntityManager().createNamedQuery("Folder.findAll").getResultList();
    }

    public Folder find(String name){
        return (Folder) getEntityManager().createNamedQuery("Folder.findByName").setParameter("pname",name).getResultList().get(0);
    }

    public Folder find(Integer id){
        return (Folder) getEntityManager().createNamedQuery("Folder.findById").setParameter("pid",id).getResultList().get(0);
    }

    public List<Folder> findByOrg(Organization organization){
        return getEntityManager().createNamedQuery("Folder.findByOrg").setParameter("porg", organization).getResultList();
    }
}
