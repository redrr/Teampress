package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;


/**
 * The persistent class for the ROLE database table.
 * 
 */
@Entity
@Table(name="ROLE", schema="probe")
@NamedQueries({
		@NamedQuery(name="Role.findAll", query="SELECT r FROM Role r"),
		@NamedQuery(name="Role.countAll", query = "SELECT COUNT(r) FROM Role r"),
		@NamedQuery(name="Role.findById", query = "SELECT r FROM Role r WHERE r.id = :pid"),
		@NamedQuery(name="Role.findByName", query="SELECT r FROM Role r WHERE r.name = :pname")
})
@Cacheable(false)
public class Role extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="NAME", length=100)
	private String name;

	@Column(name="DESCRIPTION", length=200)
	private String description;

	@Column(name="DELETABLE")
	private boolean deletable;

	//bi-directional many-to-one association to RolePrivilege
	@OneToMany(mappedBy="role")
	private Set<RolePrivilege> rolePrivileges;

	//bi-directional many-to-one association to UserRole
	@OneToMany(mappedBy="role")
	private Set<UserRole> userRoles;

	public Role() {
	}

	//region [Region] Get Setters

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<RolePrivilege> getRolePrivileges() {
		if (Objects.isNull(rolePrivileges)) rolePrivileges = new HashSet<>();
		return this.rolePrivileges;
	}

	public void setRolePrivileges(Set<RolePrivilege> rolePrivileges) {
		this.rolePrivileges = rolePrivileges;
	}

	public RolePrivilege addRolePrivilege(RolePrivilege rolePrivilege) {
		getRolePrivileges().add(rolePrivilege);
		rolePrivilege.setRole(this);

		return rolePrivilege;
	}

	public RolePrivilege removeRolePrivilege(RolePrivilege rolePrivilege) {
		getRolePrivileges().remove(rolePrivilege);
		rolePrivilege.setRole(null);

		return rolePrivilege;
	}

	public Set<UserRole> getUserRoles() {
		if (Objects.isNull(userRoles)) userRoles = new HashSet<>();
		return this.userRoles;
	}

	public void setUserRoles(Set<UserRole> userRoles) {
		this.userRoles = userRoles;
	}

	public UserRole addUserRole(UserRole userRole) {
		getUserRoles().add(userRole);
		userRole.setRole(this);

		return userRole;
	}

	public UserRole removeUserRole(UserRole userRole) {
		getUserRoles().remove(userRole);
		userRole.setRole(null);

		return userRole;
	}

	public boolean isDeletable() {
		return deletable;
	}

	public void setDeletable(boolean deletable) {
		this.deletable = deletable;
	}

	//endregion

	@Override
	public String innerToDisplay() {
	    return name;
	}

}