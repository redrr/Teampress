package hu.playmaker.database.model.workout;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;
import hu.playmaker.database.model.trainingplan.TrainingPlan;

import javax.persistence.*;


/**
 * The persistent class for the USER_ORGANIZATION database table.
 * 
 */
@Entity
@Table(name="JELEN", schema="probe")
@NamedQueries({
		@NamedQuery(name="Jelenlet.findAll", query="SELECT u FROM Jelenlet u"),
		@NamedQuery(name="Jelenlet.countAll", query="SELECT COUNT(u) FROM Jelenlet u"),
		@NamedQuery(name="Jelenlet.findById", query="SELECT u FROM Jelenlet u WHERE u.id = :pid"),
		@NamedQuery(name="Jelenlet.findByUser", query="SELECT u FROM Jelenlet u WHERE u.user = :pu"),
		@NamedQuery(name="Jelenlet.findSum", query="SELECT count(u) FROM Jelenlet u WHERE u.user = :pu AND u.creationDate BETWEEN :pd1 AND :pd2"),
		@NamedQuery(name="Jelenlet.findCount", query="SELECT count(u) FROM Jelenlet u WHERE u.user = :pu AND u.jelen='jelen' AND u.creationDate BETWEEN :pd1 AND :pd2"),
		@NamedQuery(name="Jelenlet.findSumByTrainer", query="SELECT count(u) FROM Jelenlet u WHERE u.createdBy = :pu AND u.organization=:porg AND u.creationDate BETWEEN :pd1 AND :pd2"),
		@NamedQuery(name="Jelenlet.findCountByTrainer", query="SELECT count(u) FROM Jelenlet u WHERE u.createdBy = :pu AND u.organization=:porg AND u.jelen='jelen' AND u.creationDate BETWEEN :pd1 AND :pd2"),
		@NamedQuery(name="Jelenlet.findMaxByTeam", query="SELECT u FROM Jelenlet u WHERE u.team = :pteam ORDER BY u.creationDate ASC"),
		@NamedQuery(name="Jelenlet.findMinByTeam", query="SELECT u FROM Jelenlet u WHERE u.team = :pteam ORDER BY u.creationDate DESC"),
		@NamedQuery(name="Jelenlet.findMaxByOrg", query="SELECT u FROM Jelenlet u WHERE u.organization = :porg ORDER BY u.creationDate ASC"),
		@NamedQuery(name="Jelenlet.findMinByOrg", query="SELECT u FROM Jelenlet u WHERE u.organization = :porg ORDER BY u.creationDate DESC"),
		@NamedQuery(name="Jelenlet.findByUserLastFive", query="SELECT u FROM Jelenlet u WHERE u.user = :puser ORDER BY u.creationDate DESC"),
		@NamedQuery(name="Jelenlet.findByTraining", query="SELECT u FROM Jelenlet u WHERE u.trainingPlan = :ptraining"),
		@NamedQuery(name="Jelenlet.findByUserAndTraining", query="SELECT u FROM Jelenlet u WHERE u.user = :puser AND u.trainingPlan = :ptraining"),
		@NamedQuery(name="Jelenlet.findByDateAndTeam", query="SELECT u FROM Jelenlet u WHERE u.organization=:porg AND u.team=:pteam AND u.creationDate BETWEEN :pd1 AND :pd2"),
})
@Cacheable(false)
public class Jelenlet extends BaseModel {
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

	@Column(name="JELEN")
	private String jelen;

	public Jelenlet() {
	}

	//region [Region] Get Setters


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

	public TrainingPlan getTrainingPlan() {
		return trainingPlan;
	}

	public void setTrainingPlan(TrainingPlan trainingPlan) {
		this.trainingPlan = trainingPlan;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getJelen() {
		return jelen;
	}

	public void setJelen(String jelen) {
		this.jelen = jelen;
	}

//endregion

}