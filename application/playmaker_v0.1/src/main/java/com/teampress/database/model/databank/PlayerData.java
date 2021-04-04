package com.teampress.database.model.databank;

import com.teampress.database.model.system.User;

public class PlayerData {

    private User user;
    private String szulDate;
    private Integer kor;
    private Integer meccsek;
    private Integer golok;
    private Integer onGolok;
    private Integer sargaLap;
    private Integer pirosLap;
    private Integer kezdo;
    private Integer csere;
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
