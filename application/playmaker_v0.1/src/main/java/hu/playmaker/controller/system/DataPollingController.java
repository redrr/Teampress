package hu.playmaker.controller.system;

import hu.playmaker.database.model.databank.*;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.databank.*;
import hu.playmaker.database.service.system.OrganizationService;
import hu.playmaker.database.service.system.UserService;
import hu.playmaker.handler.MLSZDataHandler;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Configuration
@EnableScheduling
public class DataPollingController {

    private UserService userService;
    private PlayerDataService playerDataService;
    private TabellaService tabellaService;
    private LigaService ligaService;
    private SorsolasService sorsolasService;
    private OrganizationService organizationService;
    private GoalsService goalsService;
    private YellowCardService yellowCardService;
    private RedCardService redCardService;
    private boolean isProcessing = true;

    public DataPollingController(UserService userService, PlayerDataService playerDataService, TabellaService tabellaService, LigaService ligaService, SorsolasService sorsolasService, OrganizationService organizationService, GoalsService goalsService, YellowCardService yellowCardService, RedCardService redCardService) {
        this.userService = userService;
        this.playerDataService = playerDataService;
        this.tabellaService = tabellaService;
        this.ligaService = ligaService;
        this.sorsolasService = sorsolasService;
        this.organizationService = organizationService;
        this.goalsService = goalsService;
        this.yellowCardService = yellowCardService;
        this.redCardService = redCardService;
    }

    @RequestMapping("/p")
    public String getPlayerData(){
        MLSZDataHandler handler = new MLSZDataHandler();
        List<User> players = userService.findAllPlayer();
        ArrayList<PlayerData> arrayList = handler.processPlayerData(players);
        updatePlayerData(arrayList);
        return "redirect:/";
    }

    @RequestMapping("/t")
    public String getTabella() throws InterruptedException {
        MLSZDataHandler handler = new MLSZDataHandler();
        ArrayList<Tabella> arrayList = handler.processTabella(ligaService.findAll());
        updateTabella(arrayList);
        return "redirect:/";
    }

    @RequestMapping("/s")
    public String getSorsolas() throws InterruptedException {
        MLSZDataHandler handler = new MLSZDataHandler();
        ArrayList<Sorsolas> arrayList = handler.processSorsolas(ligaService.findAll());
        updateSorsolas(arrayList);
        return "redirect:/";
    }

    @RequestMapping("/g")
    public String getGoals() throws InterruptedException {
        MLSZDataHandler handler = new MLSZDataHandler();
        ArrayList<Goals> arrayList = handler.processGoals(ligaService.findAll(), organizationService);
        updateGoals(arrayList);
        return "redirect:/";
    }

    @RequestMapping("/y")
    public String getyc() throws InterruptedException {
        MLSZDataHandler handler = new MLSZDataHandler();
        ArrayList<YellowCard> arrayList = handler.processYellowCard(ligaService.findAll(), organizationService);
        updateYellowCards(arrayList);
        return "redirect:/";
    }

    @RequestMapping("/r")
    public String getrc() throws InterruptedException {
        MLSZDataHandler handler = new MLSZDataHandler();
        ArrayList<RedCard> arrayList = handler.processRedCard(ligaService.findAll(), organizationService);
        updateRedCards(arrayList);
        return "redirect:/";
    }

    @Scheduled(fixedDelay = 1000000)
    public void runDataBankUpdateAll(){
        if(!isProcessing){
            try {
                List<Liga> allLigas = ligaService.findAll();
                List<User> allPlayers = userService.findAllPlayer();
                MLSZDataHandler handler = new MLSZDataHandler();
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
                LocalDateTime now;
                this.isProcessing = true;
                now = LocalDateTime.now();
                System.out.println(dtf.format(now));
                handler.startProcessor();
                //updatePlayerData(handler.processPlayerData(allPlayers));
                updateTabella(handler.processTabella(allLigas));
                //updateSorsolas(handler.processSorsolas(allLigas));
                //updateGoals(handler.processGoals(allLigas, organizationService));
                //updateYellowCards(handler.processYellowCard(allLigas, organizationService));
                //updateRedCards(handler.processRedCard(allLigas, organizationService));
                handler.quitProcessor();
                now = LocalDateTime.now();
                System.out.println(dtf.format(now));
                this.isProcessing = false;
            } catch (Exception e){
                System.out.println("Hiba történt az adat frissítés alatt!\n");
                e.printStackTrace();
            }
        } else {
            System.out.println("Már fut AdatBank frissítés...");
        }
    }

    private void updatePlayerData(ArrayList<PlayerData> arrayList) {
        System.out.println("Játékos adatok fissítése...");
        for(PlayerData data : arrayList) {
            System.out.println("Játékos - "+data.getUser().getName());
            if(playerDataService.existsByCodeAndUser(data.getUser())){
                PlayerData old = playerDataService.getPlayerDataByCode(data.getUser());
                old.setKispad(data.getKispad());
                old.setCsere(data.getCsere());
                old.setKezdo(data.getKezdo());
                old.setPirosLap(data.getPirosLap());
                old.setSargaLap(data.getSargaLap());
                old.setOnGolok(data.getOnGolok());
                old.setGolok(data.getGolok());
                old.setMeccsek(data.getMeccsek());
                old.setKor(data.getKor());
                old.setSzulDate(data.getSzulDate());
                playerDataService.mergeFlush(old);
            } else {
                playerDataService.mergeFlush(data);
            }
        }
        System.out.println("Játékos adatok fissítése kész.");
    }

