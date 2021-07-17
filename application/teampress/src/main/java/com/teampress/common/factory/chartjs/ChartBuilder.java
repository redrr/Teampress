package com.teampress.common.factory.chartjs;

import com.teampress.common.factory.chartjs.common.enums.ChartType;

abstract class ChartBuilder implements IBuilder {

    private ChartType type;
    private Options options;

    void setType(ChartType type) {
        this.type = type;
    }

    public void setOptions(Options options) {
        this.options = options;
    }

    ChartType getType() {
        return type;
    }

    Options getOptions() {
        return options;
    }
}
