package hu.playmaker.database.model.databank;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static java.util.Objects.isNull;

@Entity
@Table(name="LOTTERY", schema="teampress")
@NamedQueries({
        @NamedQuery(name="Sorsolas.findAll", query="SELECT l FROM Sorsolas l"),
        @NamedQuery(name="Sorsolas.countAll", query="SELECT COUNT(l) FROM Sorsolas l"),
        @NamedQuery(name="Sorsolas.findById", query = "SELECT l FROM Sorsolas l WHERE l.id = :pid"),
        @NamedQuery(name="Sorsolas.findByName", query = "SELECT l FROM Sorsolas l WHERE l.liga = :pliga"),
        @NamedQuery(name="Sorsolas.findByFord", query = "SELECT l FROM Sorsolas l WHERE l.vendeg = :pcsapat"),
        @NamedQuery(name="Sorsolas.findByTeamAndLiga", query = "SELECT l FROM Sorsolas l WHERE l.liga = :pliga AND ( l.vendeg = :pcsapat OR l.hazai = :pcsapat) ORDER BY l.datum ASC"),
        @NamedQuery(name="Sorsolas.findByLigaHazaiVendegDate", query = "SELECT l FROM Sorsolas l WHERE l.liga = :pliga AND l.vendeg = :pv AND l.hazai = :ph AND l.datum=:pdatum"),
        @NamedQuery(name="Sorsolas.findCustomByTeamAndLiga", query = "SELECT l FROM Sorsolas l WHERE l.liga = :pliga AND ( l.vendeg = :pcsapat OR l.hazai = :pcsapat)ORDER BY l.datum ASC"),
        @NamedQuery(name="Sorsolas.getCustomCreatedBy", query = "SELECT l FROM Sorsolas l WHERE l.createdBy=:pby ORDER BY l.datum ASC")
})
public class Sorsolas extends BaseModel {

    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="LIGA_ID")
    private Liga liga;

    @Column(name="HAZAI")
    private String hazai;

    @Column(name="HAZAI_IMG")
    private String hazaiURL;

    @Column(name="EREDMENY")
    private String eredmeny;

    @Column(name="VENDEG")
    private String vendeg;

    @Column(name="VENDEG_IMG")
    private String vendegURL;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="DATUM")
    private Date datum;

    @Column(name="HELY")
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
