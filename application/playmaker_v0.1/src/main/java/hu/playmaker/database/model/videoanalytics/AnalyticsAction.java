package hu.playmaker.database.model.videoanalytics;

public class AnalyticsAction {

    private Video sourceVideo;
    private String time, bluePrint;

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
