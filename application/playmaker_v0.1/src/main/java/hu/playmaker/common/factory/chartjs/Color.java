package hu.playmaker.common.factory.chartjs;

import java.util.List;
import java.util.Objects;

public class Color {

    private Integer r, g, b;
    private Double a;

    private Color(){}

    public Color(Integer r, Integer g, Integer b, Double a) {
        this.r = r;
        this.g = g;
        this.b = b;
        this.a = a;
    }

    String getRGBA() {
        if (Objects.nonNull(this.r) && Objects.nonNull(this.g) && Objects.nonNull(this.b) && Objects.nonNull(this.a)) {
            return "rgba("+this.r+","+this.g+","+this.b+","+this.a+")";
        }
        return null;
    }

    static Color[] asArray(List<Color> colors) {
        Color[] result = new Color[]{};
        if(Objects.nonNull(colors)){
            result = new Color[colors.size()];
            for (int i = 0; i < colors.size(); i++) {
                result[i] = colors.get(i);
            }
        }
        return result;
    }
}
