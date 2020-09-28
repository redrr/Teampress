package hu.playmaker.database.model.databank;

import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;

@Entity
@Table(name="PLAYER_DATA", schema="probe")
@NamedQueries({
        @NamedQuery(name="PlayerData.findAll", query="SELECT u FROM PlayerData u"),
        @NamedQuery(name="PlayerData.countAll", query="SELECT COUNT(u) FROM PlayerData u"),
        @NamedQuery(name="PlayerData.findById", query="SELECT u FROM PlayerData u WHERE u.id = :pid"),
        @NamedQuery(name="PlayerData.findByUser", query="SELECT u FROM PlayerData u WHERE u.user = :pu"),
        @NamedQuery(name="PlayerData.maxmeccsek", query="SELECT MAX(u.meccsek) FROM PlayerData u"),
        @NamedQuery(name="PlayerData.maxgolok", query="SELECT MAX(u.golok) FROM PlayerData u"),
        @NamedQuery(name="PlayerData.maxonGolok", query="SELECT MAX(u.onGolok) FROM PlayerData u"),
        @NamedQuery(name="PlayerData.maxsargaLap", query="SELECT MAX(u.sargaLap) FROM PlayerData u"),
        @NamedQuery(name="PlayerData.maxpirosLap", query="SELECT MAX(u.pirosLap) FROM PlayerData u"),
        @NamedQuery(name="PlayerData.maxkezdo", query="SELECT MAX(u.kezdo) FROM PlayerData u"),
        @NamedQuery(name="PlayerData.maxcsere", query="SELECT MAX(u.csere) FROM PlayerData u"),
        @NamedQuery(name="PlayerData.maxkor", query="SELECT MAX(u.kor) FROM PlayerData u"),
        @NamedQuery(name="PlayerData.maxkispad", query="SELECT MAX(u.kispad) FROM PlayerData u")
})
public class PlayerData extends BaseModel {

    private static final long serialVersionUID = 1L;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="USER_ID", nullable=false)
    private User user;

    @Column(name="SZUL")
    private String szulDate;

    @Column(name="KOR")
    private Integer kor;

    @Column(name="MECCSEK")
    private Integer meccsek;

    @Column(name="GOLOK")
    private Integer golok;

    @Column(name="ONGOLOK")
    private Integer onGolok;

    @Column(name="SARGA")
    private Integer sargaLap;

    @Column(name="PIROS")
    private Integer pirosLap;

    @Column(name="KEZDO")
    private Integer kezdo;

    @Column(name="CSERE")
    private Integer csere;

    @Column(name="KISPAD")
    private Integer kispad;

    public PlayerData() {
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getSzulDate() {
        return szulDate;
    }

    public void setSzulDate(String szulDate) {
        this.szulDate = szulDate;
    }

    public Integer getKor() {
        return kor;
    }

    public void setKor(Integer kor) {
        this.kor = kor;
    }

    public Integer getMeccsek() {
        return meccsek;
    }

    public void setMeccsek(Integer meccsek) {
        this.meccsek = meccsek;
    }

    public Integer getGolok() {
        return golok;
    }

    public void setGolok(Integer golok) {
        this.golok = golok;
    }

    public Integer getOnGolok() {
        return onGolok;
    }

    public void setOnGolok(Integer onGolok) {
        this.onGolok = onGolok;
    }

    public Integer getSargaLap() {
        return sargaLap;
    }

    public void setSargaLap(Integer sargaLap) {
        this.sargaLap = sargaLap;
    }

    public Integer getPirosLap() {
        return pirosLap;
    }

    public void setPirosLap(Integer pirosLap) {
        this.pirosLap = pirosLap;
    }

    public Integer getKezdo() {
        return kezdo;
    }

    public void setKezdo(Integer kezdo) {
        this.kezdo = kezdo;
    }

    public Integer getCsere() {
        return csere;
    }

    public void setCsere(Integer csere) {
        this.csere = csere;
    }

    public Integer getKispad() {
        return kispad;
    }

    public void setKispad(Integer kispad) {
        this.kispad = kispad;
    }
}
