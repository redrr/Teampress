package hu.playmaker.common.factory.chartjs;


import hu.playmaker.common.factory.chartjs.common.Constants;
import hu.playmaker.common.factory.chartjs.common.enums.ChartType;

import java.util.Arrays;

public class BubbleChartBuilder extends ChartBuilder {

    private Data<BubbleDataSet> data;

    public BubbleChartBuilder() {
        this.setType(ChartType.bar);
    }

    public void setData(Data<BubbleDataSet> data) {
        this.data = data;
    }

    @Override
    public String build() {
        JsonObject config = new JsonObject();
        JsonObject dataObject = new JsonObject();
        JsonArray labels = new JsonArray();
        data.getLabels().forEach(labels::put);
        dataObject.put(Constants.labels, labels.toString());
        JsonArray dataSets = new JsonArray();
        data.getDatasets().forEach(d -> {
            JsonObject dataSet = new JsonObject();
            if (d.getData().length > 0) {
                JsonArray data = new JsonArray();
                Arrays.asList(d.getData()).forEach(data::put);
                dataSet.put(Constants.data, data.toString());
            }
            dataSet.put(Constants.backgroundColor, d.getBackgroundColor())
                    .put(Constants.borderColor, d.getHoverBackgroundColor())
                    .put(Constants.hoverBackgroundColor, d.getBorderColor())
                    .put(Constants.hoverBorderColor, d.getHoverBorderColor())
                    .put(Constants.borderWidth, d.getBorderWidth())
                    .put(Constants.hoverBorderWidth, d.getHoverBorderWidth())
                    .put(Constants.clip, d.getClip())
                    .put(Constants.label, d.getLabel())
                    .put(Constants.pointStyle, d.getPointStyle())
                    .put(Constants.hoverRadius, d.getHoverRadius())
                    .put(Constants.hitRadius, d.getHitRadius())
                    .put(Constants.rotation, d.getRotation())
                    .put(Constants.radius, d.getRadius())
                    .put(Constants.order, d.getOrder());
            dataSets.put(dataSet);
        });
        JsonObject optionObject = new JsonObject();
        //TODO: Options implementation
        config.put(Constants.type, getType().name())
                .put(Constants.data, dataObject)
                .put(Constants.options, optionObject);
        return config.toString();
    }
}
