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
		@NamedQuery(name="TrainingPlan.findByTeam", query="SELECT exc FROM TrainingPlan exc WHERE exc.team = :pteam AND exc.organization = :porg"),
		@NamedQuery(name="TrainingPlan.findNextTraining", query="SELECT t FROM TrainingPlan t WHERE t.team = :pteam AND t.organization = :porg AND t.trainingDate > :pdate ORDER BY t.trainingDate DESC "),
		@NamedQuery(name="TrainingPlan.findByOrg", query="SELECT exc FROM TrainingPlan exc WHERE exc.organization = :porg"),
		@NamedQuery(name="TrainingPlan.findCount", query="SELECT count(u) FROM TrainingPlan u WHERE u.createdBy = :pu AND u.organization = :porg AND u.creationDate BETWEEN :pd1 AND :pd2"),
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

	@ManyToOne
	@JoinColumn(name="EXERCISE_1_ID", nullable=true)
	private Exercise exercise1;

	@Column(name="EXERCISE_1_TIME_MIN")
	private Integer exercise1Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_2_ID", nullable=true)
	private Exercise exercise2;

	@Column(name="EXERCISE_2_TIME_MIN")
	private Integer exercise2Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_3_ID", nullable=true)
	private Exercise exercise3;

	@Column(name="EXERCISE_3_TIME_MIN")
	private Integer exercise3Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_4_ID", nullable=true)
	private Exercise exercise4;

	@Column(name="EXERCISE_4_TIME_MIN")
	private Integer exercise4Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_5_ID", nullable=true)
	private Exercise exercise5;

	@Column(name="EXERCISE_5_TIME_MIN")
	private Integer exercise5Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_6_ID", nullable=true)
	private Exercise exercise6;

	@Column(name="EXERCISE_6_TIME_MIN")
	private Integer exercise6Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_7_ID", nullable=true)
	private Exercise exercise7;

	@Column(name="EXERCISE_7_TIME_MIN")
	private Integer exercise7Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_8_ID", nullable=true)
	private Exercise exercise8;

	@Column(name="EXERCISE_8_TIME_MIN")
	private Integer exercise8Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_9_ID", nullable=true)
	private Exercise exercise9;

	@Column(name="EXERCISE_9_TIME_MIN")
	private Integer exercise9Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_10_ID", nullable=true)
	private Exercise exercise10;

	@Column(name="EXERCISE_10_TIME_MIN")
	private Integer exercise10Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_11_ID", nullable=true)
	private Exercise exercise11;

	@Column(name="EXERCISE_11_TIME_MIN")
	private Integer exercise11Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_12_ID", nullable=true)
	private Exercise exercise12;

	@Column(name="EXERCISE_12_TIME_MIN")
	private Integer exercise12Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_13_ID", nullable=true)
	private Exercise exercise13;

	@Column(name="EXERCISE_13_TIME_MIN")
	private Integer exercise13Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_14_ID", nullable=true)
	private Exercise exercise14;

	@Column(name="EXERCISE_14_TIME_MIN")
	private Integer exercise14Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_15_ID", nullable=true)
	private Exercise exercise15;

	@Column(name="EXERCISE_15_TIME_MIN")
	private Integer exercise15Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_16_ID", nullable=true)
	private Exercise exercise16;

	@Column(name="EXERCISE_16_TIME_MIN")
	private Integer exercise16Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_17_ID", nullable=true)
	private Exercise exercise17;

	@Column(name="EXERCISE_17_TIME_MIN")
	private Integer exercise17Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_18_ID", nullable=true)
	private Exercise exercise18;

	@Column(name="EXERCISE_18_TIME_MIN")
	private Integer exercise18Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_19_ID", nullable=true)
	private Exercise exercise19;

	@Column(name="EXERCISE_19_TIME_MIN")
	private Integer exercise19Time;

	@ManyToOne
	@JoinColumn(name="EXERCISE_20_ID", nullable=true)
	private Exercise exercise20;

	@Column(name="EXERCISE_20_TIME_MIN")
	private Integer exercise20Time;

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

	public Exercise getExercise1() {
		return exercise1;
	}

	public void setExercise1(Exercise exercise1) {
		this.exercise1 = exercise1;
	}

	public Integer getExercise1Time() {
		return exercise1Time;
	}

	public void setExercise1Time(Integer exercise1Time) {
		this.exercise1Time = exercise1Time;
	}

	public Exercise getExercise2() {
		return exercise2;
	}

	public void setExercise2(Exercise exercise2) {
		this.exercise2 = exercise2;
	}

	public Integer getExercise2Time() {
		return exercise2Time;
	}

	public void setExercise2Time(Integer exercise2Time) {
		this.exercise2Time = exercise2Time;
	}

	public Exercise getExercise3() {
		return exercise3;
	}

	public void setExercise3(Exercise exercise3) {
		this.exercise3 = exercise3;
	}

	public Integer getExercise3Time() {
		return exercise3Time;
	}

	public void setExercise3Time(Integer exercise3Time) {
		this.exercise3Time = exercise3Time;
	}

	public Exercise getExercise4() {
		return exercise4;
	}

	public void setExercise4(Exercise exercise4) {
		this.exercise4 = exercise4;
	}

	public Integer getExercise4Time() {
		return exercise4Time;
	}

	public void setExercise4Time(Integer exercise4Time) {
		this.exercise4Time = exercise4Time;
	}

	public Exercise getExercise5() {
		return exercise5;
	}

	public void setExercise5(Exercise exercise5) {
		this.exercise5 = exercise5;
	}

	public Integer getExercise5Time() {
		return exercise5Time;
	}

	public void setExercise5Time(Integer exercise5Time) {
		this.exercise5Time = exercise5Time;
	}

	public Exercise getExercise6() {
		return exercise6;
	}

	public void setExercise6(Exercise exercise6) {
		this.exercise6 = exercise6;
	}

	public Integer getExercise6Time() {
		return exercise6Time;
	}

	public void setExercise6Time(Integer exercise6Time) {
		this.exercise6Time = exercise6Time;
	}

	public Exercise getExercise7() {
		return exercise7;
	}

	public void setExercise7(Exercise exercise7) {
		this.exercise7 = exercise7;
	}

	public Integer getExercise7Time() {
		return exercise7Time;
	}

	public void setExercise7Time(Integer exercise7Time) {
		this.exercise7Time = exercise7Time;
	}

	public Exercise getExercise8() {
		return exercise8;
	}

	public void setExercise8(Exercise exercise8) {
		this.exercise8 = exercise8;
	}

	public Integer getExercise8Time() {
		return exercise8Time;
	}

	public void setExercise8Time(Integer exercise8Time) {
		this.exercise8Time = exercise8Time;
	}

	public Exercise getExercise9() {
		return exercise9;
	}

	public void setExercise9(Exercise exercise9) {
		this.exercise9 = exercise9;
	}

	public Integer getExercise9Time() {
		return exercise9Time;
	}

	public void setExercise9Time(Integer exercise9Time) {
		this.exercise9Time = exercise9Time;
	}

	public Exercise getExercise10() {
		return exercise10;
	}

	public void setExercise10(Exercise exercise10) {
		this.exercise10 = exercise10;
	}

	public Integer getExercise10Time() {
		return exercise10Time;
	}

	public void setExercise10Time(Integer exercise10Time) {
		this.exercise10Time = exercise10Time;
	}

	public Exercise getExercise11() {
		return exercise11;
	}

	public void setExercise11(Exercise exercise11) {
		this.exercise11 = exercise11;
	}

	public Integer getExercise11Time() {
		return exercise11Time;
	}

	public void setExercise11Time(Integer exercise11Time) {
		this.exercise11Time = exercise11Time;
	}

	public Exercise getExercise12() {
		return exercise12;
	}

	public void setExercise12(Exercise exercise12) {
		this.exercise12 = exercise12;
	}

	public Integer getExercise12Time() {
		return exercise12Time;
	}

	public void setExercise12Time(Integer exercise12Time) {
		this.exercise12Time = exercise12Time;
	}

	public Exercise getExercise13() {
		return exercise13;
	}

	public void setExercise13(Exercise exercise13) {
		this.exercise13 = exercise13;
	}

	public Integer getExercise13Time() {
		return exercise13Time;
	}

	public void setExercise13Time(Integer exercise13Time) {
		this.exercise13Time = exercise13Time;
	}

	public Exercise getExercise14() {
		return exercise14;
	}

	public void setExercise14(Exercise exercise14) {
		this.exercise14 = exercise14;
	}

	public Integer getExercise14Time() {
		return exercise14Time;
	}

	public void setExercise14Time(Integer exercise14Time) {
		this.exercise14Time = exercise14Time;
	}

	public Exercise getExercise15() {
		return exercise15;
	}

	public void setExercise15(Exercise exercise15) {
		this.exercise15 = exercise15;
	}

	public Integer getExercise15Time() {
		return exercise15Time;
	}

	public void setExercise15Time(Integer exercise15Time) {
		this.exercise15Time = exercise15Time;
	}

	public Exercise getExercise16() {
		return exercise16;
	}

	public void setExercise16(Exercise exercise16) {
		this.exercise16 = exercise16;
	}

	public Integer getExercise16Time() {
		return exercise16Time;
	}

	public void setExercise16Time(Integer exercise16Time) {
		this.exercise16Time = exercise16Time;
	}

	public Exercise getExercise17() {
		return exercise17;
	}

	public void setExercise17(Exercise exercise17) {
		this.exercise17 = exercise17;
	}

	public Integer getExercise17Time() {
		return exercise17Time;
	}

	public void setExercise17Time(Integer exercise17Time) {
		this.exercise17Time = exercise17Time;
	}

	public Exercise getExercise18() {
		return exercise18;
	}

	public void setExercise18(Exercise exercise18) {
		this.exercise18 = exercise18;
	}

	public Integer getExercise18Time() {
		return exercise18Time;
	}

	public void setExercise18Time(Integer exercise18Time) {
		this.exercise18Time = exercise18Time;
	}

	public Exercise getExercise19() {
		return exercise19;
	}

	public void setExercise19(Exercise exercise19) {
		this.exercise19 = exercise19;
	}

	public Integer getExercise19Time() {
		return exercise19Time;
	}

	public void setExercise19Time(Integer exercise19Time) {
		this.exercise19Time = exercise19Time;
	}

	public Exercise getExercise20() {
		return exercise20;
	}

	public void setExercise20(Exercise exercise20) {
		this.exercise20 = exercise20;
	}

	public Integer getExercise20Time() {
		return exercise20Time;
	}

	public void setExercise20Time(Integer exercise20Time) {
		this.exercise20Time = exercise20Time;
	}




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
}