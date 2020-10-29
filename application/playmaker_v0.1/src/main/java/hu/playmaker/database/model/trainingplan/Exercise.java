package hu.playmaker.database.model.trainingplan;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.system.LookupCode;
import hu.playmaker.database.model.system.Organization;

import javax.persistence.*;

/**
 * The persistent class for the TRAINING_TYPE database table.
 *
 */
@Entity
@Table(name="EXERCISE", schema="teampress")
@NamedQueries({
        @NamedQuery(name="Exercise.findAll", query="SELECT l FROM Exercise l"),
        @NamedQuery(name="Exercise.countAll", query="SELECT COUNT(l) FROM Exercise l"),
        @NamedQuery(name="Exercise.findById", query = "SELECT l FROM Exercise l WHERE l.id = :pid"),
        @NamedQuery(name="Exercise.findByLocaleAndCode", query = "SELECT l FROM Exercise l WHERE l.type = :ptype AND l.name = :pname"),
        @NamedQuery(name="Exercise.findByOrg", query = "SELECT l FROM Exercise l WHERE l.organization = :porg"),
        @NamedQuery(name="Exercise.findByCr", query = "SELECT l FROM Exercise l WHERE l.createdBy = :pcrBy"),
})
@Cacheable(false)
public class Exercise extends BaseModel {
    private static final long serialVersionUID = 1L;

    @Column(name="NAME", nullable=false, length=255)
    private String name;

    @ManyToOne
    @JoinColumn(name="TYPE", nullable=false)
    private LookupCode type;

    @Column(name = "TYPE", insertable = false, updatable = false)
    private Integer typeId;

    //bi-directional many-to-one association to Organization
    @ManyToOne
    @JoinColumn(name="ORGANIZATION_ID", nullable=false)
    private Organization organization;

    public Exercise() {
    }

    //region [Region] Get Setters

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LookupCode getType() {
        return type;
    }

    public void setType(LookupCode type) {
        this.type = type;
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }


    //endregion
}
