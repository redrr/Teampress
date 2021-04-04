package com.teampress.database.model.databank;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static java.util.Objects.isNull;

public class Sorsolas {

    private Liga liga;
    private String hazai;
    private String hazaiURL;
    private String eredmeny;
    private String vendeg;
    private String vendegURL;
    private Date datum;
    private String hely;

    public Sorsolas() {
    }

    public Liga getLiga() {
        return liga;
    }

    public void setLiga(Liga liga) {
        this.liga = liga;
    }

    public String getHazai() {
        return hazai;
    }

    public void setHazai(String hazai) {
        this.hazai = hazai;
    }

    public String getEredmeny() {
        return eredmeny;
    }

    public void setEredmeny(String eredmeny) {
        this.eredmeny = eredmeny;
    }

    public String getVendeg() {
        return vendeg;
    }

    public void setVendeg(String vendeg) {
        this.vendeg = vendeg;
    }

    public Date getDatum() {
        return datum;
    }

    public String getDateAs(boolean flag){
        SimpleDateFormat dateFormat = new SimpleDateFormat(flag ? "yyyy/MM/dd/HH:mm" : "yyyy-MM-dd HH:mm");
        return (isNull(getDatum())) ? "" : dateFormat.format(getDatum());
    }

    public void setCustomDatum(String datum) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
            Date parsedDate = dateFormat.parse(datum);
            this.datum = parsedDate;
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public void setDatum(String datum) {
        try {
            String[] s = datum.split(". ");
            String newDate = s[0]+"-"+s[1]+"-"+s[2]+" "+s[3]+":00";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
            Date parsedDate = dateFormat.parse(newDate);
            this.datum = parsedDate;
        } catch(Exception e) { //this generic but you can control another types of exception
            // look the origin of excption
        }
    }

    public String getHely() {
        return hely;
    }

    public void setHely(String hely) {
        this.hely = hely;
    }

    public String getHazaiURL() {
        return hazaiURL;
    }

    public void setHazaiURL(String hazaiURL) {
        this.hazaiURL = hazaiURL;
    }

    public String getVendegURL() {
        return vendegURL;
    }

    public void setVendegURL(String vendegURL) {
        this.vendegURL = vendegURL;
    }
}
