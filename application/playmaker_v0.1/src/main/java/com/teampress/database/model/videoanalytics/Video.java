package com.teampress.database.model.videoanalytics;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;

import javax.persistence.*;

@Entity
@Table(name="VIDEO", schema="teampress")
@NamedQueries({
        @NamedQuery(name="Video.findAll", query="SELECT p FROM Video p where p.deleted = false AND p.organization = :porg AND p.team = :pteam"),
        @NamedQuery(name="Video.findAllPublished", query="SELECT p FROM Video p where p.deleted = false and p.isPublic = true AND p.team = :pteam AND p.organization = :porg"),
        @NamedQuery(name="Video.findById", query="SELECT p FROM Video p WHERE p.id = :pid"),
})
@Cacheable(false)
public class Video extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="ORG_ID", nullable=false)
    private Organization organization;

    @Column(name="FILENAME", length=255)
    private String fileName;

    @Column(name="NAME", length=255)
    private String name;

    @ManyToOne
    @JoinColumn(name="TEAM_ID")
    private LookupCode team;

    @Column(name="PUBLIC")
    private Boolean isPublic = false;

    @Column(name="DELETED")
    private Boolean deleted = false;

    public Video() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public LookupCode getTeam() {
        return team;
    }

    public void setTeam(LookupCode team) {
        this.team = team;
    }

    public Boolean getPublic() {
        return isPublic;
    }

    public String isPublic() {
        return isPublic+"";
    }

    public void setPublic(Boolean aPublic) {
        isPublic = aPublic;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public Organization getOrganization() {
        return organization;
    }

    public void setOrganization(Organization organization) {
        this.organization = organization;
    }
}
