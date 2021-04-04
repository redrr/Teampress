package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="TRAINERRATINGRESULT", schema="teampress")
@NamedQueries({
        @NamedQuery(name="TrainerRatingResult.findAll", query="SELECT u FROM TrainerRatingResult u"),
        @NamedQuery(name="TrainerRatingResult.countAll", query="SELECT COUNT(u) FROM TrainerRatingResult u"),
        @NamedQuery(name="TrainerRatingResult.findById", query="SELECT u FROM TrainerRatingResult u WHERE u.id = :pid"),
        @NamedQuery(name="TrainerRatingResult.findMaxByOrg", query="SELECT u FROM TrainerRatingResult u WHERE u.organization = :porg ORDER BY u.creationDate ASC"),
        @NamedQuery(name="TrainerRatingResult.findMinByOrg", query="SELECT u FROM TrainerRatingResult u WHERE u.organization = :porg ORDER BY u.creationDate DESC"),
        @NamedQuery(name="TrainerRatingResult.findAvgByTrainer", query="SELECT avg (u.result) FROM TrainerRatingResult u WHERE u.organization = :porg AND u.trainer = :pu AND u.ratingDate BETWEEN :pd1 AND :pd2"),
})
@Cacheable(false)
public class TrainerRatingResult extends BaseModel {
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
    @JoinColumn(name="TRAINER_ID", nullable=false)
    private User trainer;

    @Column(name="RESULT", length=255)
    private Integer result;

    @Column(name="RATING_DATE", length=255)
    private Date ratingDate;

    public TrainerRatingResult() {
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

    public User getTrainer() {
        return trainer;
    }

    public void setTrainer(User trainer) {
        this.trainer = trainer;
    }

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }

    public Date getRatingDate() {
        return ratingDate;
    }

    public void setRatingDate(Date ratingDate) {
        this.ratingDate = ratingDate;
    }
}
