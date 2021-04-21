package com.teampress.database.model.trainingplan;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * The persistent class for the EXCEPTION database table.
 * 
 */
@Entity
@Table(name="TRAININGPLAN", schema="teampress")
@NamedQueries({
		@NamedQuery(name="TrainingPlan.findAll", query="SELECT e FROM TrainingPlan e"),
        @NamedQuery(name="TrainingPlan.countAll", query="SELECT COUNT(e) FROM TrainingPlan e"),
		@NamedQuery(name="TrainingPlan.findById", query="SELECT exc FROM TrainingPlan exc WHERE exc.id = :pid"),
		@NamedQuery(name="TrainingPlan.findByUnique", query="SELECT exc FROM TrainingPlan exc WHERE exc.team = :pt AND exc.organization = :po AND exc.trainingDate = :pd"),
		@NamedQuery(name="TrainingPlan.findByTeam", query="SELECT exc FROM TrainingPlan exc WHERE exc.team = :pteam AND exc.organization = :porg"),
		@NamedQuery(name="TrainingPlan.findNextTraining", query="SELECT t FROM TrainingPlan t WHERE t.team = :pteam AND t.organization = :porg AND t.trainingDate > :pdate ORDER BY t.trainingDate DESC "),
		@NamedQuery(name="TrainingPlan.findByOrg", query="SELECT exc FROM TrainingPlan exc WHERE exc.organization = :porg"),
		@NamedQuery(name="TrainingPlan.findCount", query="SELECT count(u) FROM TrainingPlan u WHERE u.createdBy = :pu AND u.organization = :porg AND u.trainingDate BETWEEN :pd1 AND :pd2"),
		@NamedQuery(name="TrainingPlan.findMaxByOrg", query="SELECT u FROM TrainingPlan u WHERE u.organization = :porg ORDER BY u.creationDate ASC"),
		@NamedQuery(name="TrainingPlan.findMinByOrg", query="SELECT u FROM TrainingPlan u WHERE u.organization = :porg ORDER BY u.creationDate DESC"),
		@NamedQuery(name="TrainingPlan.findAllCreatedBy", query="SELECT exc FROM TrainingPlan exc WHERE exc.createdBy = :pusername")
})
public class TrainingPlan extends BaseModel {

	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORGANIZATION_ID", nullable=false)
	private Organization organization;

	@ManyToOne
	@JoinColumn(name="TEAM_ID", nullable = false)
	private LookupCode team;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="TRAINING_DATE", nullable=false)
	@CreatedDate
	private Date trainingDate;

	@Column(name = "UUID")
	private String uuid;

	@Column(name = "DELETABLE")
	private boolean deletable = true;

	public TrainingPlan() {
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public String getTrainingDate() {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd. ' - ' HH:mm");
		String parsedDate = dateFormat.format(trainingDate);
		return parsedDate;
	}

	public Date getRealTrainingDate() {
		return this.trainingDate;
	}

	public void setTrainingDate(String trainingDate) {
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd/HH:mm");
			Date parsedDate = dateFormat.parse(trainingDate);
			this.trainingDate = parsedDate;
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	public LookupCode getTeam() {
		return team;
	}

	public void setTeam(LookupCode team) {
		this.team = team;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public boolean isDeletable() {
		return deletable;
	}

	public void setDeletable(boolean deletable) {
		this.deletable = deletable;
	}
}
