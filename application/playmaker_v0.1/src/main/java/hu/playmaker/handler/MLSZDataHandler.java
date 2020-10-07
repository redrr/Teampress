package hu.playmaker.handler;

import hu.playmaker.database.model.databank.*;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.system.OrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.config.SeleniumConfig;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.*;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;

public class MLSZDataHandler {

    private WebDriver driver;
    private WebDriverWait wait;

    public MLSZDataHandler() {

    }

    public void startProcessor(){
        driver = new SeleniumConfig().getWebDriver();
        wait = new WebDriverWait(driver, 30);
    }

    public void quitProcessor(){
        driver.quit();
    }

    private Integer selectFederationAndLeague(String federation, String league) throws InterruptedException {
        driver.get("https://ada1bank.mlsz.hu/league");
        waitForVisibleWebElement(driver.findElement(By.id("federations")));
        Thread.sleep(1000);
        Select szervezoSelect = new Select(driver.findElement(By.id("federations")));
        szervezoSelect.selectByVisibleText(federation);
        waitForVisibleWebElement(driver.findElement(By.id("leagues")));
        Thread.sleep(1000);
        Select ligaSelect = new Select(driver.findElement(By.id("leagues")));
        ligaSelect.selectByVisibleText(league);
        waitForVisibleWebElement(driver.findElement(By.id("turns")));
        return Integer.parseInt(new Select(driver.findElement(By.id("turns"))).getFirstSelectedOption().getText());
    }

    private Integer selectFederationAndLeague(String federation, String league, Integer turn) throws InterruptedException {
        driver.get("https://ada1bank.mlsz.hu/league");
        waitForVisibleWebElement(driver.findElement(By.id("federations")));
        Thread.sleep(1000);
        Select szervezoSelect = new Select(driver.findElement(By.id("federations")));
        szervezoSelect.selectByVisibleText(federation);
        waitForVisibleWebElement(driver.findElement(By.id("leagues")));
        Thread.sleep(1000);
        Select ligaSelect = new Select(driver.findElement(By.id("leagues")));
        ligaSelect.selectByVisibleText(league);
        //waitForVisibleWebElement(driver.findElement(By.id("turns")));
        Thread.sleep(1000);
        Select turnSelect = new Select(driver.findElement(By.id("turns")));
        turnSelect.selectByVisibleText(turn.toString());
        return turn;
    }

    private void selectOrganization(String orgName){
        List<WebElement> elements = driver.findElements(By.cssSelector("#league_teams > div > div > a"));
        for(int i = 0; i < elements.size(); i++){
            waitForVisibleWebElement(driver.findElement(By.cssSelector("#league_teams > div > div > a:nth-child("+(i+1)+")")));
            WebElement e = driver.findElement(By.cssSelector("#league_teams > div > div > a:nth-child("+(i+1)+")"));
            waitForVisibleWebElement(e.findElement(By.tagName("img")));
            if(e.findElement(By.tagName("img")).getAttribute("alt").equals(orgName)){
                e.click();
            }
        }
    }

    public ArrayList<PlayerData> processPlayerData(List<User> users){
        ArrayList<PlayerData> datas = new ArrayList<>();
        for(User user : users){
            System.out.println("Star finding "+user.getName()+"...");
            PlayerData playerData = new PlayerData();
            playerData.setUser(user);
            driver.get(user.getUrl());
            for (int j = 1; j < driver.findElement(By.className("team_info_wrapper")).findElements(By.className("datas")).size(); j++) {
                WebElement dataName = driver.findElement(By.className("team_info_wrapper")).findElements(By.className("dataname")).get(j);
                WebElement data = driver.findElement(By.className("team_info_wrapper")).findElements(By.className("datas")).get(j);
                waitForVisibleWebElement(dataName);
                waitForVisibleWebElement(data);
                if(dataName.getText().equals("Születési idő")){
                    playerData.setSzulDate(data.getText());
                }
                if(dataName.getText().equals("Kor")){
                    playerData.setKor(Integer.parseInt(data.getText()));
                }
            }
            playerData.setMeccsek(Integer.parseInt(driver.findElement(By.className("doughnutSummaryTitle")).getText()));
            playerData.setGolok(Integer.parseInt(getTextById("playerStatGoalsCnt")));
            playerData.setOnGolok(Integer.parseInt(getTextById("playerStatOwnGoalsCnt")));
            playerData.setSargaLap(Integer.parseInt(getTextById("playerStatYCCnt")));
            playerData.setPirosLap(Integer.parseInt(getTextById("playerStatRCCnt")));
            playerData.setKezdo(Integer.parseInt(getTextById("playerStatStartCnt")));
            playerData.setCsere(Integer.parseInt(getTextById("playerStatPlInCnt")));
            playerData.setKispad(Integer.parseInt(getTextById("playerStatPlOutCnt")));
            datas.add(playerData);
        }
        return datas;
    }

