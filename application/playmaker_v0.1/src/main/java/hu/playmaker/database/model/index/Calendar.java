package hu.playmaker.database.model.index;

import com.google.gson.annotations.Expose;
import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;

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
        @NamedQuery(name="Calendar.countAll", query="SELECT COUNT(c) FROM Calendar c"),
        @NamedQuery(name="Calendar.findByOrgAndTeam", query="SELECT c FROM Calendar c WHERE c.organization = :porg AND c.team = :pteam"),
        @NamedQuery(name="Calendar.findByOrg", query="SELECT c FROM Calendar c WHERE c.organization = :porg AND c.team IS NULL "),
        @NamedQuery(name="Calendar.findById", query="SELECT exc FROM Calendar exc WHERE exc.id = :pid")
})
@Cacheable(false)
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

    public Calendar() {
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getStartDateTime() {
        SimpleDateFormat dateFormat0 = new SimpleDateFormat("yyyy-MM-dd");
        String parsedDate0 = dateFormat0.format(this.startDateTime);
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("HH:mm");
        String parsedDate1 = dateFormat1.format(this.startDateTime);
        return parsedDate0+"T"+parsedDate1;
    }

    public void setStartDateTime(String startDateTime) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date parsedDate = dateFormat.parse(startDateTime);
            this.startDateTime = parsedDate;
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
    //2019-09-05T09:00:00
    public String getEndDateTime() {
        SimpleDateFormat dateFormat0 = new SimpleDateFormat("yyyy-MM-dd");
        String parsedDate0 = dateFormat0.format(this.endDateTime);
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("HH:mm");
        String parsedDate1 = dateFormat1.format(this.endDateTime);
        return parsedDate0+"T"+parsedDate1;
    }

    public void setEndDateTime(String endDateTime) {
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            Date parsedDate = dateFormat.parse(endDateTime);
            this.endDateTime = parsedDate;
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public void setStartDateTime(Date startDateTime) {
        this.startDateTime = startDateTime;
    }

    public void setEndDateTime(Date endDateTime) {
        this.endDateTime = endDateTime;
    }

    public LookupCode getTeam() {
        return team;
    }

    public void setTeam(LookupCode team) {
        this.team = team;
    }
}
