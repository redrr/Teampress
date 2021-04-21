package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;


/**
 * The persistent class for the USER_ORGANIZATION database table.
 * 
 */
@Entity
@Table(name="USERCLUB", schema="teampress")
@NamedQueries({
		@NamedQuery(name="UserOrganization.findAll", query="SELECT u FROM UserOrganization u"),
		@NamedQuery(name="UserOrganization.findById", query="SELECT u FROM UserOrganization u WHERE u.id = :pid"),
		@NamedQuery(name="UserOrganization.findByUser", query="SELECT u FROM UserOrganization u WHERE u.user = :pu"),
		@NamedQuery(name="UserOrganization.findByOrganization", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg"),
		@NamedQuery(name="UserOrganization.findByOrganizationAndTeam", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg AND u.type = :ptype"),
		@NamedQuery(name="UserOrganization.findByOrgAndUser", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg AND u.user = :pu"),
		@NamedQuery(name="UserOrganization.findByOrgAndTeam", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg AND u.type = :pteam"),
		@NamedQuery(name="UserOrganization.findUsersByOrgAndTeams", query="SELECT distinct u.user FROM UserOrganization u WHERE u.organization = :porg AND u.type IN :pteams"),
		@NamedQuery(name="UserOrganization.findByOrgAndTeamAndUser", query="SELECT u FROM UserOrganization u WHERE u.organization = :porg AND u.type = :pteam AND u.user = :pu")
})
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
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
}
