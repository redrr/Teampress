package hu.playmaker.database.model.trainingplan;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static java.util.Objects.isNull;


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

/*
	public String getStringForJs() {
		String split = ";";
		String dot = ",";
		return
				(isNull(getExercise1()) ? "" : getExercise1().getId()+dot+getExercise1().getType().getCode()+dot+getExercise1().getName()+split)+
				(isNull(getExercise2()) ? "" : getExercise2().getId()+dot+getExercise2().getType().getCode()+dot+getExercise2().getName()+split)+
				(isNull(getExercise3()) ? "" : getExercise3().getId()+dot+getExercise3().getType().getCode()+dot+getExercise3().getName()+split)+
				(isNull(getExercise4()) ? "" : getExercise4().getId()+dot+getExercise4().getType().getCode()+dot+getExercise4().getName()+split)+
				(isNull(getExercise5()) ? "" : getExercise5().getId()+dot+getExercise5().getType().getCode()+dot+getExercise5().getName()+split)+
				(isNull(getExercise6()) ? "" : getExercise6().getId()+dot+getExercise6().getType().getCode()+dot+getExercise6().getName()+split)+
				(isNull(getExercise7()) ? "" : getExercise7().getId()+dot+getExercise7().getType().getCode()+dot+getExercise7().getName()+split)+
				(isNull(getExercise8()) ? "" : getExercise8().getId()+dot+getExercise8().getType().getCode()+dot+getExercise8().getName()+split)+
				(isNull(getExercise9()) ? "" : getExercise9().getId()+dot+getExercise9().getType().getCode()+dot+getExercise9().getName()+split)+
				(isNull(getExercise10()) ? "" : getExercise10().getId()+dot+getExercise10().getType().getCode()+dot+getExercise10().getName()+split)+
				(isNull(getExercise11()) ? "" : getExercise11().getId()+dot+getExercise11().getType().getCode()+dot+getExercise11().getName()+split)+
				(isNull(getExercise12()) ? "" : getExercise12().getId()+dot+getExercise12().getType().getCode()+dot+getExercise12().getName()+split)+
				(isNull(getExercise13()) ? "" : getExercise13().getId()+dot+getExercise13().getType().getCode()+dot+getExercise13().getName()+split)+
				(isNull(getExercise14()) ? "" : getExercise14().getId()+dot+getExercise14().getType().getCode()+dot+getExercise14().getName()+split)+
				(isNull(getExercise15()) ? "" : getExercise15().getId()+dot+getExercise15().getType().getCode()+dot+getExercise15().getName()+split)+
				(isNull(getExercise16()) ? "" : getExercise16().getId()+dot+getExercise16().getType().getCode()+dot+getExercise16().getName()+split)+
				(isNull(getExercise17()) ? "" : getExercise17().getId()+dot+getExercise17().getType().getCode()+dot+getExercise17().getName()+split)+
				(isNull(getExercise18()) ? "" : getExercise18().getId()+dot+getExercise18().getType().getCode()+dot+getExercise18().getName()+split)+
				(isNull(getExercise19()) ? "" : getExercise19().getId()+dot+getExercise19().getType().getCode()+dot+getExercise19().getName()+split)+
				(isNull(getExercise20()) ? "" : getExercise20().getId()+dot+getExercise20().getType().getCode()+dot+getExercise20().getName());
	}

	public String getStringForWorkoutJs() {
		String split = ";";
		return
				(isNull(getExercise1()) ? "" : getExercise1().getName()+split)+
				(isNull(getExercise2()) ? "" : getExercise2().getName()+split)+
				(isNull(getExercise3()) ? "" : getExercise3().getName()+split)+
				(isNull(getExercise4()) ? "" : getExercise4().getName()+split)+
				(isNull(getExercise5()) ? "" : getExercise5().getName()+split)+
				(isNull(getExercise6()) ? "" : getExercise6().getName()+split)+
				(isNull(getExercise7()) ? "" : getExercise7().getName()+split)+
				(isNull(getExercise8()) ? "" : getExercise8().getName()+split)+
				(isNull(getExercise9()) ? "" : getExercise9().getName()+split)+
				(isNull(getExercise10()) ? "" : getExercise10().getName()+split)+
				(isNull(getExercise11()) ? "" : getExercise11().getName()+split)+
				(isNull(getExercise12()) ? "" : getExercise12().getName()+split)+
				(isNull(getExercise13()) ? "" : getExercise13().getName()+split)+
				(isNull(getExercise14()) ? "" : getExercise14().getName()+split)+
				(isNull(getExercise15()) ? "" : getExercise15().getName()+split)+
				(isNull(getExercise16()) ? "" : getExercise16().getName()+split)+
				(isNull(getExercise17()) ? "" : getExercise17().getName()+split)+
				(isNull(getExercise18()) ? "" : getExercise18().getName()+split)+
				(isNull(getExercise19()) ? "" : getExercise19().getName()+split)+
				(isNull(getExercise20()) ? "" : getExercise20().getName());
	}
 */
}
