package hu.playmaker.common.factory.mlsz;

import hu.playmaker.database.model.databank.PlayerData;
import hu.playmaker.database.model.system.User;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.net.URI;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class MLSZParser {

    private PlayerData playerData;

    private MLSZParser() {}

    public MLSZParser(String url, MLSZ type) {
        switch (type) {
            case PLAYER_PROFILE:
                playerData = new PlayerData();
                parsePlayerProfile(url);
                break;
            case TABLE: break;
            case LOTTERY: break;
            case GOALS: break;
            case YELLOW_CARDS: break;
            case RED_CARDS: break;
        }
    }

    public PlayerData getProfileData() {
        return playerData;
    }

    private void parsePlayerProfile(String url) {
        try {
            RestTemplate template = new RestTemplate();
            URI uri = new URI(url.trim());
            ResponseEntity<String> result = template.getForEntity(uri, String.class);
            Document doc = Jsoup.parse(result.getBody());
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
                System.out.println("Hibás url: "+url);
            }
            if(basicData.get(1).text().trim().equals("")) {
                System.out.println("SzulDate hiányzik: "+url);
            }
            if(basicData.get(2).text().trim().equals("")) {
                System.out.println("Kor hiányzik: "+url);
            }
            if(goals.size() != 1 || goals.get(0).text().trim().equals("")) {
                System.out.println("Bad goals "+url);
            }
            if(selfGoals.size() != 1 || selfGoals.get(0).text().trim().equals("")) {
                System.out.println("Bad selfGoals "+url);
            }
            if(yellow.size() != 1 || yellow.get(0).text().trim().equals("")) {
                System.out.println("Bad yellow "+url);
            }
            if(red.size() != 1 || red.get(0).text().trim().equals("")) {
                System.out.println("Bad red "+url);
            }
            if(starter.size() != 1 || starter.get(0).text().trim().equals("")) {
                System.out.println("Bad starter "+url);
            }
            if(switchP.size() != 1 || switchP.get(0).text().trim().equals("")) {
                System.out.println("Bad switchP "+url);
            }
            if(banch.size() != 1 || banch.get(0).text().trim().equals("")) {
                System.out.println("Bad banch "+url);
            }
            //Process
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
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(url);
        }
    }
}
