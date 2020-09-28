package hu.playmaker.form;

import org.springframework.web.multipart.MultipartFile;

public class FolderForm extends BaseForm {
    String name, desc;
    MultipartFile bgImg;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public MultipartFile getBgImg() {
        return bgImg;
    }

    public void setBgImg(MultipartFile bgImg) {
        this.bgImg = bgImg;
    }
}
