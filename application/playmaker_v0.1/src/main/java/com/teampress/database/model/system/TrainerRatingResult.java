package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name="TRAINERRATINGRESULT", schema="teampress")
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
