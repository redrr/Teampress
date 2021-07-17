package com.teampress.database.model.videoanalytics;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.Organization;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name="ANALYTICSACTION", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class AnalyticsAction extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="ORG_ID", nullable=false)
    private Organization organization;

    @ManyToOne
    @JoinColumn(name="VIDEO_ID")
    private Video sourceVideo;

    @Column(name="NAME", length=255)
    private String name;

    @Column(name="PLAYERS", length=255)
    private String playerIds;

    @Column(name="COMMENT", length=255)
    private String comment;

    @Column(name="TIME", length=255)
    private String time;

    @Column(name="JSON", length=255)
    private String bluePrint;
}