    private void updateTabella(ArrayList<Tabella> arrayList){
        System.out.println("Tabella adatok fissítése...");
        for(Tabella t: arrayList){
            System.out.println("Tabella - "+ t.getLiga().getLiga());
            if(tabellaService.existByTeamLigaAndFord(t.getLiga(), t.getCsapat(), t.getFordulo())) {
                Tabella tabella = tabellaService.getByTeamLigaAndFord(t.getLiga(), t.getCsapat(), t.getFordulo());
                tabella.setLiga(t.getLiga());
                tabella.setFordulo(t.getFordulo());
                tabella.setHelyezes(t.getHelyezes());
                tabella.setCsapat(t.getCsapat());
                tabella.setMecsekSzama(t.getMecsekSzama());
                tabella.setGyozelemekSzama(t.getGyozelemekSzama());
                tabella.setDontetlenekSzama(t.getDontetlenekSzama());
                tabella.setVeresegekSzama(t.getVeresegekSzama());
                tabella.setLottGolokSzama(t.getLottGolokSzama());
                tabella.setKapottGolokSzama(t.getKapottGolokSzama());
                tabella.setGolkulonbseg(t.getGolkulonbseg());
                tabella.setPontszam(t.getPontszam());
                tabella.setEllenfelekHelyezesenekAtlaga(t.getEllenfelekHelyezesenekAtlaga());
                tabella.setForma1(t.getForma1());
                tabella.setForma2(t.getForma2());
                tabella.setForma3(t.getForma3());
                tabella.setForma4(t.getForma4());
                tabella.setForma5(t.getForma5());
                tabellaService.mergeFlush(tabella);
            } else {
                t.setPontszam(t.getPontszam());
                tabellaService.mergeFlush(t);
            }
        }
        System.out.println("Tabella adatok fissítése kész.");
    }

    private void updateSorsolas(ArrayList<Sorsolas> arrayList){
        System.out.println("Sorsolás adatok fissítése...");
        for(Sorsolas s : arrayList){
            System.out.println("Sorsolás - "+ s.getLiga().getLiga());
            List<Sorsolas> list = sorsolasService.getUnique(s.getLiga(), s.getVendeg(), s.getHazai(), s.getDatum());
            if(list.size() > 0){
                Sorsolas sorsolas = list.get(0);
                sorsolas.setEredmeny(s.getEredmeny());
                sorsolas.setHely(s.getHely());
                sorsolas.setHazaiURL(s.getHazaiURL());
                sorsolas.setVendegURL(s.getVendegURL());
                sorsolasService.mergeFlush(sorsolas);
            } else {
                sorsolasService.mergeFlush(s);
            }
        }
        System.out.println("Sorsolás adatok fissítése kész.");
    }

    private void updateGoals(ArrayList<Goals> arrayList){
        System.out.println("Góllövő lista fissítése...");
        for(Goals goals : arrayList){
            System.out.println("Góllövő - "+goals.getName());
            if(goalsService.findAllUnique(goals.getLiga(), goals.getOrganization(), goals.getFordulo(), goals.getName()).size() > 0){
                Goals goal = goalsService.findUnique(goals.getLiga(), goals.getOrganization(), goals.getFordulo(), goals.getName());
                goal.setHely(goals.getHely());
                goal.setGoal(goals.getGoal());
                if(goals.getFordulo() > 1){
                    goal.setGoalInFord(goals.getGoal() - goalsService.findUnique(goals.getLiga(), goals.getOrganization(), goals.getFordulo()-1, goals.getName()).getGoal());
                } else {
                    goal.setGoalInFord(goals.getGoal());
                }
                goalsService.mergeFlush(goal);
            } else {
                if(Objects.nonNull(goalsService.findUnique(goals.getLiga(), goals.getOrganization(), goals.getFordulo()-1, goals.getName()))){
                    goals.setGoalInFord(goals.getGoal() - goalsService.findUnique(goals.getLiga(), goals.getOrganization(), goals.getFordulo()-1, goals.getName()).getGoal());
                } else {
                    goals.setGoalInFord(goals.getGoal());
                }
                goalsService.mergeFlush(goals);
            }
        }
        System.out.println("Góllövő lista fissítése kész.");
    }

    private void updateYellowCards(ArrayList<YellowCard> arrayList){
        System.out.println("Sárgalap lista fissítése...");
        for(YellowCard yellowCardNew : arrayList){
            System.out.println("Sárgalap - "+yellowCardNew.getName());
            if(yellowCardService.findUnique(yellowCardNew.getLiga(), yellowCardNew.getOrganization(), yellowCardNew.getName()).size() > 0){
                YellowCard yellowCard = yellowCardService.findUnique(yellowCardNew.getLiga(), yellowCardNew.getOrganization(), yellowCardNew.getName()).get(0);
                yellowCard.setHely(yellowCardNew.getHely());
                yellowCard.setCard(yellowCardNew.getCard());
                yellowCardService.mergeFlush(yellowCard);
            } else {
                yellowCardService.mergeFlush(yellowCardNew);
            }
        }
        System.out.println("Sárgalap lista fissítése kész.");
    }

    private void updateRedCards(ArrayList<RedCard> arrayList){
        System.out.println("Sárgalap lista fissítése...");
        for(RedCard redCardNew : arrayList){
            System.out.println("Sárgalap - "+redCardNew.getName());
            if(redCardService.findUnique(redCardNew.getLiga(), redCardNew.getOrganization(), redCardNew.getName()).size() > 0){
                RedCard redCard = redCardService.findUnique(redCardNew.getLiga(), redCardNew.getOrganization(), redCardNew.getName()).get(0);
                redCard.setHely(redCardNew.getHely());
                redCard.setCard(redCardNew.getCard());
                redCardService.mergeFlush(redCard);
            } else {
                redCardService.mergeFlush(redCardNew);
            }
        }
        System.out.println("Sárgalap lista fissítése kész.");
    }
}
