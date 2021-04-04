package com.teampress.database.model.financial;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.Organization;
import com.teampress.database.model.system.User;

import javax.persistence.*;
import java.util.Objects;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="PAYMENT_REQUEST", schema="teampress")
@NamedQueries({
		@NamedQuery(name="PaymentRequest.findById", query="SELECT p FROM PaymentRequest p WHERE p.id = :pid"),
		@NamedQuery(name="PaymentRequest.collectByUUID", query="SELECT p FROM PaymentRequest p WHERE p.deleted = false AND p.completed = false GROUP BY p.uuid"),
		@NamedQuery(name="PaymentRequest.findByOrgAndUser", query="SELECT p FROM PaymentRequest p WHERE p.organization = :porg AND p.user = :pu AND p.deleted=false"),
		@NamedQuery(name="PaymentRequest.findByCreator", query="SELECT p FROM PaymentRequest p WHERE p.organization = :porg AND p.createdBy = :pn"),
})
@Cacheable(false)
public class PaymentRequest extends BaseModel {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name="ORG_ID")
	private Organization organization;

	@ManyToOne
	@JoinColumn(name="USER_ID")
	private User user;

	@ManyToOne
	@JoinColumn(name="INCOME_GROUP_ID")
	private IncomeGroup group;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="UUID", length=255)
	private String uuid;

	@Column(name="COMPLETED", length=255)
	private Boolean completed = false;

	@Column(name="AMOUNT", length=255)
	private Integer amount;

	@Column(name="DELETED", length=255)
	private Boolean deleted = false;

	public PaymentRequest() {
	}

	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getDeleted() {
		return deleted;
	}

	public void setDeleted(Boolean deleted) {
		this.deleted = (Objects.isNull(deleted)) ? false : deleted;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Boolean getCompleted() {
		return completed;
	}

	public void setCompleted(Boolean completed) {
		this.completed = completed;
	}

	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public IncomeGroup getGroup() {
		return group;
	}

	public void setGroup(IncomeGroup group) {
		this.group = group;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
}