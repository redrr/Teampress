package hu.playmaker.database.service.databank;

import hu.playmaker.common.template.PlayerHeaderTmp;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.databank.PlayerData;
import hu.playmaker.database.model.databank.Tabella;
import hu.playmaker.database.service.BaseService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlayerDataService extends BaseService {

    public List<PlayerData> findAll(){
        return getEntityManager().createNamedQuery("PlayerData.findAll").getResultList();
    }

    public boolean existsByCodeAndUser(User user) {
        return getPlayerDataListByCode(user).size() > 0;
    }

    public PlayerData getPlayerDataByCode(User user){
        if(existsByCodeAndUser(user)){
            return getPlayerDataListByCode(user).get(0);
        }
        return null;
    }

    private List<PlayerData> getPlayerDataListByCode(User user){
        return getEntityManager().createNamedQuery("PlayerData.findByUser").setParameter("pu", user).getResultList();
    }

    //region [Player Header]
    public PlayerHeaderTmp getPlayerHeader(User user, String[] stat){
        PlayerHeaderTmp tmp = new PlayerHeaderTmp();
        tmp.setName(user.getName().split(" ")[0]+" "+ user.getName().split(" ")[1].charAt(0)+".");
        tmp.setProfImg(user.getProfilImg());
        tmp.setCssClass(setClassFromStat(stat));
        tmp.setData(stat);
        return tmp;
    }

    private String[] setClassFromStat(String[] stat) {
        String[] re = new String[5];
        for(int i = 0; i < stat.length; i++){
            re[i] = (stat[i].equals("")) ? "" : cssStyle(stat[i]);
        }
        return re;
    }

    public PlayerHeaderTmp getTeamHeader(Organization org, Tabella tabella){
        PlayerHeaderTmp tmp = new PlayerHeaderTmp();
        tmp.setProfImg(org.getUrl());
        tmp.setName(tabella.getHelyezes() + ". helyezés");
        tmp.setCssClass(new String[]{cssStyle(tabella.getForma5()), cssStyle(tabella.getForma4()), cssStyle(tabella.getForma3()), cssStyle(tabella.getForma2()), cssStyle(tabella.getForma1())});
        tmp.setData(new String[]{tabella.getForma5(), tabella.getForma4(), tabella.getForma3(), tabella.getForma2(), tabella.getForma1()});
        return tmp;
    }

    private String cssStyle(String lvl) {
        switch (lvl){
            case "GY" : return "primary";
            case "+" : return "primary";
            case "D" : return "secondary";
            case "V" : return "danger";
            case "-" : return "danger";
            default: return "info";
        }
    }
    //endregion

    //region [Max Values]
    public int maxkor(){
        return (int)getEntityManager().createNamedQuery("PlayerData.maxkor").getSingleResult();
    }
    public int maxmeccsek(){
        return (int)getEntityManager().createNamedQuery("PlayerData.maxmeccsek").getSingleResult();
    }
    public int maxgolok(){
        return (int)getEntityManager().createNamedQuery("PlayerData.maxgolok").getSingleResult();
    }
    public int maxonGolok(){
        return (int)getEntityManager().createNamedQuery("PlayerData.maxonGolok").getSingleResult();
    }
    public int maxsargaLap(){
        return (int)getEntityManager().createNamedQuery("PlayerData.maxsargaLap").getSingleResult();
    }
    public int maxpirosLap(){
        return (int)getEntityManager().createNamedQuery("PlayerData.maxpirosLap").getSingleResult();
    }
    public int maxkezdo(){
        return (int)getEntityManager().createNamedQuery("PlayerData.maxkezdo").getSingleResult();
    }
    public int maxcsere(){
        return (int)getEntityManager().createNamedQuery("PlayerData.maxcsere").getSingleResult();
    }
    public int maxkispad(){
        return (int)getEntityManager().createNamedQuery("PlayerData.maxkispad").getSingleResult();
    }
    //endregion
}
