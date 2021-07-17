package com.teampress.database.model.workout;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;
import com.teampress.database.model.trainingplan.Exercise;
import com.teampress.database.model.trainingplan.TrainingPlan;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


/**
 * The persistent class for the USER_ORGANIZATION database table.
 * 
 */
@Entity
@Table(name="WORKOUT", schema="teampress")
@NamedQueries({
		@NamedQuery(name="Workout.findAll", query="SELECT u FROM Workout u"),
		@NamedQuery(name="Workout.findSum", query="SELECT sum(u.resultPercent) FROM Workout u WHERE u.resultPercent IS NOT NULL AND u.user = :puser AND u.creationDate BETWEEN :pd1 AND :pd2"),
		@NamedQuery(name="Workout.findCount", query="SELECT count(u) FROM Workout u WHERE u.resultPercent IS NOT NULL AND u.user = :puser AND u.creationDate BETWEEN :pd1 AND :pd2"),
		@NamedQuery(name="Workout.findSumByTrainer", query="SELECT count(u) FROM Workout u WHERE u.creationDate BETWEEN :pd1 AND :pd2"),
		@NamedQuery(name="Workout.findMaxByTeam", query="SELECT u FROM Workout u WHERE u.team = :pteam ORDER BY u.creationDate ASC"),
		@NamedQuery(name="Workout.findMinByTeam", query="SELECT u FROM Workout u WHERE u.team = :pteam ORDER BY u.creationDate DESC"),
		@NamedQuery(name="Workout.findMaxByOrg", query="SELECT u FROM Workout u WHERE u.organization = :porg ORDER BY u.creationDate ASC"),
		@NamedQuery(name="Workout.findMinByOrg", query="SELECT u FROM Workout u WHERE u.organization = :porg ORDER BY u.creationDate DESC"),
		@NamedQuery(name="Workout.findByUser", query="SELECT u FROM Workout u WHERE u.user = :pu GROUP BY u.trainingPlan ORDER BY u.creationDate DESC"),
		@NamedQuery(name="Workout.findByUserAndTraining", query="SELECT u FROM Workout u WHERE u.user = :puser AND u.trainingPlan = :ptraining"),
		@NamedQuery(name="Workout.findByExerciseAndTraining", query="SELECT u FROM Workout u WHERE u.exercise = :pex AND u.trainingPlan = :ptraining"),
		@NamedQuery(name="Workout.findByTraining", query="SELECT u FROM Workout u WHERE u.trainingPlan = :ptraining")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Workout extends BaseModel {
	private static final long serialVersionUID = 1L;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="ORG_ID", nullable=false)
	private Organization organization;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="TEAM_ID", nullable=false)
	private LookupCode team;

	//bi-directional many-to-one association to Organization
	@ManyToOne
	@JoinColumn(name="TRAINING_ID", nullable=false)
	private TrainingPlan trainingPlan;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USER_ID", nullable=false)
	private User user;

	//bi-directional many-to-one association to LookupCode
	@ManyToOne
	@JoinColumn(name="EXERCISE_ID", nullable=false)
	private Exercise exercise;

	@Column(name="RESULT")
	private String result;

	@Column(name="PERCENT")
	private Integer resultPercent;
}
