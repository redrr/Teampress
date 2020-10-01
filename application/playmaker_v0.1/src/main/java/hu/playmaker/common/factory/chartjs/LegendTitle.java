package hu.playmaker.common.factory.chartjs;

public class LegendTitle {
    private Boolean display;
    private Font font;
    private Integer padding;
    private String text;

    Boolean getDisplay() {
        return display;
    }

    Font getFont() {
        return font;
    }

    Integer getPadding() {
        return padding;
    }

    String getText() {
        return text;
    }

    public void setDisplay(Boolean display) {
        this.display = display;
    }

    public void setFont(Font font) {
        this.font = font;
    }

    public void setPadding(Integer padding) {
        this.padding = padding;
    }

    public void setText(String text) {
        this.text = text;
    }
}
