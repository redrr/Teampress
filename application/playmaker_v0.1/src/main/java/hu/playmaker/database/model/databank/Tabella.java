package hu.playmaker.database.model.databank;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;


@Entity
@Table(name="TABELLA", schema="probe")
@NamedQueries({
        @NamedQuery(name="Tabella.findAll", query="SELECT l FROM Tabella l"),
        @NamedQuery(name="Tabella.countAll", query="SELECT COUNT(l) FROM Tabella l"),
        @NamedQuery(name="Tabella.findById", query = "SELECT l FROM Tabella l WHERE l.id = :pid"),
        @NamedQuery(name="Tabella.findByLiga", query = "SELECT l FROM Tabella l WHERE l.liga = :pliga AND l.fordulo=:pford"),
        @NamedQuery(name="Tabella.findByMaxLiga", query = "SELECT DISTINCT MAX(l.fordulo) FROM Tabella l WHERE l.liga = :pliga"),
        @NamedQuery(name="Tabella.findTeamsByLiga", query = "SELECT DISTINCT l.csapat FROM Tabella l WHERE l.liga = :pliga"),
        @NamedQuery(name="Tabella.findByFord", query = "SELECT l FROM Tabella l WHERE l.csapat = :pcsapat"),
        @NamedQuery(name="Tabella.findByLigaAndTeam", query = "SELECT l FROM Tabella l WHERE l.liga = :pliga AND l.csapat = :pcsapat AND l.fordulo=:pford"),
        @NamedQuery(name="Tabella.findByLigaTeamAndFord", query = "SELECT l FROM Tabella l WHERE l.liga = :pliga AND l.csapat = :pcsapat AND l.fordulo=:pford")
})
public class Tabella extends BaseModel {

    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="LIGA_ID")
    private Liga liga;

    @Column(name="FORDULO")
    private Integer fordulo;

    @Column(name="HELYEZES")
    private Integer helyezes;

    @Column(name="CSAPAT")
    private String csapat;

    @Column(name="MECSEK_SZAMA")
    private Integer mecsekSzama;

    @Column(name="GYOZELMEK_SZAMA")
    private Integer gyozelemekSzama;

    @Column(name="DONTETLENEK_SZAMA")
    private Integer dontetlenekSzama;

    @Column(name="VERESEGEK_SZAMA")
    private Integer veresegekSzama;

    @Column(name="LOTT_GOLOK_SZAMA")
    private Integer lottGolokSzama;

    @Column(name="KAPOTT_GOLOK_SZAMA")
    private Integer kapottGolokSzama;

    @Column(name="GOLKULONBSEG")
    private Integer golkulonbseg;

    @Column(name="PONTSZAM")
    private Integer pontszam;

    @Column(name="ELLENFELEK_HELYEZESEK_ATLAGA")
    private String ellenfelekHelyezesenekAtlaga;

    @Column(name="FROMA_1")
    private String forma1;

    @Column(name="FROMA_2")
    private String forma2;

    @Column(name="FORMA_3")
    private String forma3;

    @Column(name="FORMA_4")
    private String forma4;

    @Column(name="FORMA_5")
    private String forma5;

    public Tabella() {
    }

    public Liga getLiga() {
        return liga;
    }

    public void setLiga(Liga liga) {
        this.liga = liga;
    }

    public Integer getFordulo() {
        return fordulo;
    }

    public void setFordulo(Integer fordulo) {
        this.fordulo = fordulo;
    }

    public Integer getHelyezes() {
        return helyezes;
    }

    public void setHelyezes(Integer helyezes) {
        this.helyezes = helyezes;
    }

    public String getCsapat() {
        return csapat;
    }

    public void setCsapat(String csapat) {
        this.csapat = csapat;
    }

    public Integer getMecsekSzama() {
        return mecsekSzama;
    }

    public void setMecsekSzama(Integer mecsekSzama) {
        this.mecsekSzama = mecsekSzama;
    }

    public Integer getGyozelemekSzama() {
        return gyozelemekSzama;
    }

    public void setGyozelemekSzama(Integer gyozelemekSzama) {
        this.gyozelemekSzama = gyozelemekSzama;
    }

    public Integer getDontetlenekSzama() {
        return dontetlenekSzama;
    }

    public void setDontetlenekSzama(Integer dontetlenekSzama) {
        this.dontetlenekSzama = dontetlenekSzama;
    }

    public Integer getVeresegekSzama() {
        return veresegekSzama;
    }

    public void setVeresegekSzama(Integer veresegekSzama) {
        this.veresegekSzama = veresegekSzama;
    }

    public Integer getLottGolokSzama() {
        return lottGolokSzama;
    }

    public void setLottGolokSzama(Integer lottGolokSzama) {
        this.lottGolokSzama = lottGolokSzama;
    }

    public Integer getKapottGolokSzama() {
        return kapottGolokSzama;
    }

    public void setKapottGolokSzama(Integer kapottGolokSzama) {
        this.kapottGolokSzama = kapottGolokSzama;
    }

    public Integer getGolkulonbseg() {
        return golkulonbseg;
    }

    public void setGolkulonbseg(Integer golkulonbseg) {
        this.golkulonbseg = golkulonbseg;
    }

    public Integer getPontszam() {
        return pontszam;
    }

    public void setPontszam(Integer pontszam) {
        this.pontszam = pontszam;
    }

    public String getEllenfelekHelyezesenekAtlaga() {
        return ellenfelekHelyezesenekAtlaga;
    }

    public void setEllenfelekHelyezesenekAtlaga(String ellenfelekHelyezesenekAtlaga) {
        this.ellenfelekHelyezesenekAtlaga = ellenfelekHelyezesenekAtlaga;
    }

    public String getForma1() {
        return forma1;
    }

    public void setForma1(String forma1) {
        this.forma1 = forma1;
    }

    public String getForma2() {
        return forma2;
    }

    public void setForma2(String forma2) {
        this.forma2 = forma2;
    }

    public String getForma3() {
        return forma3;
    }

    public void setForma3(String forma3) {
        this.forma3 = forma3;
    }

    public String getForma4() {
        return forma4;
    }

    public void setForma4(String forma4) {
        this.forma4 = forma4;
    }

    public String getForma5() {
        return forma5;
    }

    public void setForma5(String forma5) {
        this.forma5 = forma5;
    }
}
