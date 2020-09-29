package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;

@Entity
@Table(name="TRAINERRATING", schema="teampress")
@NamedQueries({
        @NamedQuery(name="TrainerRating.findAll", query="SELECT u FROM TrainerRating u"),
        @NamedQuery(name="TrainerRating.countAll", query="SELECT COUNT(u) FROM TrainerRating u"),
        @NamedQuery(name="TrainerRating.findById", query="SELECT u FROM TrainerRating u WHERE u.id = :pid"),
        @NamedQuery(name="TrainerRating.findByNull", query="SELECT u FROM TrainerRating u WHERE u.organization = :porg AND u.done IS NULL"),
        @NamedQuery(name="TrainerRating.findByUser", query="SELECT u FROM TrainerRating u WHERE u.user = :pu AND u.done IS NULL ORDER BY u.id DESC")
})
@Cacheable(false)
public class TrainerRating extends BaseModel {
    private static final long serialVersionUID = 1L;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="ORG_ID", nullable=false)
    private Organization organization;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="TEAM_ID", nullable=false)
    private LookupCode team;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="USER_ID", nullable=false)
    private User user;

    @Column(name="DONE", length=255)
    private Boolean done;

    public TrainerRating() {
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

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }
}
