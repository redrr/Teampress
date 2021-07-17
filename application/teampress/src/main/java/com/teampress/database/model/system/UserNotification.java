package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name="USERNOTIFICATION", schema="teampress")
@Cacheable(false)
@NoArgsConstructor
@Getter
@Setter
public class UserNotification extends BaseModel {
    private static final long serialVersionUID = 1L;

    //bi-directional many-to-one association to User
    @ManyToOne
    @JoinColumn(name="USER_ID", nullable=false)
    private User user;

    @Column(name="SRC", length=255)
    private String location;

    @Column(name="TITLE", length=255)
    private String title;

    @Column(name="DESCRIPTION", length=255)
    private String description;

    @Column(name="SEEN", length=255)
    private boolean seen;

    @Column(name="UUID", length=255)
    private String uuid;
}
