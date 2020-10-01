package hu.playmaker.common.factory.chartjs;

import hu.playmaker.common.factory.chartjs.common.enums.BorderCapStyle;
import hu.playmaker.common.factory.chartjs.common.enums.BorderJoinStyle;
import hu.playmaker.common.factory.chartjs.common.enums.PointStyle;

public abstract class LineTypeDataSet extends DataSet {

    private String label;
    private BorderJoinStyle borderJoinStyle, hoverBorderJoinStyle;
    private BorderCapStyle borderCapStyle, hoverBorderCapStyle;
    private PointStyle pointStyle;
    private Integer[] borderDash, hoverBorderDash;
    private Integer borderDashOffset, hoverBorderDashOffset, lineTension, pointBorderWidth,
            pointHoverBorderWidth, pointHitRadius, pointRadius, pointHoverRadius, pointRotation, order;
    private Boolean fill, spanGaps, showLine;
    private Color pointBackgroundColor, pointBorderColor, pointHoverBackgroundColor, pointHoverBorderColor;

    //region[Region] Setters

    public void setLabel(String label) {
        this.label = label;
    }

    public void setBorderJoinStyle(BorderJoinStyle borderJoinStyle) {
        this.borderJoinStyle = borderJoinStyle;
    }

    public void setHoverBorderJoinStyle(BorderJoinStyle hoverBorderJoinStyle) {
        this.hoverBorderJoinStyle = hoverBorderJoinStyle;
    }

    public void setBorderCapStyle(BorderCapStyle borderCapStyle) {
        this.borderCapStyle = borderCapStyle;
    }

    public void setHoverBorderCapStyle(BorderCapStyle hoverBorderCapStyle) {
        this.hoverBorderCapStyle = hoverBorderCapStyle;
    }

    public void setPointStyle(PointStyle pointStyle) {
        this.pointStyle = pointStyle;
    }

    public void setBorderDash(Integer[] borderDash) {
        this.borderDash = borderDash;
    }

    public void setHoverBorderDash(Integer[] hoverBorderDash) {
        this.hoverBorderDash = hoverBorderDash;
    }

    public void setBorderDashOffset(Integer borderDashOffset) {
        this.borderDashOffset = borderDashOffset;
    }

    public void setHoverBorderDashOffset(Integer hoverBorderDashOffset) {
        this.hoverBorderDashOffset = hoverBorderDashOffset;
    }

    public void setLineTension(Integer lineTension) {
        this.lineTension = lineTension;
    }

    public void setPointBorderWidth(Integer pointBorderWidth) {
        this.pointBorderWidth = pointBorderWidth;
    }

    public void setPointHoverBorderWidth(Integer pointHoverBorderWidth) {
        this.pointHoverBorderWidth = pointHoverBorderWidth;
    }

    public void setPointHitRadius(Integer pointHitRadius) {
        this.pointHitRadius = pointHitRadius;
    }

    public void setPointRadius(Integer pointRadius) {
        this.pointRadius = pointRadius;
    }

    public void setPointHoverRadius(Integer pointHoverRadius) {
        this.pointHoverRadius = pointHoverRadius;
    }

    public void setPointRotation(Integer pointRotation) {
        this.pointRotation = pointRotation;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

    public void setFill(Boolean fill) {
        this.fill = fill;
    }

    public void setSpanGaps(Boolean spanGaps) {
        this.spanGaps = spanGaps;
    }

    public void setShowLine(Boolean showLine) {
        this.showLine = showLine;
    }

    public void setPointBackgroundColor(Color pointBackgroundColor) {
        this.pointBackgroundColor = pointBackgroundColor;
    }

    public void setPointBorderColor(Color pointBorderColor) {
        this.pointBorderColor = pointBorderColor;
    }

    public void setPointHoverBackgroundColor(Color pointHoverBackgroundColor) {
        this.pointHoverBackgroundColor = pointHoverBackgroundColor;
    }

    public void setPointHoverBorderColor(Color pointHoverBorderColor) {
        this.pointHoverBorderColor = pointHoverBorderColor;
    }

    //endregion

    //region [Region] Getters

    String getLabel() {
        return label;
    }

    BorderJoinStyle getBorderJoinStyle() {
        return borderJoinStyle;
    }

    BorderJoinStyle getHoverBorderJoinStyle() {
        return hoverBorderJoinStyle;
    }

    BorderCapStyle getBorderCapStyle() {
        return borderCapStyle;
    }

    BorderCapStyle getHoverBorderCapStyle() {
        return hoverBorderCapStyle;
    }

    PointStyle getPointStyle() {
        return pointStyle;
    }

    Integer[] getBorderDash() {
        return borderDash;
    }

    Integer[] getHoverBorderDash() {
        return hoverBorderDash;
    }

    Integer getBorderDashOffset() {
        return borderDashOffset;
    }

    Integer getHoverBorderDashOffset() {
        return hoverBorderDashOffset;
    }

    Integer getLineTension() {
        return lineTension;
    }

    Integer getPointBorderWidth() {
        return pointBorderWidth;
    }

    Integer getPointHoverBorderWidth() {
        return pointHoverBorderWidth;
    }

    Integer getPointHitRadius() {
        return pointHitRadius;
    }

    Integer getPointRadius() {
        return pointRadius;
    }

    Integer getPointHoverRadius() {
        return pointHoverRadius;
    }

    Integer getPointRotation() {
        return pointRotation;
    }

    Integer getOrder() {
        return order;
    }

    Boolean getFill() {
        return fill;
    }

    Boolean getSpanGaps() {
        return spanGaps;
    }

    Boolean getShowLine() {
        return showLine;
    }

    Color getPointBackgroundColor() {
        return pointBackgroundColor;
    }

    Color getPointBorderColor() {
        return pointBorderColor;
    }

    Color getPointHoverBackgroundColor() {
        return pointHoverBackgroundColor;
    }

    Color getPointHoverBorderColor() {
        return pointHoverBorderColor;
    }

    //endregion
}
