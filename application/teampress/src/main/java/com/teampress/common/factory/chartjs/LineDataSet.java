package com.teampress.common.factory.chartjs;

import com.teampress.common.factory.chartjs.common.enums.CubicInterpolationMode;
import com.teampress.common.factory.chartjs.common.enums.Stepped;

public class LineDataSet extends LineTypeDataSet {

    private String xAxisID, yAxisID;
    private CubicInterpolationMode cubicInterpolationMode;
    private Stepped stepped;

    public LineDataSet(LineDataSet template) {
        this.setBackgroundColor(template.getBackgroundColor());
        this.setBorderColor(template.getBorderColor());
        this.setHoverBackgroundColor(template.getHoverBackgroundColor());
        this.setHoverBorderColor(template.getHoverBorderColor());
        this.setBorderWidth(template.getBorderWidth());
        this.setHoverBorderWidth(template.getHoverBorderWidth());
        this.setClip(template.getClip());
        this.setData(template.getData());
        this.setLabel(template.getLabel());
        this.setBorderJoinStyle(template.getBorderJoinStyle());
        this.setHoverBorderJoinStyle(template.getHoverBorderJoinStyle());
        this.setBorderCapStyle(template.getBorderCapStyle());
        this.setHoverBorderCapStyle(template.getHoverBorderCapStyle());
        this.setPointStyle(template.getPointStyle());
        this.setBorderDash(template.getBorderDash());
        this.setHoverBorderDash(template.getHoverBorderDash());
        this.setBorderDashOffset(template.getBorderDashOffset());
        this.setHoverBorderDashOffset(template.getHoverBorderDashOffset());
        this.setLineTension(template.getLineTension());
        this.setPointBorderWidth(template.getPointBorderWidth());
        this.setPointHitRadius(template.getPointHitRadius());
        this.setPointRadius(template.getPointRadius());
        this.setPointHoverRadius(template.getPointHoverRadius());
        this.setPointRotation(template.getPointRotation());
        this.setOrder(template.getOrder());
        this.setFill(template.getFill());
        this.setSpanGaps(template.getSpanGaps());
        this.setShowLine(template.getShowLine());
        this.setPointBackgroundColor(template.getPointBackgroundColor());
        this.setPointBorderColor(template.getPointBorderColor());
        this.setPointHoverBackgroundColor(template.getPointHoverBackgroundColor());
        this.setPointHoverBorderColor(template.getPointHoverBorderColor());
        this.setxAxisID(template.getxAxisID());
        this.setyAxisID(template.getyAxisID());
        this.setCubicInterpolationMode(template.getCubicInterpolationMode());
        this.setStepped(template.getStepped());
    }

    public LineDataSet() {

    }

    //region[Region] Setters

    public void setxAxisID(String xAxisID) {
        this.xAxisID = xAxisID;
    }

    public void setyAxisID(String yAxisID) {
        this.yAxisID = yAxisID;
    }

    public void setCubicInterpolationMode(CubicInterpolationMode cubicInterpolationMode) {
        this.cubicInterpolationMode = cubicInterpolationMode;
    }

    public void setStepped(Stepped stepped) {
        this.stepped = stepped;
    }

    //endregion

    //region [Region] Getters

    String getxAxisID() {
        return xAxisID;
    }

    String getyAxisID() {
        return yAxisID;
    }

    CubicInterpolationMode getCubicInterpolationMode() {
        return cubicInterpolationMode;
    }

    Stepped getStepped() {
        return stepped;
    }


    //endregion
}
