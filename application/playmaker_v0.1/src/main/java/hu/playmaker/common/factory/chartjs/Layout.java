package hu.playmaker.common.factory.chartjs;

public class Layout {
    private Integer paddingLeft, paddingRight, paddingTop, paddingBottom;

    Integer getPaddingLeft() {
        return paddingLeft;
    }

    Integer getPaddingRight() {
        return paddingRight;
    }

    Integer getPaddingTop() {
        return paddingTop;
    }

    Integer getPaddingBottom() {
        return paddingBottom;
    }

    public void setPaddingLeft(Integer paddingLeft) {
        this.paddingLeft = paddingLeft;
    }

    public void setPaddingRight(Integer paddingRight) {
        this.paddingRight = paddingRight;
    }

    public void setPaddingTop(Integer paddingTop) {
        this.paddingTop = paddingTop;
    }

    public void setPaddingBottom(Integer paddingBottom) {
        this.paddingBottom = paddingBottom;
    }
}
