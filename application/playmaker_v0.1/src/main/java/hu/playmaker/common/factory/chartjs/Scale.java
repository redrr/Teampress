package hu.playmaker.common.factory.chartjs;

public class Scale {

    private Boolean beginAtZero;
    private Integer min, max, stepSize;

    Boolean getBeginAtZero() {
        return beginAtZero;
    }

    public void setBeginAtZero(Boolean beginAtZero) {
        this.beginAtZero = beginAtZero;
    }

    Integer getMin() {
        return min;
    }

    public void setMin(Integer min) {
        this.min = min;
    }

    Integer getMax() {
        return max;
    }

    public void setMax(Integer max) {
        this.max = max;
    }

    Integer getStepSize() {
        return stepSize;
    }

    public void setStepSize(Integer stepSize) {
        this.stepSize = stepSize;
    }
}
