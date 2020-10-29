package hu.playmaker.common.factory.chartjs;


import hu.playmaker.common.factory.chartjs.common.Constants;
import hu.playmaker.common.factory.chartjs.common.enums.ChartType;

import java.util.Arrays;
import java.util.Objects;

public class BarChartBuilder extends ChartBuilder {

    private Data<BarDataSet> data;

    public BarChartBuilder() {
        this.setType(ChartType.bar);
    }

    public void setData(Data<BarDataSet> data) {
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
                    .put(Constants.label, d.getLabel())
                    .put(Constants.xAxisID, d.getxAxisID())
                    .put(Constants.yAxisID, d.getyAxisID())
                    .put(Constants.indexAxis, d.getIndexAxis())
                    .put(Constants.borderSkipped, d.getBorderSkipped())
                    .put(Constants.barPercentage, d.getBarPercentage())
                    .put(Constants.categoryPercentage, d.getCategoryPercentage())
                    .put(Constants.barThickness, d.getBarThickness())
                    .put(Constants.maxBarThickness, d.getMaxBarThickness())
                    .put(Constants.minBarLength, d.getMinBarLength())
                    .put(Constants.order, d.getOrder());
            dataSets.put(dataSet.convertJsonString());
        });
        dataObject.put(Constants.datasets, dataSets);
        JsonObject optionObject = new JsonObject();
        if(Objects.nonNull(getOptions())){
            Animation animation = getOptions().getAnimation();
            if(Objects.nonNull(animation)){
                JsonObject animationObject = new JsonObject();
                animationObject.put(Constants.debug, animation.getDebug());
                animationObject.put(Constants.delay, animation.getDelay());
                animationObject.put(Constants.duration, animation.getDuration());
                animationObject.put(Constants.easing, animation.getEasing());
                animationObject.put(Constants.loop, animation.getLoop());
                animationObject.put(Constants.mode, animation.getMode());
                optionObject.put(Constants.animation, animationObject);
            }
            if(Objects.nonNull(getOptions().getLegend())){
                JsonObject legendObject = new JsonObject();
                if(Objects.nonNull(getOptions().getLegend().getDisplay()))
                    legendObject.put("display", getOptions().getLegend().getDisplay());
                optionObject.put("legend", legendObject);
            }
            //TODO: Options implementation
        }
        config.put(Constants.type, getType().name())
                .put(Constants.data, dataObject)
                .put(Constants.options, optionObject);
        return config.convertJsonString();
    }
}
