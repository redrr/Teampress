package com.teampress.database.model.videoanalytics;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name="VIDEO", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
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
}
