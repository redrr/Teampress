package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;


/**
 * The persistent class for the PRIVILEGE database table.
 * 
 */
@Entity
@Table(name="PRIVILEGE", schema="probe")
@NamedQueries({
		@NamedQuery(name="Privilege.findAll", query="SELECT p FROM Privilege p"),
		@NamedQuery(name="Privilege.countAll", query = "SELECT COUNT(p) FROM Privilege p"),
		@NamedQuery(name="Privilege.findById", query="SELECT priv FROM Privilege priv WHERE priv.id = :pid"),
		@NamedQuery(name="Privilege.findByName", query="SELECT priv FROM Privilege priv WHERE priv.name = :pname")
})
@Cacheable(false)
public class Privilege extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="NAME", nullable=false, length=100)
	private String name;

	@Column(name="DESCRIPTION", length=200)
	private String description;

	//bi-directional many-to-one association to RolePrivilege
	@OneToMany(mappedBy="privilege")
	private Set<RolePrivilege> rolePrivileges;

	public Privilege() {
	}

	public Privilege(boolean deletable) {

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
		rolePrivilege.setPrivilege(this);

		return rolePrivilege;
	}

	public RolePrivilege removeRolePrivilege(RolePrivilege rolePrivilege) {
		getRolePrivileges().remove(rolePrivilege);
		rolePrivilege.setPrivilege(null);

		return rolePrivilege;
	}

	public boolean isDeletable() {
		return false;
	}

	public void setDeletable(boolean deletable) {

	}
	//endregion

	@Override
	public String innerToDisplay() {
	    return getId() + "- " + name;
	}
}