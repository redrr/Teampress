package hu.playmaker.database.model.videoanalytics;

import hu.playmaker.database.model.BaseModel;

import javax.persistence.*;

@Entity
@Table(name="ANALYTICSACTION", schema="teampress")
@NamedQueries({
        @NamedQuery(name="AnalyticsAction.findById", query="SELECT p FROM AnalyticsAction p WHERE p.id = :pid"),
        @NamedQuery(name="AnalyticsAction.findByVideo", query="SELECT p FROM AnalyticsAction p WHERE p.sourceVideo =:pvideo"),
})
@Cacheable(false)
public class AnalyticsAction extends BaseModel {
    private static final long serialVersionUID = 1L;

    @ManyToOne
    @JoinColumn(name="VIDEO_ID")
    private Video sourceVideo;

    @Column(name="TIME", length=255)
    private String time;

    @Column(name="JSON", length=255)
    private String bluePrint;

    public AnalyticsAction() {
    }

    public Video getSourceVideo() {
        return sourceVideo;
    }

    public void setSourceVideo(Video sourceVideo) {
        this.sourceVideo = sourceVideo;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getBluePrint() {
        return bluePrint;
    }

    public void setBluePrint(String bluePrint) {
        this.bluePrint = bluePrint;
    }
}
