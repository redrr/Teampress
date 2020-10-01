package hu.playmaker.common.factory.chartjs;

public class Options {
    private Animation animation;
    private Layout layout;
    private Legend legend;
    private Title title;
    private Tooltip tooltip;

    Animation getAnimation() {
        return animation;
    }

    Layout getLayout() {
        return layout;
    }

    Legend getLegend() {
        return legend;
    }

    Title getTitle() {
        return title;
    }

    Tooltip getTooltip() {
        return tooltip;
    }

    public void setAnimation(Animation animation) {
        this.animation = animation;
    }

    public void setLayout(Layout layout) {
        this.layout = layout;
    }

    public void setLegend(Legend legend) {
        this.legend = legend;
    }

    public void setTitle(Title title) {
        this.title = title;
    }

    public void setTooltip(Tooltip tooltip) {
        this.tooltip = tooltip;
    }
}