    public ArrayList<Tabella> processTabella(List<Liga> ligas) throws InterruptedException {
        ArrayList<Tabella> arrayList = new ArrayList<>();
        for (Liga liga : ligas){
            int ford = selectFederationAndLeague(liga.getSzervezo(), liga.getLiga());
            List<WebElement> sorok = driver.findElement(By.id("tableContent")).findElements(By.tagName("tr"));
            for (int f = 0; sorok.size() > f; f++) {
                List<WebElement> adatok = sorok.get(f).findElements(By.tagName("td"));
                ArrayList<String> rowData = new ArrayList<>();
                for (int g = 0; adatok.size() > g; g++) {
                    String s = adatok.get(g).getText();
                    if (!s.equals("")) {
                        rowData.add(s);
                    }
                }
                Tabella tabella = new Tabella();
                tabella.setLiga(liga);
                tabella.setFordulo(ford);
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
                    int length = rowData.get(11).split("\n").length;
                    tabella.setForma1(rowData.get(11).split("\n")[0]);
                    if (length > 1){
                        tabella.setForma2(rowData.get(11).split("\n")[1]);
                    }
                    if (length > 2){
                        tabella.setForma3(rowData.get(11).split("\n")[2]);
                    }
                    if (length > 3){
                        tabella.setForma4(rowData.get(11).split("\n")[3]);
                    }
                    if (length > 4){
                        tabella.setForma5(rowData.get(11).split("\n")[4]);
                    }
                }
                arrayList.add(tabella);
            }
        }
        return arrayList;
    }

    public ArrayList<Tabella> processTabellaFirst(List<Liga> ligas, Integer maxFord) throws InterruptedException {
        ArrayList<Tabella> arrayList = new ArrayList<>();
        for (Liga liga : ligas){
            for(int i = 1; i < maxFord; i++){
                int ford = selectFederationAndLeague(liga.getSzervezo(), liga.getLiga(), i);
                List<WebElement> sorok = driver.findElement(By.id("tableContent")).findElements(By.tagName("tr"));
                for (int f = 0; sorok.size() > f; f++) {
                    List<WebElement> adatok = sorok.get(f).findElements(By.tagName("td"));
                    ArrayList<String> rowData = new ArrayList<>();
                    for (int g = 0; adatok.size() > g; g++) {
                        String s = adatok.get(g).getText();
                        if (!s.equals("")) {
                            rowData.add(s);
                        }
                    }
                    Tabella tabella = new Tabella();
                    tabella.setLiga(liga);
                    tabella.setFordulo(ford);
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
                        int length = rowData.get(11).split("\n").length;
                        tabella.setForma1(rowData.get(11).split("\n")[0]);
                        if (length > 1){
                            tabella.setForma2(rowData.get(11).split("\n")[1]);
                        }
                        if (length > 2){
                            tabella.setForma3(rowData.get(11).split("\n")[2]);
                        }
                        if (length > 3){
                            tabella.setForma4(rowData.get(11).split("\n")[3]);
                        }
                        if (length > 4){
                            tabella.setForma5(rowData.get(11).split("\n")[4]);
                        }
                    }
                    arrayList.add(tabella);
                }
            }
        }
        return arrayList;
    }

    public ArrayList<Sorsolas> processSorsolas(List<Liga> ligas) throws InterruptedException {
        ArrayList<Sorsolas> arrayList = new ArrayList<>();
        for(Liga liga : ligas){
            selectFederationAndLeague(liga.getSzervezo(), liga.getLiga());
            selectOrganization(liga.getKlubName());
            Thread.sleep(1000);
            List<WebElement> sorok = driver.findElement(By.id("sorsolas_panel")).findElements(By.className("schedule"));
            for (int f = 0; sorok.size() > f; f++) {
                List<WebElement> adatok = sorok.get(f).findElements(By.tagName("div"));
                List<WebElement> logok = sorok.get(f).findElements(By.tagName("img"));
                Sorsolas sorsolas = new Sorsolas();
                sorsolas.setLiga(liga);
                sorsolas.setHazai(adatok.get(0).getText());
                sorsolas.setEredmeny(adatok.get(2).getText());
                sorsolas.setVendeg(adatok.get(5).getText());
                sorsolas.setDatum(adatok.get(6).getText());
                sorsolas.setHely(adatok.get(7).getText());
                sorsolas.setHazaiURL(logok.get(0).getAttribute("src"));
                sorsolas.setVendegURL(logok.get(1).getAttribute("src"));
                arrayList.add(sorsolas);
            }
        }
        return arrayList;
    }

    public ArrayList<Goals> processGoals(List<Liga> ligas, OrganizationService organizationService) throws InterruptedException {
        ArrayList<Goals> arrayList = new ArrayList<>();
        for(Liga liga : ligas){
            for(int i = 1; i < 19; i++){
                int ford = selectFederationAndLeague(liga.getSzervezo(), liga.getLiga(), i);
                selectOrganization(liga.getKlubName());
                Thread.sleep(1000);
                waitForVisibleWebElement(driver.findElement(By.id("gollovo_panel_Home2_gomb")));
                driver.findElement(By.id("gollovo_panel_Home2_gomb")).click();
                List<WebElement> sorok = driver.findElement(By.id("miniListGoalShooterContentHome")).findElements(By.className("template-tr-selectable"));
                for (int f = 0; sorok.size() > f; f++) {
                    List<WebElement> adatok = sorok.get(f).findElements(By.tagName("td"));
                    Goals goal = new Goals();
                    goal.setLiga(liga);
                    goal.setOrganization(organizationService.findOrganizationByName(adatok.get(2).getText().split("\n")[1]));
                    goal.setFordulo(ford);
                    goal.setHely(Integer.parseInt(adatok.get(0).getText()));
                    goal.setName(adatok.get(2).getText().split("\n")[0]);
                    goal.setGoal(Integer.parseInt(adatok.get(3).getText()));
                    arrayList.add(goal);
                }
            }
        }
        return arrayList;
    }

    public ArrayList<YellowCard> processYellowCard(List<Liga> ligas, OrganizationService organizationService) throws InterruptedException {
        ArrayList<YellowCard> arrayList = new ArrayList<>();
        for(Liga liga : ligas){
            selectFederationAndLeague(liga.getSzervezo(), liga.getLiga());
            selectOrganization(liga.getKlubName());
            Thread.sleep(1000);
            waitForVisibleWebElement(driver.findElement(By.id("sargalap_panel_Home2_gomb")));
            driver.findElement(By.id("sargalap_panel_Home2_gomb")).click();
            List<WebElement> sorok = driver.findElement(By.id("miniListYellowCardContentHome")).findElements(By.className("template-tr-selectable"));
            for (int f = 0; sorok.size() > f; f++) {
                List<WebElement> adatok = sorok.get(f).findElements(By.tagName("td"));
                YellowCard yellowCard = new YellowCard();
                yellowCard.setLiga(liga);
                yellowCard.setOrganization(organizationService.findOrganizationByName(adatok.get(2).getText().split("\n")[1]));
                yellowCard.setHely(Integer.parseInt(adatok.get(0).getText()));
                yellowCard.setName(adatok.get(2).getText().split("\n")[0]);
                yellowCard.setCard(Integer.parseInt(adatok.get(3).getText()));
                arrayList.add(yellowCard);
            }
        }
        return arrayList;
    }

    public ArrayList<RedCard> processRedCard(List<Liga> ligas, OrganizationService organizationService) throws InterruptedException {
        ArrayList<RedCard> arrayList = new ArrayList<>();
        for(Liga liga : ligas){
            selectFederationAndLeague(liga.getSzervezo(), liga.getLiga());
            selectOrganization(liga.getKlubName());
            Thread.sleep(1000);
            waitForVisibleWebElement(driver.findElement(By.id("piros_panel_Home2_gomb")));
            driver.findElement(By.id("piros_panel_Home2_gomb")).click();
            List<WebElement> sorok = driver.findElement(By.id("miniListRedCardContentHome")).findElements(By.className("template-tr-selectable"));
            for (int f = 0; sorok.size() > f; f++) {
                List<WebElement> adatok = sorok.get(f).findElements(By.tagName("td"));
                RedCard redCard = new RedCard();
                redCard.setLiga(liga);
                redCard.setOrganization(organizationService.findOrganizationByName(adatok.get(2).getText().split("\n")[1]));
                redCard.setHely(Integer.parseInt(adatok.get(0).getText()));
                redCard.setName(adatok.get(2).getText().split("\n")[0]);
                redCard.setCard(Integer.parseInt(adatok.get(3).getText()));
                arrayList.add(redCard);
            }
        }
        return arrayList;
    }

    //region Helpers
    private String getTextById(String id) {
        WebElement element = driver.findElement(By.id(id));
        waitForVisibleWebElement(element);
        return element.getText();
    }

    private void waitForVisibleWebElement(WebElement webElement) {
        wait.until((Function<? super WebDriver, ?>) ExpectedConditions.visibilityOf(webElement));
    }
    //endregion
}
