package hu.playmaker.database.model.videoanalytics;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.service.system.UserService;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name="ANALYTICSACTION", schema="teampress")
@NamedQueries({
        @NamedQuery(name="AnalyticsAction.findById", query="SELECT p FROM AnalyticsAction p WHERE p.id = :pid"),
        @NamedQuery(name="AnalyticsAction.findByVideo", query="SELECT p FROM AnalyticsAction p WHERE p.sourceVideo =:pvideo AND p.organization = :porg"),
})
@Cacheable(false)
public class AnalyticsAction extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="ORG_ID", nullable=false)
    private Organization organization;

    @ManyToOne
    @JoinColumn(name="VIDEO_ID")
    private Video sourceVideo;

    @Column(name="NAME", length=255)
    private String name;

    @Column(name="PLAYERS", length=255)
    private String playerIds;

    @Column(name="COMMENT", length=255)
    private String comment;

    @Column(name="TIME", length=255)
    private String time;

    @Column(name="JSON", length=255)
    private String bluePrint;

    public AnalyticsAction() {
    }

    public Video getSourceVideo() {
        return sourceVideo;
    }

    public void setSourceVideo(Video sourceVideo) {
        this.sourceVideo = sourceVideo;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getBluePrint() {
        return bluePrint;
    }

    public void setBluePrint(String bluePrint) {
        this.bluePrint = bluePrint;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPlayerIds() {
        return playerIds;
    }

    public void setPlayerIds(String playerIds) {
        this.playerIds = playerIds;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }
}
