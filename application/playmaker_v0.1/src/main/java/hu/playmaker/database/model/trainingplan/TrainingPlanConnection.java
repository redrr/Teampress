package hu.playmaker.database.model.trainingplan;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;

@Entity
@Table(name="TRAININGPLAN_CONNECTION", schema="teampress")
@NamedQueries({
        @NamedQuery(name="TrainingPlanConnection.findAll", query="SELECT t FROM TrainingPlanConnection t"),
        @NamedQuery(name="TrainingPlanConnection.findById", query="SELECT t FROM TrainingPlanConnection t WHERE t.id = :pid"),
        @NamedQuery(name="TrainingPlanConnection.findByTraining", query="SELECT t FROM TrainingPlanConnection t WHERE t.trainingPlan = :pt ORDER BY t.sort ASC"),
        @NamedQuery(name="TrainingPlanConnection.findByTeam", query="SELECT t FROM TrainingPlanConnection t WHERE t.trainingPlan.team = :pteam AND t.trainingPlan.organization = :porg"),
        @NamedQuery(name="TrainingPlanConnection.findNextTraining", query="SELECT t FROM TrainingPlanConnection t WHERE t.trainingPlan.team = :pteam AND t.trainingPlan.organization = :porg AND t.trainingPlan.trainingDate > :pdate ORDER BY t.trainingPlan.trainingDate DESC"),
        @NamedQuery(name="TrainingPlanConnection.findByOrg", query="SELECT t FROM TrainingPlanConnection t WHERE t.trainingPlan.organization = :porg"),
        @NamedQuery(name="TrainingPlanConnection.findCount", query="SELECT count(t) FROM TrainingPlanConnection t WHERE t.createdBy = :pu AND t.trainingPlan.organization = :porg AND t.trainingPlan.trainingDate BETWEEN :pd1 AND :pd2"),
        @NamedQuery(name="TrainingPlanConnection.findMaxByOrg", query="SELECT t FROM TrainingPlanConnection t WHERE t.trainingPlan.organization = :porg ORDER BY t.creationDate ASC"),
        @NamedQuery(name="TrainingPlanConnection.findMinByOrg", query="SELECT t FROM TrainingPlanConnection t WHERE t.trainingPlan.organization = :porg ORDER BY t.creationDate DESC")
})
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

    public TrainingPlanConnection() {
    }

    public TrainingPlan getTrainingPlan() {
        return trainingPlan;
    }

    public void setTrainingPlan(TrainingPlan trainingPlan) {
        this.trainingPlan = trainingPlan;
    }

    public Exercise getExercise() {
        return exercise;
    }

    public void setExercise(Exercise exercise) {
        this.exercise = exercise;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }
}
