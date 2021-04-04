package com.teampress.database.model;

import com.teampress.handler.SessionHandler;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

@MappedSuperclass
public abstract class BaseModel implements Serializable {

	public static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ID", unique=true, nullable=false)
	private Integer id;

    @Column(name="CREATED_BY", length=255)
    @CreatedBy
    private String createdBy;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="CREATION_DATE", nullable=false)
    @CreatedDate
    private Date creationDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name="LAST_UPDATE_DATE")
    @LastModifiedDate
    private Date lastUpdateDate;

    @Column(name="LAST_UPDATED_BY", length=255)
    @LastModifiedBy
    private String lastUpdatedBy;

    @Column(name="VERSION")
    @Version
    private int version;

    //region [Region] Get Setters

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

    public String getCreatedBy() {
        return this.createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreationDate() {
        return this.creationDate;
    }

    public String getCreationDateAsString() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return format.format(getCreationDate());
    }

    public String getSimpleCreationDateAsString() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        return format.format(getCreationDate());
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }


    public Date getLastUpdateDate() {
        return this.lastUpdateDate;
    }

    public void setLastUpdateDate(Date lastUpdateDate) {
        this.lastUpdateDate = lastUpdateDate;
    }

    public String getLastUpdatedBy() {
        return this.lastUpdatedBy;
    }

    public void setLastUpdatedBy(String lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
    }

    //endregion

    @PrePersist
    protected void setAutoCreateDate() {
        this.creationDate = new Date();
        this.createdBy = SessionHandler.getUsernameFromCurrentSession();
    }

    @PreUpdate
    protected void setAutoLastUpdateDate() {
        this.lastUpdateDate = new Date();
        this.lastUpdatedBy = SessionHandler.getUsernameFromCurrentSession();
        savedId = id;
    }

    public int getVersion() {
        return version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    @Transient
    private int savedId;

    @PostUpdate
    public void postUpdate() {
        if (savedId != id) {
            setId(savedId);
        }
    }
}
