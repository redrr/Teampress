package com.teampress.common.factory.chartjs;

public class LegendLabel {
    private Integer boxWidth, boxHeight, padding;
    private Font font;
    private Boolean usePointStyle;

    Integer getBoxWidth() {
        return boxWidth;
    }

    Integer getBoxHeight() {
        return boxHeight;
    }

    Integer getPadding() {
        return padding;
    }

    Font getFont() {
        return font;
    }

    Boolean getUsePointStyle() {
        return usePointStyle;
    }

    public void setBoxWidth(Integer boxWidth) {
        this.boxWidth = boxWidth;
    }

    public void setBoxHeight(Integer boxHeight) {
        this.boxHeight = boxHeight;
    }

    public void setPadding(Integer padding) {
        this.padding = padding;
    }

    public void setFont(Font font) {
        this.font = font;
    }

    public void setUsePointStyle(Boolean usePointStyle) {
        this.usePointStyle = usePointStyle;
    }
}
