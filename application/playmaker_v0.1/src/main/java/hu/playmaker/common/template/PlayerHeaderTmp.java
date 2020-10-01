package hu.playmaker.common.template;

public class PlayerHeaderTmp {

    private String name;
    private String profImg;
    private String[] cssClass;
    private String[] data;

    public PlayerHeaderTmp() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProfImg() {
        return profImg;
    }

    public void setProfImg(String profImg) {
        this.profImg = profImg;
    }

    public String[] getCssClass() {
        return cssClass;
    }

    public void setCssClass(String[] cssClass) {
        this.cssClass = cssClass;
    }

    public String[] getData() {
        return data;
    }

    public void setData(String[] data) {
        this.data = data;
    }
}
