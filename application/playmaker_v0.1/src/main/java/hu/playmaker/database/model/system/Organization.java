package hu.playmaker.database.model.system;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;


/**
 * The persistent class for the ORGANIZATION database table.
 * 
 */
@Entity
@Table(name="CLUB", schema="teampress")
@NamedQueries({
		@NamedQuery(name="Organization.findAll", query="SELECT o FROM Organization o"),
		@NamedQuery(name="Organization.countAll", query = "SELECT COUNT(o) FROM Organization o"),
		@NamedQuery(name="Organization.findById", query = "SELECT o FROM Organization o where o.id = :pid"),
		@NamedQuery(name="Organization.findByName", query = "SELECT o FROM Organization o WHERE o.name = :pname"),
		@NamedQuery(name="Organization.findByURL", query="SELECT o FROM Organization o WHERE o.url = :purl"),
		@NamedQuery(name="Organization.findAllFilteredByOrganization", query= "SELECT o FROM Organization o WHERE o IN :porgs"),
})
@Cacheable(false)
public class Organization extends BaseModel {

	private static final long serialVersionUID = 1L;

	@Column(name = "NAME")
	private String name;

	@Column(name = "TYPE")
	private String type;

	@Column(name = "DATABANK_URL")
	private String url;

	@Column(name = "PUBLIC_KEY")
	private String stripePublicKey;

	@Column(name = "PRIVATE_KEY")
	private String stripePrivateKey;

	@Column(name = "CURRENCY")
	private String currency;

	//bi-directional many-to-one association to OrgCountry
	@OneToMany(mappedBy="organization")
	private Set<OrgCountry> orgCountries;

	//bi-directional many-to-one association to UserOrganization
	@OneToMany(mappedBy="organization")
	private Set<UserOrganization> userOrganizations;

	public Organization() {
	}

	//region [Region] Getters & Setters

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Set<OrgCountry> getOrgCountries() {
		if (Objects.isNull(orgCountries)) orgCountries = new HashSet<>();
		return this.orgCountries;
	}

	public void setOrgCountries(Set<OrgCountry> orgCountries) {
		this.orgCountries = orgCountries;
	}

	public OrgCountry addOrgCountry(OrgCountry orgCountry) {
		getOrgCountries().add(orgCountry);
		orgCountry.setOrganization(this);

		return orgCountry;
	}

	public OrgCountry removeOrgCountry(OrgCountry orgCountry) {
		getOrgCountries().remove(orgCountry);
		orgCountry.setOrganization(null);

		return orgCountry;
	}

	public Set<UserOrganization> getUserOrganizations() {
		if (Objects.isNull(userOrganizations)) userOrganizations = new HashSet<>();
		return this.userOrganizations;
	}

	public void setUserOrganizations(Set<UserOrganization> userOrganizations) {
		this.userOrganizations = userOrganizations;
	}

	public UserOrganization addUserOrganization(UserOrganization userOrganization) {
		getUserOrganizations().add(userOrganization);
		userOrganization.setOrganization(this);

		return userOrganization;
	}

	public UserOrganization removeUserOrganization(UserOrganization userOrganization) {
		getUserOrganizations().remove(userOrganization);
		userOrganization.setOrganization(null);

		return userOrganization;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	//endregion

    public OrgCountry getPrimaryOrgCountry() {
		for (OrgCountry c : orgCountries) {
			if (c.getPrimary())
				return c;
		}
		return null;
    }

	public String getStripePublicKey() {
		return stripePublicKey;
	}

	public void setStripePublicKey(String stripePublicKey) {
		this.stripePublicKey = stripePublicKey;
	}

	public String getStripePrivateKey() {
		return stripePrivateKey;
	}

	public void setStripePrivateKey(String stripePrivateKey) {
		this.stripePrivateKey = stripePrivateKey;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	@Override
	public boolean equals(Object object) {
		if (!(object instanceof Organization))
			return false;
		else {
			Organization orgObject = ((Organization) object);
			return Objects.equals(this.getId(), orgObject.getId()) &&
					Objects.equals(this.name, orgObject.getName());
		}
	}
}
