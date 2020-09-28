package hu.playmaker.common.factory;

public class ChartScale {
    Boolean beginAtZero;
    Integer min, max, stepSize;

    public ChartScale(Integer min, Integer max, Integer stepSize, boolean beginAtZero) {
        this.beginAtZero = beginAtZero;
        this.min = min;
        this.max = max;
        this.stepSize = stepSize;
    }
}
