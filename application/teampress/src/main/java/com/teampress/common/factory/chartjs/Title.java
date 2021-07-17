package com.teampress.common.factory.chartjs;

import com.teampress.common.factory.chartjs.common.enums.Align;
import com.teampress.common.factory.chartjs.common.enums.Position;

public class Title {
    private Align align;
    private Boolean display;
    private Position position;
    private Font font;
    private Integer padding;
    private String customTitle;

    Align getAlign() {
        return align;
    }

    Boolean getDisplay() {
        return display;
    }

    Position getPosition() {
        return position;
    }

    Font getFont() {
        return font;
    }

    Integer getPadding() {
        return padding;
    }

    String getCustomTitle() {
        return customTitle;
    }

    public void setAlign(Align align) {
        this.align = align;
    }

    public void setDisplay(Boolean display) {
        this.display = display;
    }

    public void setPosition(Position position) {
        this.position = position;
    }

    public void setFont(Font font) {
        this.font = font;
    }

    public void setPadding(Integer padding) {
        this.padding = padding;
    }

    public void setCustomTitle(String customTitle) {
        this.customTitle = customTitle;
    }
}
