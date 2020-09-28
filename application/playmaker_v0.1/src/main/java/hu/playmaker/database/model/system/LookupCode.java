package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;


/**
 * The persistent class for the LOOKUP_CODE database table.
 *
 */
@Entity
@Table(name="LOOKUP_CODE", schema="probe")
@NamedQueries({
		@NamedQuery(name="LookupCode.findAll", query="SELECT l FROM LookupCode l"),
		@NamedQuery(name="LookupCode.countAll", query="SELECT COUNT(l) FROM LookupCode l"),
		@NamedQuery(name="LookupCode.findById", query="SELECT l FROM LookupCode l where l.id = :pid"),
		@NamedQuery(name="LookupCode.findAllByLgroup", query = "SELECT l FROM LookupCode l WHERE l.lgroup = :plgroup"),
		@NamedQuery(name="LookupCode.findByCodeAndLgroup", query = "SELECT l FROM LookupCode l WHERE l.code = :pcode AND l.lgroup = :plgroup")
})
@Cacheable(false)
public class LookupCode extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="LGROUP", nullable=false, length=255)
	private String lgroup;

	@Column(name="CODE", nullable=false, length=255)
	private String code;

	@Column(name="DESCRIPTION", length=255)
	private String description;

	public LookupCode() {
	}

	//region [Region] Get Setters

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLgroup() {
		return this.lgroup;
	}

	public void setLgroup(String lgroup) {
		this.lgroup = lgroup;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}
    //endregion
}
