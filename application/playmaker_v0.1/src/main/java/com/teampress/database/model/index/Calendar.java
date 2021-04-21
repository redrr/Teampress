package com.teampress.database.model.index;

import com.google.gson.annotations.Expose;
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

/**
 * The persistent class for the TRAINING_TYPE database table.
 *
 */
@Entity
@Table(name="CALENDAR", schema="teampress")
@NamedQueries({
        @NamedQuery(name="Calendar.findAll", query="SELECT c FROM Calendar c"),
        @NamedQuery(name="Calendar.findByOrgAndTeam", query="SELECT c FROM Calendar c WHERE c.organization = :porg AND c.team = :pteam"),
        @NamedQuery(name="Calendar.findByOrg", query="SELECT c FROM Calendar c WHERE c.organization = :porg AND c.team IS NULL "),
        @NamedQuery(name="Calendar.findByUuid", query="SELECT c FROM Calendar c WHERE c.uuid = :puuid"),
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Calendar extends BaseModel {

    private static final long serialVersionUID = 1L;

    //bi-directional many-to-one association to Organization
    @Expose
    @ManyToOne
    @JoinColumn(name="ORGANIZATION_ID", nullable=false)
    private Organization organization;

    @Expose
    @ManyToOne
    @JoinColumn(name="TEAM_ID")
    private LookupCode team;

    @Column(name="UUID", length=255)
    private String uuid;

    @Expose
    @Column(name="EVENT_NAME", length=255)
    private String eventName;

    @Expose
    @Column(name="EVENT_COLOR", length=255)
    private String color;

    @Expose
    @Column(name="START_DATE_TIME", length=255)
    private Date startDateTime;

    @Expose
    @Column(name="END_DATE_TIME", length=255)
    private Date endDateTime;

    public String getFormattedStartDate() {
        SimpleDateFormat dateFormat0 = new SimpleDateFormat("yyyy-MM-dd");
        String parsedDate0 = dateFormat0.format(this.startDateTime);
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("HH:mm");
        String parsedDate1 = dateFormat1.format(this.startDateTime);
        return parsedDate0+"T"+parsedDate1;
    }

    public void setFormattedStartDate(String startDateTime) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            this.startDateTime = dateFormat.parse(startDateTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public String getFormattedEndDate() {
        SimpleDateFormat dateFormat0 = new SimpleDateFormat("yyyy-MM-dd");
        String parsedDate0 = dateFormat0.format(this.endDateTime);
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("HH:mm");
        String parsedDate1 = dateFormat1.format(this.endDateTime);
        return parsedDate0+"T"+parsedDate1;
    }

    public void setFormattedEndDate(String endDateTime) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            this.endDateTime = dateFormat.parse(endDateTime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
