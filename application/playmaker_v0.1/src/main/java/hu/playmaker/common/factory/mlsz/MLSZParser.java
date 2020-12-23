package hu.playmaker.common.factory.mlsz;

import hu.playmaker.database.model.databank.*;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

public class MLSZParser {

    private Liga liga;
    private String url;

    private PlayerData playerData;
    private List<Tabella> tabellas;
    private List<Sorsolas> lotteries;
    private List<Goals> goals;
    private List<YellowCard> yellowCards;
    private List<RedCard> redCards;

    private MLSZParser() {}

    public MLSZParser(String url) {
        this.url = url;
    }



    public PlayerData getPlayerData() {
        playerData = new PlayerData();
        parsePlayerProfile(url);
        return playerData;
    }

    public MLSZParser setLiga(Liga liga) {
        this.liga = liga;
        return this;
    }

    public List<Tabella> getTabellas() {
        tabellas = new ArrayList<>();
        parseTableData(url);
        return tabellas;
    }

    public List<Sorsolas> getLotteries() {
        lotteries = new ArrayList<>();
        parseLotteryData(url);
        return lotteries;
    }

    public List<Goals> getGoals() {
        goals = new ArrayList<>();
        parseGoalsData(url);
        return goals;
    }

    public List<YellowCard> getYellowCards() {
        yellowCards = new ArrayList<>();
        parseYellowCardsData(url);
        return yellowCards;
    }

    public List<RedCard> getRedCards() {
        redCards = new ArrayList<>();
        parseRedCardsData(url);
        return redCards;
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

    private void parseTableData(String url) {
        try {
            RestTemplate template = new RestTemplate();
            URI uri = new URI(url.trim());
            ResponseEntity<String> result = template.getForEntity(uri, String.class);
            Document doc = Jsoup.parse(result.getBody());
            Elements rows = doc.select("#tableContent > tr");
            for (Element row : rows){
                Elements columns = row.select("td");
                ArrayList<String> rowData = new ArrayList<>();
                for (Element column : columns) {
                    String s = column.text();
                    if (!s.equals(""))
                        rowData.add(s);
                }
                Tabella tabella = new Tabella();
                tabella.setLiga(liga);
                tabella.setHelyezes(Integer.parseInt(rowData.get(0)));
                tabella.setCsapat(rowData.get(1));
                tabella.setMecsekSzama(Integer.parseInt(rowData.get(2)));
                tabella.setGyozelemekSzama(Integer.parseInt(rowData.get(3)));
                tabella.setDontetlenekSzama(Integer.parseInt(rowData.get(4)));
                tabella.setVeresegekSzama(Integer.parseInt(rowData.get(5)));
                tabella.setLottGolokSzama(Integer.parseInt(rowData.get(6)));
                tabella.setKapottGolokSzama(Integer.parseInt(rowData.get(7)));
                tabella.setGolkulonbseg(Integer.parseInt(rowData.get(8)));
                tabella.setPontszam(Integer.parseInt(rowData.get(9)));
                tabella.setEllenfelekHelyezesenekAtlaga(rowData.get(10));
                if(rowData.size() > 11) {
                    String[] formaDatas = rowData.get(rowData.size()-1).split(" ");
                    int length = formaDatas.length;
                    tabella.setForma1(formaDatas[0]);
                    if (length > 1){
                        tabella.setForma2(formaDatas[1]);
                    }
                    if (length > 2){
                        tabella.setForma3(formaDatas[2]);
                    }
                    if (length > 3){
                        tabella.setForma4(formaDatas[3]);
                    }
                    if (length > 4){
                        tabella.setForma5(formaDatas[4]);
                    }
                }
                tabellas.add(tabella);
            }
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }

    private void parseLotteryData(String url) {
        try {
            RestTemplate template = new RestTemplate();
            URI uri = new URI(url.trim());
            ResponseEntity<String> result = template.getForEntity(uri, String.class);
            Document doc = Jsoup.parse(result.getBody());
            Elements rows = doc.select("#sorsolas_panel .schedule");
            for (Element row : rows) {
                Sorsolas sorsolas = new Sorsolas();
                sorsolas.setLiga(liga);
                sorsolas.setHazai(row.select(".home_team").text());
                sorsolas.setEredmeny(row.select(".result-cont").text());
                sorsolas.setVendeg(row.select(".away_team").text());
                sorsolas.setDatum(row.select(".team_sorsolas_date").text());
                sorsolas.setHely(row.select(".team_sorsolas_arena").text());
                sorsolas.setHazaiURL(row.select(".home_logo img").attr("src"));
                sorsolas.setVendegURL(row.select(".away_logo img").attr("src"));
                lotteries.add(sorsolas);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void parseGoalsData(String url) {
        try {
            RestTemplate template = new RestTemplate();
            URI uri = new URI(url.trim());
            ResponseEntity<String> result = template.getForEntity(uri, String.class);
            Document doc = Jsoup.parse(result.getBody());
            Elements rows = doc.select("#miniListGoalShooterContentHome tr");
            for (Element row : rows) {
                Goals goal = new Goals();
                goal.setLiga(liga);
                goal.setHely(Integer.parseInt(row.select("td").get(0).text()));
                goal.setName(row.select("td .db_landing-player-ref").text());
                goal.setGoal(Integer.parseInt(row.select("td .db_landing-inner").text()));
                goals.add(goal);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void parseYellowCardsData(String url) {
        try {
            RestTemplate template = new RestTemplate();
            URI uri = new URI(url.trim());
            ResponseEntity<String> result = template.getForEntity(uri, String.class);
            Document doc = Jsoup.parse(result.getBody());
            Elements rows = doc.select("#miniListYellowCardContentHome tr");
            for (Element row : rows) {
                YellowCard yellowCard = new YellowCard();
                yellowCard.setLiga(liga);
                yellowCard.setHely(Integer.parseInt(row.select("td").get(0).text()));
                yellowCard.setName(row.select("td .db_landing-player-ref").text());
                yellowCard.setCard(Integer.parseInt(row.select("td .db_landing-inner").text()));
                yellowCards.add(yellowCard);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private void parseRedCardsData(String url) {
        try {
            RestTemplate template = new RestTemplate();
            URI uri = new URI(url.trim());
            ResponseEntity<String> result = template.getForEntity(uri, String.class);
            Document doc = Jsoup.parse(result.getBody());
            Elements rows = doc.select("#miniListRedCardContentHome tr");
            for (Element row : rows) {
                RedCard redCard = new RedCard();
                redCard.setLiga(liga);
                redCard.setHely(Integer.parseInt(row.select("td").get(0).text()));
                redCard.setName(row.select("td .db_landing-player-ref").text());
                redCard.setCard(Integer.parseInt(row.select("td .db_landing-inner").text()));
                redCards.add(redCard);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
