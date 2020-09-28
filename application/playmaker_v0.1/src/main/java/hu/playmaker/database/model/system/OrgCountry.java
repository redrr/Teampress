package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the ORG_COUNTRY database table.
 * 
 */
@Entity
@Table(name="ORG_COUNTRY", schema="probe")
@NamedQueries({
		@NamedQuery(name="OrgCountry.findAll", query="SELECT o FROM OrgCountry o"),
		@NamedQuery(name="OrgCountry.countAll", query = "SELECT COUNT(o) FROM OrgCountry o"),
		@NamedQuery(name="OrgCountry.findById", query="SELECT o FROM OrgCountry o WHERE o.id = :pid"),
		@NamedQuery(name="OrgCountry.findByOrganization", query = "SELECT o FROM OrgCountry o WHERE o.organization = :porg"),
        @NamedQuery(name="OrgCountry.findAllFilteredByOrganization", query = "SELECT o FROM OrgCountry o WHERE o.organization IN :porgs")
})
@Cacheable(false)
public class OrgCountry extends BaseModel {
	private static final long serialVersionUID = 1L;

	@Column(name="CITY", length=255)
	private String city;

	@Column(name="COUNTRY_CODE", length=255)
	private String country;

	@Column(name="NAME", length=255)
	private String name;

	@Column(name="POST_CODE", length=255)
	private String postCode;

	@Column(name="STREET", length=255)
	private String street;

	@Column(name="STREET2", length=255)
	private String street2;

	@Column(name="TEMP", length=255)
	private Integer temp;

	@Column(name="TYPE", length=255)
	private String tempType;

	@Column(name="TEMP_UPDATE", length=255)
	private Date tempUpdateAt;

	//bi-directional many-to-one association to Organization
	@ManyToOne
	@JoinColumn(name="ORG_ID", nullable=false)
	private Organization organization;

	@Column(name="PRIMARY_OC")
	private Boolean primary;

	public OrgCountry() {
	}

	//region [Region] Get Setters

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getCountry() {
		return this.country;
	}

	public void setCountry(String countryCode) {
		this.country = countryCode;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPostCode() {
		return this.postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getStreet() {
		return this.street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getStreet2() {
		return this.street2;
	}

	public void setStreet2(String street2) {
		this.street2 = street2;
	}

	public Organization getOrganization() {
		return this.organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public Boolean getPrimary() {
		return primary;
	}

	public void setPrimary(Boolean primary) {
		this.primary = primary;
	}

	public Integer getTemp() {
		return temp;
	}

	public void setTemp(Integer temp) {
		this.temp = temp;
	}

	public String getTempType() {
		return tempType;
	}

	public void setTempType(String tempType) {
		this.tempType = tempType;
	}

	public Date getTempUpdateAt() {
		return tempUpdateAt;
	}

	public void setTempUpdateAt(Date tempUpdateAt) {
		this.tempUpdateAt = tempUpdateAt;
	}

//endregion
}