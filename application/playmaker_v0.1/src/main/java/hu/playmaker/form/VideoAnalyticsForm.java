package hu.playmaker.form;

import org.springframework.web.multipart.MultipartFile;

public class VideoAnalyticsForm extends BaseForm {

    public MultipartFile video;

    public MultipartFile getVideo() {
        return video;
    }

    public void setVideo(MultipartFile video) {
        this.video = video;
    }
}
