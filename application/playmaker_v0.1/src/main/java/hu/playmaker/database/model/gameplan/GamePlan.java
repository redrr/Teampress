package hu.playmaker.database.model.gameplan;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.databank.Sorsolas;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;

import javax.persistence.*;

@Entity
@Table(name="GAMEPLAN", schema="probe")
@NamedQueries({
        @NamedQuery(name="GamePlan.findAll", query="SELECT p FROM GamePlan p"),
        @NamedQuery(name="GamePlan.countAll", query="SELECT COUNT(p) FROM GamePlan p"),
        @NamedQuery(name="GamePlan.findById", query="SELECT p FROM GamePlan p WHERE p.id = :pid"),
        @NamedQuery(name="GamePlan.findByUser", query="SELECT p.sorsolas FROM GamePlan p WHERE p.user=:puser"),
        @NamedQuery(name="GamePlan.findByOrg", query="SELECT DISTINCT p.sorsolas FROM GamePlan p WHERE p.organization=:porg"),
        @NamedQuery(name="GamePlan.findByOrgGroupedCustom", query="SELECT p FROM GamePlan p WHERE p.organization=:porg AND p.sorsolas IS NULL GROUP BY p.customGame"),
        @NamedQuery(name="GamePlan.findByOrgGroupedSors", query="SELECT p FROM GamePlan p WHERE p.organization=:porg AND p.customGame IS NULL GROUP BY p.sorsolas"),
        @NamedQuery(name="GamePlan.findByOrgGrouped", query="SELECT p FROM GamePlan p WHERE p.organization=:porg GROUP BY p.customGame"),
        @NamedQuery(name="GamePlan.findByUserAndSors", query="SELECT p FROM GamePlan p WHERE p.user=:puser AND p.sorsolas=:psors"),
        @NamedQuery(name="GamePlan.findByUserAndCG", query="SELECT p FROM GamePlan p WHERE p.user=:puser AND p.customGame=:pcg"),
        @NamedQuery(name="GamePlan.findBySors", query="SELECT p FROM GamePlan p WHERE p.sorsolas=:psors"),
        @NamedQuery(name="GamePlan.findByCG", query="SELECT p FROM GamePlan p WHERE p.customGame=:pcg")
})
@Cacheable(false)
public class GamePlan extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="ORG_ID")
    private Organization organization;

    @ManyToOne
    @JoinColumn(name="USER_ID")
    private User user;

    @ManyToOne
    @JoinColumn(name="SORSOLAS_ID")
    private Sorsolas sorsolas;

    @ManyToOne
    @JoinColumn(name="CUSTOM_GAME_ID")
    private CustomGame customGame;

    @Column(name="ATTENDANCE")
    private Integer attendance;

    @Column(name="X", length=255)
    private Integer xCordinate;

    @Column(name="Y", length=255)
    private Integer yCordinate;

    public GamePlan() {
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Sorsolas getSorsolas() {
        return sorsolas;
    }

    public void setSorsolas(Sorsolas sorsolas) {
        this.sorsolas = sorsolas;
    }

    public Integer getxCordinate() {
        return xCordinate;
    }

    public void setxCordinate(Integer xCordinate) {
        this.xCordinate = xCordinate;
    }

    public Integer getyCordinate() {
        return yCordinate;
    }

    public void setyCordinate(Integer yCordinate) {
        this.yCordinate = yCordinate;
    }

    public CustomGame getCustomGame() {
        return customGame;
    }

    public void setCustomGame(CustomGame customGame) {
        this.customGame = customGame;
    }

    public Integer getAttendance() {
        return attendance;
    }

    public void setAttendance(Integer attendance) {
        this.attendance = attendance;
    }
}
