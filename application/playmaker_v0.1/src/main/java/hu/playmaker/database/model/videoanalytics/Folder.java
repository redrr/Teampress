package hu.playmaker.database.model.videoanalytics;

import hu.playmaker.database.model.BaseModel;
import hu.playmaker.database.model.databank.Sorsolas;
import hu.playmaker.database.model.gameplan.CustomGame;
import hu.playmaker.database.model.system.Organization;
import hu.playmaker.database.model.system.User;

import javax.persistence.*;

@Entity
@Table(name="FOLDER", schema="probe")
@NamedQueries({
        @NamedQuery(name="Folder.findAll", query="SELECT p FROM Folder p"),
        @NamedQuery(name="Folder.countAll", query="SELECT COUNT(p) FROM Folder p"),
        @NamedQuery(name="Folder.findById", query="SELECT p FROM Folder p WHERE p.id = :pid"),
        @NamedQuery(name="Folder.findByName", query="SELECT p FROM Folder p WHERE p.name=:pname"),
        @NamedQuery(name="Folder.findByOrg", query="SELECT p FROM Folder p WHERE p.organization=:porg"),
})
@Cacheable(false)
public class Folder extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="ORG_ID")
    private Organization organization;

    @Column(name="NAME", length=255)
    private String name;

    @Column(name="URL", length=255)
    private String url;

    @Column(name="DESCRIPTION", length=255)
    private String description;

    public Folder() {
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
