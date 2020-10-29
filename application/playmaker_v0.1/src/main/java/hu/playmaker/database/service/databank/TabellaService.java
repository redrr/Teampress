package hu.playmaker.database.service.databank;

import hu.playmaker.database.model.databank.Liga;
import hu.playmaker.database.model.databank.Tabella;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TabellaService extends BaseService {

    public List<Tabella> findAll() {
        return getEntityManager().createNamedQuery("Tabella.findAll").getResultList();
    }

    public List<Tabella> getTabellaByLiga(Liga liga) {
        return getEntityManager().createNamedQuery("Tabella.findByLiga").setParameter("pliga", liga).setParameter("pford", getLastFordByLiga(liga)).getResultList();
    }

    public Integer getLastFordByLiga(Liga liga){
        return (Integer) getEntityManager().createNamedQuery("Tabella.findByMaxLiga").setParameter("pliga", liga).getResultList().get(0);
    }

    public Integer getMaxPoints(Liga liga, String team){
        return (Integer) getEntityManager().createNamedQuery("Tabella.findByMaxPoint").setParameter("pliga", liga).setParameter("pteam", team).getResultList().get(0);
    }

    public List<Tabella> getLiga(String csapat){
        return (List<Tabella>) getEntityManager().createNamedQuery("Tabella.findByFord").setParameter("pcsapat", csapat).getResultList();
    }

    public List<String> getTeams(Liga liga){
        return (List<String>) getEntityManager().createNamedQuery("Tabella.findTeamsByLiga").setParameter("pliga", liga).getResultList();
    }

    public Tabella getTabellaByTeamAndLiga(Liga liga, String csapat){
        return (Tabella) getEntityManager().createNamedQuery("Tabella.findByLigaAndTeam").setParameter("pliga", liga).setParameter("pcsapat", csapat).setParameter("pford", getLastFordByLiga(liga)).getResultList().get(0);
    }

    public boolean existByTeamLigaAndFord(Liga liga, String csapat, int fordulo){
        return getTabellaByTeamLigaAndFord(liga, csapat, fordulo).size() > 0;
    }

    public Tabella getByTeamLigaAndFord(Liga liga, String csapat, int fordulo){
        return getTabellaByTeamLigaAndFord(liga, csapat, fordulo).get(0);
    }

    private List<Tabella> getTabellaByTeamLigaAndFord(Liga liga, String csapat, int fordulo){
        return getEntityManager().createNamedQuery("Tabella.findByLigaTeamAndFord").setParameter("pliga", liga).setParameter("pcsapat", csapat).setParameter("pford", fordulo).getResultList();
    }
}
