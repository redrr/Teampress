package com.teampress.common.factory.chartjs;

import com.teampress.common.factory.chartjs.common.Constants;
import com.teampress.common.factory.chartjs.common.enums.ChartType;

import java.util.Arrays;

public class DoughnutAndPieChartBuilder extends ChartBuilder {

    private Data<DoughnutAndPieDataSet> data;

    public DoughnutAndPieChartBuilder() {
        this.setType(ChartType.doughnut);
    }

    public void setData(Data<DoughnutAndPieDataSet> data) {
        this.data = data;
    }

    @Override
    public String build() {
        JsonObject config = new JsonObject();
        JsonObject dataObject = new JsonObject();
        JsonArray labels = new JsonArray();
        data.getLabels().forEach(labels::put);
        dataObject.put(Constants.labels, labels);
        JsonArray dataSets = new JsonArray();
        data.getDatasets().forEach(d -> {
            JsonObject dataSet = new JsonObject();
            if (d.getData().length > 0) {
                JsonArray data = new JsonArray();
                Arrays.asList(d.getData()).forEach(data::put);
                dataSet.put(Constants.data, data);
            }
            dataSet.put(Constants.backgroundColor, d.getBackgroundColor())
                    .put(Constants.borderColor, d.getHoverBackgroundColor())
                    .put(Constants.hoverBackgroundColor, d.getBorderColor())
                    .put(Constants.hoverBorderColor, d.getHoverBorderColor())
                    .put(Constants.borderWidth, d.getBorderWidth())
                    .put(Constants.hoverBorderWidth, d.getHoverBorderWidth())
                    .put(Constants.clip, d.getClip())
                    .put(Constants.borderAlign, d.getBorderAlign())
                    .put(Constants.hoverOffset, d.getHoverOffset())
                    .put(Constants.offset, d.getOffset())
                    .put(Constants.weight, d.getWeight());
            dataSets.put(dataSet.convertJsonString());
        });
        dataObject.put(Constants.datasets, dataSets);
        JsonObject optionObject = new JsonObject();
        optionObject.put("circumference", getOptions().getCircumference());
        optionObject.put("rotation", getOptions().getRotation());
        //TODO: Options implementation
        config.put(Constants.type, getType().name())
                .put(Constants.data, dataObject)
                .put(Constants.options, optionObject);
        return config.convertJsonString();
    }
}
