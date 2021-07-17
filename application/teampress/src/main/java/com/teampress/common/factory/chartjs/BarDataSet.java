package com.teampress.common.factory.chartjs;


import com.teampress.common.factory.chartjs.common.enums.Axis;
import com.teampress.common.factory.chartjs.common.enums.BorderSkipped;

public class BarDataSet extends DataSet {

    private String label, xAxisID, yAxisID;
    private Axis indexAxis;
    private BorderSkipped borderSkipped;
    private Integer barPercentage, categoryPercentage, barThickness, maxBarThickness, minBarLength, order;

    public BarDataSet() {
    }

    public BarDataSet(BarDataSet template) {
        this.setBackgroundColor(template.getBackgroundColor());
        this.setBorderColor(template.getBorderColor());
        this.setHoverBackgroundColor(template.getHoverBackgroundColor());
        this.setHoverBorderColor(template.getHoverBorderColor());
        this.setBorderWidth(template.getBorderWidth());
        this.setHoverBorderWidth(template.getHoverBorderWidth());
        this.setClip(template.getClip());
        this.setData(template.getData());
        this.setLabel(template.getLabel());
        this.setxAxisID(template.getxAxisID());
        this.setyAxisID(template.getyAxisID());
        this.setIndexAxis(template.getIndexAxis());
        this.setBorderSkipped(template.getBorderSkipped());
        this.setBarPercentage(template.getBarPercentage());
        this.setCategoryPercentage(template.getCategoryPercentage());
        this.setBarThickness(template.getBarThickness());
        this.setMaxBarThickness(template.getMaxBarThickness());
        this.setMinBarLength(template.getMinBarLength());
        this.setOrder(template.getOrder());
    }



    //region[Region] Setters

    public void setLabel(String label) {
        this.label = label;
    }

    public void setxAxisID(String xAxisID) {
        this.xAxisID = xAxisID;
    }

    public void setyAxisID(String yAxisID) {
        this.yAxisID = yAxisID;
    }

    public void setIndexAxis(Axis indexAxis) {
        this.indexAxis = indexAxis;
    }

    public void setBorderSkipped(BorderSkipped borderSkipped) {
        this.borderSkipped = borderSkipped;
    }

    public void setBarPercentage(Integer barPercentage) {
        this.barPercentage = barPercentage;
    }

    public void setCategoryPercentage(Integer categoryPercentage) {
        this.categoryPercentage = categoryPercentage;
    }

    public void setBarThickness(Integer barThickness) {
        this.barThickness = barThickness;
    }

    public void setMaxBarThickness(Integer maxBarThickness) {
        this.maxBarThickness = maxBarThickness;
    }

    public void setMinBarLength(Integer minBarLength) {
        this.minBarLength = minBarLength;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

    //endregion

    //region [Region] Getters

    String getLabel() {
        return label;
    }

    String getxAxisID() {
        return xAxisID;
    }

    String getyAxisID() {
        return yAxisID;
    }

    Axis getIndexAxis() {
        return indexAxis;
    }

    BorderSkipped getBorderSkipped() {
        return borderSkipped;
    }

    Integer getBarPercentage() {
        return barPercentage;
    }

    Integer getCategoryPercentage() {
        return categoryPercentage;
    }

    Integer getBarThickness() {
        return barThickness;
    }

    Integer getMaxBarThickness() {
        return maxBarThickness;
    }

    Integer getMinBarLength() {
        return minBarLength;
    }

    Integer getOrder() {
        return order;
    }


    //endregion
}
