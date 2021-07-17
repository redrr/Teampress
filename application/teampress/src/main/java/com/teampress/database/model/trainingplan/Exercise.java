package com.teampress.database.model.trainingplan;

import com.teampress.database.model.BaseModel;
import com.teampress.database.model.system.LookupCode;
import com.teampress.database.model.system.Organization;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

/**
 * The persistent class for the TRAINING_TYPE database table.
 *
 */
@Entity
@Table(name="EXERCISE", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class Exercise extends BaseModel {
    private static final long serialVersionUID = 1L;

    //bi-directional many-to-one association to Organization
    @ManyToOne
    @JoinColumn(name="ORGANIZATION_ID", nullable=false)
    private Organization organization;

    @ManyToOne
    @JoinColumn(name="TYPE", nullable=false)
    private LookupCode type;

    @Column(name="NAME", nullable=false, length=255)
    private String name;
}
