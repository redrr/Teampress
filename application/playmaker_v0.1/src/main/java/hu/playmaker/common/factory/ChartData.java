package hu.playmaker.common.factory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static java.util.Objects.isNull;

public class ChartData {

    private String label;
    private List<String> backgroundColor, borderColor, pointBackgroundColor;
    private boolean fill;
    private List data;

    public ChartData() {
        backgroundColor = new ArrayList<>();
        borderColor = new ArrayList<>();
        pointBackgroundColor = new ArrayList<>();
        data = new ArrayList<>();
    }

    public ChartData setLabel(String label){
        this.label = label;
        return this;
    }

    public ChartData setBackgroundColor(String[] backgroundColor){
        this.backgroundColor = Arrays.asList(backgroundColor);
        return this;
    }

    public ChartData addBackgroundColor(String backgroundColor){
        this.backgroundColor.add(backgroundColor);
        return this;
    }

    public ChartData setBorderColor(String[] borderColor){
        this.borderColor = Arrays.asList(borderColor);
        return this;
    }


    public ChartData addBorderColor(String borderColor){
        this.borderColor.add(borderColor);
        return this;
    }

    public ChartData setPointBackgroundColor(String[] pointBackgroundColor){
        this.pointBackgroundColor = Arrays.asList(pointBackgroundColor);
        return this;
    }

    public ChartData addPointBackgroundColor(String pointBackgroundColor){
        this.pointBackgroundColor.add(pointBackgroundColor);
        return this;
    }

    public ChartData setFill(boolean fill){
        this.fill = fill;
        return this;
    }

    public ChartData addData(int data){
        this.data.add(data);
        return this;
    }

    public ChartData addData(double data){
        this.data.add(data);
        return this;
    }

    //region [Region] Getters
    public String getLabel() {
        return label;
    }

    public List<String> getBackgroundColor() {
        return backgroundColor;
    }

    public List<String> getBorderColor() {
        return borderColor;
    }

    public boolean isFill() {
        return fill;
    }

    public List<String> getPointBackgroundColor() {
        return pointBackgroundColor;
    }

    public List getData() {
        return data;
    }
    //endregion
}
