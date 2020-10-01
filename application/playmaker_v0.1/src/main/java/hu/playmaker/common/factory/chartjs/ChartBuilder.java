package hu.playmaker.common.factory.chartjs;

import hu.playmaker.common.factory.chartjs.common.enums.ChartType;

abstract class ChartBuilder implements IBuilder {

    private ChartType type;
    private Options options;

    void setType(ChartType type) {
        this.type = type;
    }

    void setOptions(Options options) {
        this.options = options;
    }

    ChartType getType() {
        return type;
    }

    Options getOptions() {
        return options;
    }
}
