package com.teampress.database.model.system;

import com.teampress.database.model.BaseModel;

import javax.persistence.*;

@Entity
@Table(name="USERNOTIFICATION", schema="teampress")
@NamedQueries({
        @NamedQuery(name="UserNotification.findAll", query="SELECT u FROM UserNotification u"),
        @NamedQuery(name="UserNotification.findById", query="SELECT u FROM UserNotification u WHERE u.id = :pid"),
        @NamedQuery(name="UserNotification.findByUUID", query="SELECT u FROM UserNotification u WHERE u.uuid = :puuid"),
        @NamedQuery(name="UserNotification.findByUser", query="SELECT u FROM UserNotification u WHERE u.user = :pu AND u.seen=false ORDER BY u.id DESC")
})
@Cacheable(false)
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

    public UserNotification() {
    }

    public boolean isSeen() {
        return seen;
    }

    public void setSeen(boolean seen) {
        this.seen = seen;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
}
