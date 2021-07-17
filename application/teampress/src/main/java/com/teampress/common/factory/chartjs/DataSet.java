package com.teampress.common.factory.chartjs;

public abstract class DataSet {

    private Color backgroundColor, borderColor, hoverBackgroundColor, hoverBorderColor;
    private Integer borderWidth, hoverBorderWidth;
    private Object clip;
    private Object[] data;

    //region[Region] Setters

    public void setBackgroundColor(Color backgroundColor) {
        this.backgroundColor = backgroundColor;
    }

    public void setBorderColor(Color borderColor) {
        this.borderColor = borderColor;
    }

    public void setHoverBackgroundColor(Color hoverBackgroundColor) {
        this.hoverBackgroundColor = hoverBackgroundColor;
    }

    public void setHoverBorderColor(Color hoverBorderColor) {
        this.hoverBorderColor = hoverBorderColor;
    }

    public void setBorderWidth(Integer borderWidth) {
        this.borderWidth = borderWidth;
    }

    public void setHoverBorderWidth(Integer hoverBorderWidth) {
        this.hoverBorderWidth = hoverBorderWidth;
    }

    public void setClip(Object clip) {
        this.clip = clip;
    }

    public void setData(Object[] data) {
        this.data = data;
    }

    //endregion

    //region [Region] Getters

    Color getBackgroundColor() {
        return backgroundColor;
    }

    Color getBorderColor() {
        return borderColor;
    }

    Color getHoverBackgroundColor() {
        return hoverBackgroundColor;
    }

    Color getHoverBorderColor() {
        return hoverBorderColor;
    }

    Integer getBorderWidth() {
        return borderWidth;
    }

    Integer getHoverBorderWidth() {
        return hoverBorderWidth;
    }

    Object getClip() {
        return clip;
    }

    Object[] getData() {
        return data;
    }


    //endregion
}
