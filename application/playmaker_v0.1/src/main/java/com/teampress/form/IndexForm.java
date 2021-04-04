package com.teampress.form;

import org.springframework.web.multipart.MultipartFile;

public class IndexForm extends BaseForm {

    public MultipartFile file;
    public String postText;

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    public String getPostText() {
        return postText;
    }

    public void setPostText(String postText) {
        this.postText = postText;
    }
}
