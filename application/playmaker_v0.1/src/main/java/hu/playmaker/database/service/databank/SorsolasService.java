package hu.playmaker.database.service.databank;

import hu.playmaker.common.template.SorsolasHeaderTmp;
import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.model.databank.Sorsolas;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class SorsolasService extends BaseService {

    public List<Sorsolas> findAll(){
        return getEntityManager().createNamedQuery("Sorsolas.findAll").getResultList();
    }

    public Sorsolas findById(int id){
        return (Sorsolas) getEntityManager().createNamedQuery("Sorsolas.findById").setParameter("pid", id).getResultList().get(0);
    }

    public List<Sorsolas> getSorsolasByLiga(Liga liga) {
        return getEntityManager().createNamedQuery("Sorsolas.findByName").setParameter("pliga", liga).getResultList();
    }

    public Sorsolas getLiga(String csapat){
        return (Sorsolas) getEntityManager().createNamedQuery("Sorsolas.findByFord").setParameter("pcsapat", csapat).getResultList().get(0);
    }

    public List<Sorsolas> getLigaAndTeam(Liga liga, String csapat){
        return (List<Sorsolas>) getEntityManager().createNamedQuery("Sorsolas.findByTeamAndLiga").setParameter("pliga", liga).setParameter("pcsapat", csapat).getResultList();
    }


    public List<Sorsolas> getCustomLigaAndTeam(String liga, String csapat){
        return (List<Sorsolas>) getEntityManager().createNamedQuery("Sorsolas.findCustomByTeamAndLiga").setParameter("pliga", liga).setParameter("pcsapat", csapat).getResultList();
    }

    public List<Sorsolas> getCustomCreatedBy(String createdBy){
        return (List<Sorsolas>) getEntityManager().createNamedQuery("Sorsolas.getCustomCreatedBy").setParameter("pby", createdBy).getResultList();
    }

    public List<Sorsolas> getUnique(Liga liga, String vendeg, String hazai, Date datum){
        return getEntityManager().createNamedQuery("Sorsolas.findByLigaHazaiVendegDate").setParameter("pliga", liga).setParameter("pv", vendeg).setParameter("ph", hazai).setParameter("pdatum", datum).getResultList();
    }

    public SorsolasHeaderTmp getSorsolas(Liga liga, String csapat){
        List<Sorsolas> s = getLigaAndTeam(liga, csapat);
        Sorsolas k = null;
        for(Sorsolas q : s){
            if((k == null) && (q.getEredmeny().contains(":"))){
                k=q;
            }
        }
        SorsolasHeaderTmp tmp = new SorsolasHeaderTmp();
        tmp.setHazaiUrl(k.getHazaiURL());
        tmp.setEredmeny(k.getDateAs(false));
        tmp.setVendegUrl(k.getVendegURL());
        return tmp;
    }
}
