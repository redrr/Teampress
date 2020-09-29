package hu.playmaker.database.model.videoanalytics;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.databank.Sorsolas;
import hu.playmaker.database.model.gameplan.CustomGame;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.trainingplan.TrainingPlan;

import javax.persistence.*;

@Entity
@Table(name="SCENE", schema="teampress")
@NamedQueries({
        @NamedQuery(name="Scene.findAll", query="SELECT p FROM Scene p"),
        @NamedQuery(name="Scene.countAll", query="SELECT COUNT(p) FROM Scene p"),
        @NamedQuery(name="Scene.findById", query="SELECT p FROM Scene p WHERE p.id = :pid"),
        @NamedQuery(name="Scene.findByOrg", query="SELECT p FROM Scene p WHERE p.organization=:porg"),
        @NamedQuery(name="Scene.findByFolder", query="SELECT p FROM Scene p WHERE p.folder=:pfolder"),
})
@Cacheable(false)
public class Scene extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="ORG_ID")
    private Organization organization;

    @ManyToOne
    @JoinColumn(name="TEAM_ID")
    private LookupCode team;

    @ManyToOne
    @JoinColumn(name="USER_ID")
    private User user;

    @ManyToOne
    @JoinColumn(name="FOLDER_ID")
    private Folder folder;

    @ManyToOne
    @JoinColumn(name="VIDEO_ID")
    private Video video;

    @Column(name="NAME", length=255)
    private String name;

    @Column(name="DESCRIPTION", length=255)
    private String description;

    public Scene() {
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    public LookupCode getTeam() {
        return team;
    }

    public void setTeam(LookupCode team) {
        this.team = team;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Folder getFolder() {
        return folder;
    }

    public void setFolder(Folder folder) {
        this.folder = folder;
    }
}
