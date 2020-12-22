package hu.playmaker.common.factory.mlsz;

import hu.playmaker.database.model.databank.PlayerData;
import hu.playmaker.database.model.system.User;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class MLSZParser {

    private MLSZParser() {}

    public MLSZParser(String document, MLSZ type) {
        switch (type) {
            case PLAYER_PROFILE: break;
            case TABLE: break;
            case LOTTERY: break;
            case GOALS: break;
            case YELLOW_CARDS: break;
            case RED_CARDS: break;
        }
    }

    private ArrayList<PlayerData> getAllPlayerInfo(List<User> users ) {
        System.out.println("Start: "+Instant.now());
        ArrayList<PlayerData> all = new ArrayList<>();
        for (User player : users) {
            PlayerData playerData = new PlayerData();

          /*  String url = (player.getUrl().contains("=")) ?
                    "https://adatbank.mlsz.hu/player/"+player.getUrl().split("=")[1].trim()+".html":
                    player.getUrl();
*/
            String url = "http://ada1bank.mlsz.hu/player?itemId=373780";
            try {
                Document doc = Jsoup.connect(url).ignoreHttpErrors(true).userAgent("Mozilla/5.0").get();
                Elements basicData = doc.select(".detail .datas");
                Elements goals = doc.select("#playerStatGoalsCnt");
                Elements selfGoals = doc.select("#playerStatOwnGoalsCnt");
                Elements yellow = doc.select("#playerStatYCCnt");
                Elements red = doc.select("#playerStatRCCnt");
                Elements starter = doc.select("#playerStatStartCnt");
                Elements switchP = doc.select("#playerStatPlInCnt");
                Elements banch = doc.select("#playerStatPlOutCnt");
                //Validation
                if(basicData.size() < 4) {
                    System.out.println("Hibás url: "+player.getUsername());
                    return null;
                }
                if(basicData.get(1).text().trim().equals("")) {
                    System.out.println("SzulDate hiányzik: "+player.getUsername());
                    return null;
                }
                if(basicData.get(2).text().trim().equals("")) {
                    System.out.println("Kor hiányzik: "+player.getUsername());
                    return null;
                }
                if(goals.size() != 1 || goals.get(0).text().trim().equals("")) {
                    System.out.println("Bad goals "+player.getUsername());
                    return null;
                }
                if(selfGoals.size() != 1 || selfGoals.get(0).text().trim().equals("")) {
                    System.out.println("Bad selfGoals "+player.getUsername());
                    return null;
                }
                if(yellow.size() != 1 || yellow.get(0).text().trim().equals("")) {
                    System.out.println("Bad yellow "+player.getUsername());
                    return null;
                }
                if(red.size() != 1 || red.get(0).text().trim().equals("")) {
                    System.out.println("Bad red "+player.getUsername());
                    return null;
                }
                if(starter.size() != 1 || starter.get(0).text().trim().equals("")) {
                    System.out.println("Bad starter "+player.getUsername());
                    return null;
                }
                if(switchP.size() != 1 || switchP.get(0).text().trim().equals("")) {
                    System.out.println("Bad switchP "+player.getUsername());
                    return null;
                }
                if(banch.size() != 1 || banch.get(0).text().trim().equals("")) {
                    System.out.println("Bad banch "+player.getUsername());
                    return null;
                }
                //Process
                playerData.setUser(player);
                playerData.setSzulDate(basicData.get(1).text());
                playerData.setKor(Integer.parseInt(basicData.get(2).text()));
                playerData.setGolok(Integer.parseInt(goals.get(0).text()));
                playerData.setOnGolok(Integer.parseInt(selfGoals.get(0).text()));
                playerData.setSargaLap(Integer.parseInt(yellow.get(0).text()));
                playerData.setPirosLap(Integer.parseInt(red.get(0).text()));
                playerData.setKezdo(Integer.parseInt(starter.get(0).text()));
                playerData.setCsere(Integer.parseInt(switchP.get(0).text()));
                playerData.setKispad(Integer.parseInt(banch.get(0).text()));
                playerData.setMeccsek(playerData.getKezdo()+playerData.getCsere()+playerData.getKispad());
                all.add(playerData);
            } catch (IOException e) {
                e.printStackTrace();
                System.out.println(player.getName() + ","+url);
                return null;
            }
        }
        System.out.println("End: "+Instant.now());
        return all;
    }
}
