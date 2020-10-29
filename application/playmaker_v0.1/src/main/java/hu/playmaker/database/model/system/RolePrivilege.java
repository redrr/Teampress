package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;


/**
 * The persistent class for the ROLE_PRIVILEGES database table.
 * 
 */
@Entity
@Table(name="ROLEPERMISSION", schema="teampress")
@NamedQueries({
		@NamedQuery(name="RolePrivilege.findAll", query="SELECT rp FROM RolePrivilege rp"),
		@NamedQuery(name="RolePrivilege.countAll", query = "SELECT COUNT(rp) FROM RolePrivilege rp"),
		@NamedQuery(name="RolePrivilege.findById", query="SELECT rp FROM RolePrivilege rp WHERE rp.id = :pid"),
		@NamedQuery(name="RolePrivilege.findAllByRoleId", query="SELECT rp FROM RolePrivilege rp WHERE  rp.role.id = :proleid"),
		@NamedQuery(name="RolePrivilege.findByRoleIdAndPrivilegeId", query = "SELECT rp FROM RolePrivilege rp WHERE rp.role.id = :proleid AND rp.privilege.id = :pprivilegeid"),
})
@Cacheable(false)
public class RolePrivilege extends BaseModel {
	private static final long serialVersionUID = 1L;

	//bi-directional many-to-one association to Privilege
	@ManyToOne
	@JoinColumn(name="PRIVILEGE_ID", nullable=false)
	private Privilege privilege;

	//bi-directional many-to-one association to Role
	@ManyToOne
	@JoinColumn(name="ROLE_ID", nullable=false)
	private Role role;

	public RolePrivilege() {
	}

	//region [Region] Get Setters

	public Privilege getPrivilege() {
		return this.privilege;
	}

	public void setPrivilege(Privilege privilege) {
		this.privilege = privilege;
	}

	public Role getRole() {
		return this.role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	//endregion
}