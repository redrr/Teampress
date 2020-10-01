package hu.playmaker.common.factory.chartjs;

import hu.playmaker.common.factory.chartjs.common.enums.Align;
import hu.playmaker.common.factory.chartjs.common.enums.Position;

public class Legend {
    private Boolean display, fullWidth, reverse, rtl;
    private Position position;
    private LegendLabel label;
    private LegendTitle title;
    private Align align;

    Boolean getDisplay() {
        return display;
    }

    Boolean getFullWidth() {
        return fullWidth;
    }

    Boolean getReverse() {
        return reverse;
    }

    Boolean getRtl() {
        return rtl;
    }

    Position getPosition() {
        return position;
    }

    LegendLabel getLabel() {
        return label;
    }

    LegendTitle getTitle() {
        return title;
    }

    Align getAlign() {
        return align;
    }

    public void setDisplay(Boolean display) {
        this.display = display;
    }

    public void setFullWidth(Boolean fullWidth) {
        this.fullWidth = fullWidth;
    }

    public void setReverse(Boolean reverse) {
        this.reverse = reverse;
    }

    public void setRtl(Boolean rtl) {
        this.rtl = rtl;
    }

    public void setPosition(Position position) {
        this.position = position;
    }

    public void setLabel(LegendLabel label) {
        this.label = label;
    }

    public void setTitle(LegendTitle title) {
        this.title = title;
    }

    public void setAlign(Align align) {
        this.align = align;
    }
}
