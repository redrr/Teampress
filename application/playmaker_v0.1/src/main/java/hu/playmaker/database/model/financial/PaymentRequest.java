package hu.playmaker.database.model.financial;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;

import javax.persistence.*;
import java.util.Objects;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="PAYMENT_REQUEST", schema="teampress")
@NamedQueries({
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

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="COMPLETED", length=255)
	private Boolean completed;

	@Column(name="AMOUNT", length=255)
	private Integer amount;

	@Column(name="DELETED", length=255)
	private Boolean deleted;

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
}
