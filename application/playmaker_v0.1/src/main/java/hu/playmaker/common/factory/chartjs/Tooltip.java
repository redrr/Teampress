package hu.playmaker.common.factory.chartjs;

import hu.playmaker.common.factory.chartjs.common.enums.*;

public class Tooltip {
    private Boolean enabled, intersect, displayColors, rtl;
    private TooltipMode mode;
    private TooltipPosition position;
    private Color backgroundColor, multiKeyBackground, borderColor;
    private Font titleFont, bodyFont, footerFont;
    private Align titleAlign, bodyAlign, footerAlign;
    private Integer titleSpacing, titleMarginBottom, bodySpacing, footerSpacing, footerMarginTop, xPadding, yPadding, caretPadding, caretSize, cornerRadius, boxWidth, boxHeight, borderWidth;

    Boolean getEnabled() {
        return enabled;
    }

    Boolean getIntersect() {
        return intersect;
    }

    Boolean getDisplayColors() {
        return displayColors;
    }

    Boolean getRtl() {
        return rtl;
    }

    TooltipMode getMode() {
        return mode;
    }

    TooltipPosition getPosition() {
        return position;
    }

    Color getBackgroundColor() {
        return backgroundColor;
    }

    Color getMultiKeyBackground() {
        return multiKeyBackground;
    }

    Color getBorderColor() {
        return borderColor;
    }

    Font getTitleFont() {
        return titleFont;
    }

    Font getBodyFont() {
        return bodyFont;
    }

    Font getFooterFont() {
        return footerFont;
    }

    Align getTitleAlign() {
        return titleAlign;
    }

    Align getBodyAlign() {
        return bodyAlign;
    }

    Align getFooterAlign() {
        return footerAlign;
    }

    Integer getTitleSpacing() {
        return titleSpacing;
    }

    Integer getTitleMarginBottom() {
        return titleMarginBottom;
    }

    Integer getBodySpacing() {
        return bodySpacing;
    }

    Integer getFooterSpacing() {
        return footerSpacing;
    }

    Integer getFooterMarginTop() {
        return footerMarginTop;
    }

    Integer getxPadding() {
        return xPadding;
    }

    Integer getyPadding() {
        return yPadding;
    }

    Integer getCaretPadding() {
        return caretPadding;
    }

    Integer getCaretSize() {
        return caretSize;
    }

    Integer getCornerRadius() {
        return cornerRadius;
    }

    Integer getBoxWidth() {
        return boxWidth;
    }

    Integer getBoxHeight() {
        return boxHeight;
    }

    Integer getBorderWidth() {
        return borderWidth;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public void setIntersect(Boolean intersect) {
        this.intersect = intersect;
    }

    public void setDisplayColors(Boolean displayColors) {
        this.displayColors = displayColors;
    }

    public void setRtl(Boolean rtl) {
        this.rtl = rtl;
    }

    public void setMode(TooltipMode mode) {
        this.mode = mode;
    }

    public void setPosition(TooltipPosition position) {
        this.position = position;
    }

    public void setBackgroundColor(Color backgroundColor) {
        this.backgroundColor = backgroundColor;
    }

    public void setMultiKeyBackground(Color multiKeyBackground) {
        this.multiKeyBackground = multiKeyBackground;
    }

    public void setBorderColor(Color borderColor) {
        this.borderColor = borderColor;
    }

    public void setTitleFont(Font titleFont) {
        this.titleFont = titleFont;
    }

    public void setBodyFont(Font bodyFont) {
        this.bodyFont = bodyFont;
    }

    public void setFooterFont(Font footerFont) {
        this.footerFont = footerFont;
    }

    public void setTitleAlign(Align titleAlign) {
        this.titleAlign = titleAlign;
    }

    public void setBodyAlign(Align bodyAlign) {
        this.bodyAlign = bodyAlign;
    }

    public void setFooterAlign(Align footerAlign) {
        this.footerAlign = footerAlign;
    }

    public void setTitleSpacing(Integer titleSpacing) {
        this.titleSpacing = titleSpacing;
    }

    public void setTitleMarginBottom(Integer titleMarginBottom) {
        this.titleMarginBottom = titleMarginBottom;
    }

    public void setBodySpacing(Integer bodySpacing) {
        this.bodySpacing = bodySpacing;
    }

    public void setFooterSpacing(Integer footerSpacing) {
        this.footerSpacing = footerSpacing;
    }

    public void setFooterMarginTop(Integer footerMarginTop) {
        this.footerMarginTop = footerMarginTop;
    }

    public void setxPadding(Integer xPadding) {
        this.xPadding = xPadding;
    }

    public void setyPadding(Integer yPadding) {
        this.yPadding = yPadding;
    }

    public void setCaretPadding(Integer caretPadding) {
        this.caretPadding = caretPadding;
    }

    public void setCaretSize(Integer caretSize) {
        this.caretSize = caretSize;
    }

    public void setCornerRadius(Integer cornerRadius) {
        this.cornerRadius = cornerRadius;
    }

    public void setBoxWidth(Integer boxWidth) {
        this.boxWidth = boxWidth;
    }

    public void setBoxHeight(Integer boxHeight) {
        this.boxHeight = boxHeight;
    }

    public void setBorderWidth(Integer borderWidth) {
        this.borderWidth = borderWidth;
    }
}
