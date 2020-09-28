package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;


/**
 * The persistent class for the PARAMETERS database table.
 * 
 */
@Entity
@Table(name="PARAMETERS", schema="probe")
@NamedQueries({
		@NamedQuery(name="Parameter.findAll", query="SELECT p FROM Parameter p"),
		@NamedQuery(name="Parameter.countAll", query="SELECT COUNT(p) FROM Parameter p"),
		@NamedQuery(name="Parameter.findById", query="SELECT p FROM Parameter p WHERE p.id = :pid"),
		@NamedQuery(name="Parameter.findByGroupAndCode", query="SELECT p FROM Parameter p WHERE p.group = :pgroup AND p.code = :pcode"),
		@NamedQuery(name="Parameter.findByGroup", query="SELECT p FROM Parameter p WHERE p.group = :pgroup"),
})
@Cacheable(false)
public class Parameter extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="CODE", nullable=false, length=255)
	private String code;

	@Column(name="`GROUP`", nullable=false, length=255)
	private String group;

	@Column(name="VALUE", length=255)
	private String value;

	@Column(name="ATTR1", length=255)
	private String attr1;

	@Column(name="ATTR2", length=255)
	private String attr2;

	@Column(name="ATTR3", length=255)
	private String attr3;

	@Column(name="ATTR4", length=255)
	private String attr4;

	@Column(name="ATTR5", length=255)
	private String attr5;

	@Column
	private boolean deletable;

	public Parameter() {
	}

	//region [Region] Get Setters

	public String getAttr1() {
		return this.attr1;
	}

	public void setAttr1(String attr1) {
		this.attr1 = attr1;
	}

	public String getAttr2() {
		return this.attr2;
	}

	public void setAttr2(String attr2) {
		this.attr2 = attr2;
	}

	public String getAttr3() {
		return this.attr3;
	}

	public void setAttr3(String attr3) {
		this.attr3 = attr3;
	}

	public String getAttr4() {
		return this.attr4;
	}

	public void setAttr4(String attr4) {
		this.attr4 = attr4;
	}

	public String getAttr5() {
		return this.attr5;
	}

	public void setAttr5(String attr5) {
		this.attr5 = attr5;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getGroup() {
		return this.group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
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
	    return code;
	}
}