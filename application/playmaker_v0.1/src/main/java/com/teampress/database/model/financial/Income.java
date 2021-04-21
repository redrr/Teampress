package com.teampress.database.model.financial;

import com.teampress.database.model.BaseModel;
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
@Table(name="INCOME", schema="teampress")
@NamedQueries({
		@NamedQuery(name="Income.findAll", query="SELECT p FROM Income p WHERE p.deleted=false"),
		@NamedQuery(name="Income.findById", query="SELECT p FROM Income p WHERE p.id = :pid AND p.deleted=false"),
		@NamedQuery(name="Income.findByUUID", query="SELECT p FROM Income p WHERE p.uuid = :pid AND p.deleted=false"),
		@NamedQuery(name="Income.findByOrg", query="SELECT p FROM Income p WHERE p.organization = :porg AND p.deleted=false"),
		@NamedQuery(name="Income.findByOrgAndNotAcceptedYet", query="SELECT p FROM Income p WHERE p.organization = :porg AND p.accept IS NULL AND p.deleted=false"),
		@NamedQuery(name="Income.findByOrgAndAccept", query="SELECT p FROM Income p WHERE p.organization = :porg AND p.accept = :pa AND p.deleted=false"),
		@NamedQuery(name="Income.findByOrgAcceptedDate", query="SELECT p FROM Income p WHERE p.organization = :porg AND p.accept = true AND p.deleted=false AND p.creationDate BETWEEN :pd1 AND :pd2"),
		@NamedQuery(name="Income.sumPrizeByDate", query="SELECT sum(p.prize) FROM Income p WHERE p.organization = :porg AND p.income = :pincome AND p.accept = true AND p.deleted=false AND p.creationDate BETWEEN :pd1 AND :pd2")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Income extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID")
	private Organization organization;

	@Column(name="UUID", length=255)
	private String uuid;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="INCOME", length=255)
	private boolean income;

	@Column(name="ACCEPTED", length=255)
	private Boolean accept;

	@Column(name="PRIZE", length=255)
	private Integer prize;

	@Column(name="DELETED", length=255)
	private Boolean deleted = false;
}
