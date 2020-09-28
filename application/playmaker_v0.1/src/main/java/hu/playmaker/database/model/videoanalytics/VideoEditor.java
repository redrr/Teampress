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
@Table(name="VIDEOEDITOR", schema="probe")
@NamedQueries({
        @NamedQuery(name="VideoEditor.findAll", query="SELECT p FROM VideoEditor p"),
        @NamedQuery(name="VideoEditor.countAll", query="SELECT COUNT(p) FROM VideoEditor p"),
        @NamedQuery(name="VideoEditor.findById", query="SELECT p FROM VideoEditor p WHERE p.id = :pid"),
        @NamedQuery(name="VideoEditor.findByOrg", query="SELECT p FROM VideoEditor p WHERE p.organization=:porg"),
        @NamedQuery(name="VideoEditor.findByVideo", query="SELECT p FROM VideoEditor p WHERE p.video=:pvideo"),
})
@Cacheable(false)
public class VideoEditor extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="ORG_ID")
    private Organization organization;

    @ManyToOne
    @JoinColumn(name="TEAM_ID")
    private LookupCode team;

    @ManyToOne
    @JoinColumn(name="SORSOLAS_ID")
    private Sorsolas ligaGame;

    @ManyToOne
    @JoinColumn(name="CUSTOM_GAME_ID")
    private CustomGame customGame;

    @ManyToOne
    @JoinColumn(name="TRAINING_ID")
    private TrainingPlan training;

    @ManyToOne
    @JoinColumn(name="VIDEO_ID")
    private Video video;

    public VideoEditor() {
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

    public Sorsolas getLigaGame() {
        return ligaGame;
    }

    public void setLigaGame(Sorsolas ligaGame) {
        this.ligaGame = ligaGame;
    }

    public CustomGame getCustomGame() {
        return customGame;
    }

    public void setCustomGame(CustomGame customGame) {
        this.customGame = customGame;
    }

    public TrainingPlan getTraining() {
        return training;
    }

    public void setTraining(TrainingPlan training) {
        this.training = training;
    }

    public Video getVideo() {
        return video;
    }

    public void setVideo(Video video) {
        this.video = video;
    }
}
