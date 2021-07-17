package com.teampress.database.model.trainingplan;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name="TRAININGPLAN_CONNECTION", schema="teampress")
@Cacheable(value = false)
@NoArgsConstructor
@Getter
@Setter
public class TrainingPlanConnection extends BaseModel {

    @ManyToOne
    @JoinColumn(name="TRAININGPLAN_ID")
    private TrainingPlan trainingPlan;

    @ManyToOne
    @JoinColumn(name="EXERCISE_ID")
    private Exercise exercise;

    @Column(name = "DURATION")
    private Integer duration;

    @Column(name = "SORT")
    private Integer sort;
}
