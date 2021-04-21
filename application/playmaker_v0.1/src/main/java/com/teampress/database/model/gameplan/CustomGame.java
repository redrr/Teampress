package com.teampress.database.model.gameplan;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static java.util.Objects.isNull;

@Entity
@Table(name="CUSTOMGAME", schema="teampress")
@NamedQueries({
        @NamedQuery(name="CustomGame.findAll", query="SELECT p FROM CustomGame p"),
        @NamedQuery(name="CustomGame.findById", query="SELECT p FROM CustomGame p WHERE p.id = :pid"),
        @NamedQuery(name="CustomGame.findByOrg", query="SELECT p FROM CustomGame p WHERE p.organization=:porg"),
        @NamedQuery(name="CustomGame.findByTeamAndDate", query="SELECT p FROM CustomGame p WHERE p.team=:pteam AND p.date=:pdate"),
        @NamedQuery(name="CustomGame.findByCreated", query="SELECT p FROM CustomGame p WHERE p.createdBy=:pby AND p.deleted=false")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class CustomGame extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="ORG_ID")
    private Organization organization;

    @ManyToOne
    @JoinColumn(name="TEAM_ID")
    private LookupCode team;

    @Column(name="UUID", length=255)
    private String uuid;

    @Column(name="ELLEN", length=255)
    private String enemy;

    @Column(name="HELY", length=255)
    private String place;

    @Column(name="DATUM", length=255)
    private Date date;

    @Column(name="DELETED", length=255)
    private Boolean deleted;

    public String getFormattedDate(boolean flag){
        SimpleDateFormat dateFormat = new SimpleDateFormat(flag ? "yyyy/MM/dd/HH:mm" : "yyyy-MM-dd HH:mm");
        return (isNull(getDate())) ? "" : dateFormat.format(getDate());
    }

    public void setFormattedDate(String date) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
            Date parsedDate = dateFormat.parse(date);
            this.date = parsedDate;
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
