package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="TRAINERRATINGRESULT", schema="teampress")
@NamedQueries({
        @NamedQuery(name="TrainerRatingResult.findAll", query="SELECT u FROM TrainerRatingResult u"),
        @NamedQuery(name="TrainerRatingResult.findById", query="SELECT u FROM TrainerRatingResult u WHERE u.id = :pid"),
        @NamedQuery(name="TrainerRatingResult.findMaxByOrg", query="SELECT u FROM TrainerRatingResult u WHERE u.organization = :porg ORDER BY u.creationDate ASC"),
        @NamedQuery(name="TrainerRatingResult.findMinByOrg", query="SELECT u FROM TrainerRatingResult u WHERE u.organization = :porg ORDER BY u.creationDate DESC"),
        @NamedQuery(name="TrainerRatingResult.findAvgByTrainer", query="SELECT avg (u.result) FROM TrainerRatingResult u WHERE u.organization = :porg AND u.trainer = :pu AND u.ratingDate BETWEEN :pd1 AND :pd2"),
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
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
}
