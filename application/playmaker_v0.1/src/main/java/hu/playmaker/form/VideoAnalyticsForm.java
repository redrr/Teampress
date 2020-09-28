package hu.playmaker.form;

import org.springframework.web.multipart.MultipartFile;

public class VideoAnalyticsForm extends BaseForm {

    public Integer sorsId;
    public Integer customId;
    public Integer trainingId;
    public MultipartFile video;

    public Integer getSorsId() {
        return sorsId;
    }

    public void setSorsId(Integer sorsId) {
        this.sorsId = sorsId;
    }

    public Integer getCustomId() {
        return customId;
    }

    public void setCustomId(Integer customId) {
        this.customId = customId;
    }

    public MultipartFile getVideo() {
        return video;
    }

    public void setVideo(MultipartFile video) {
        this.video = video;
    }

    public Integer getTrainingId() {
        return trainingId;
    }

    public void setTrainingId(Integer trainingId) {
        this.trainingId = trainingId;
    }
}
