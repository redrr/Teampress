package com.teampress.database.model.financial;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Objects;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="ANNUAL_PAYMENT", schema="teampress")
@NamedQueries({
		@NamedQuery(name="AnnualPayment.findById", query="SELECT p FROM AnnualPayment p WHERE p.id = :pid"),
		@NamedQuery(name="AnnualPayment.findByDay", query="SELECT p FROM AnnualPayment p WHERE p.day = :pd AND p.deleted=false"),
		@NamedQuery(name="AnnualPayment.findAll", query="SELECT p FROM AnnualPayment p WHERE p.deleted=false"),
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class AnnualPayment extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID")
	private Organization organization;

	@ManyToOne
	@JoinColumn(name="TEAM_ID")
	private LookupCode team;

	@ManyToOne
	@JoinColumn(name="INCOME_GROUP_ID")
	private IncomeGroup group;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="AMOUNT", length=255)
	private Integer amount;

	@Column(name="DAY", length=255)
	private Integer day;

	@Column(name="DELETED", length=255)
	private Boolean deleted = false;
}
