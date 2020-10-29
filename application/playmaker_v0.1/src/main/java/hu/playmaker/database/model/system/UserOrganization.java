package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.databank.Liga;

import javax.persistence.*;


/**
 * The persistent class for the USER_ORGANIZATION database table.
 * 
 */
@Entity
@Table(name="USERCLUB", schema="teampress")
@NamedQueries({
		@NamedQuery(name="UserOrganization.findAll", query="SELECT u FROM UserOrganization u"),
		@NamedQuery(name="UserOrganization.countAll", query="SELECT COUNT(u) FROM UserOrganization u"),
		@NamedQuery(name="UserOrganization.findById", query="SELECT u FROM UserOrganization u WHERE u.id = :pid"),
		@NamedQuery(name="UserOrganization.findByUser", query="SELECT u FROM UserOrganization u WHERE u.user = :pu"),
		@NamedQuery(name="UserOrganization.findByOrganization", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg"),
		@NamedQuery(name="UserOrganization.findByOrganizationAndTeam", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg AND u.type = :ptype"),
		@NamedQuery(name="UserOrganization.findByOrgAndUser", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg AND u.user = :pu"),
		@NamedQuery(name="UserOrganization.findByOrgAndLiga", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg AND u.liga = :pliga"),
		@NamedQuery(name="UserOrganization.findByOrgAndTeam", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg AND u.type = :pteam")
})
@Cacheable(false)
public class UserOrganization extends BaseModel {
	private static final long serialVersionUID = 1L;

	//bi-directional many-to-one association to Organization
	@ManyToOne
	@JoinColumn(name="ORGANIZATION_ID", nullable=false)
	private Organization organization;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USER_ID", nullable=false)
	private User user;

	//bi-directional many-to-one association to LookupCode
	@ManyToOne
	@JoinColumn(name="TEAM_ID", nullable=false)
	private LookupCode type;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="LIGA_ID", nullable=false)
	private Liga liga;

	public UserOrganization() {
	}

	//region [Region] Get Setters

	public Organization getOrganization() {
		return this.organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public LookupCode getType() {
		return type;
	}

	public void setType(LookupCode type) {
		this.type = type;
	}

	public Liga getLiga() {
		return liga;
	}

	public void setLiga(Liga liga) {
		this.liga = liga;
	}

	//endregion
}