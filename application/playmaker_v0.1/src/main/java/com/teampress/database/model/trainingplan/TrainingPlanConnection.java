package com.teampress.database.model.trainingplan;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name="TRAININGPLAN_CONNECTION", schema="teampress")
@NamedQueries({
        @NamedQuery(name="TrainingPlanConnection.findAll", query="SELECT t FROM TrainingPlanConnection t"),
        @NamedQuery(name="TrainingPlanConnection.findById", query="SELECT t FROM TrainingPlanConnection t WHERE t.id = :pid"),
        @NamedQuery(name="TrainingPlanConnection.findByTraining", query="SELECT t FROM TrainingPlanConnection t WHERE t.trainingPlan = :pt ORDER BY t.sort ASC"),
        @NamedQuery(name="TrainingPlanConnection.findNextTraining", query="SELECT t FROM TrainingPlanConnection t WHERE t.trainingPlan.team = :pteam AND t.trainingPlan.organization = :porg AND t.trainingPlan.trainingDate > :pdate ORDER BY t.trainingPlan.trainingDate DESC"),
        @NamedQuery(name="TrainingPlanConnection.findCount", query="SELECT count(t) FROM TrainingPlanConnection t WHERE t.createdBy = :pu AND t.trainingPlan.organization = :porg AND t.trainingPlan.trainingDate BETWEEN :pd1 AND :pd2"),
})
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
