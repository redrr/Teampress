package hu.playmaker.common.factory.chartjs;

import hu.playmaker.common.factory.chartjs.common.Constants;
import hu.playmaker.common.factory.chartjs.common.enums.ChartType;

import java.util.Arrays;
import java.util.Objects;

public class RadarChartBuilder extends ChartBuilder {

    private Data<RadarDataSet> data;

    public RadarChartBuilder() {
        this.setType(ChartType.radar);
    }

    public void setData(Data<RadarDataSet> data) {
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
        data.getDatasets().forEach(lineDataSet -> {
            JsonObject dataSet = new JsonObject();
            if(lineDataSet.getData().length > 0) {
                JsonArray data = new JsonArray();
                Arrays.asList(lineDataSet.getData()).forEach(data::put);
                dataSet.put(Constants.data, data);
            }
            dataSet.put(Constants.backgroundColor, lineDataSet.getBackgroundColor())
                    .put(Constants.hoverBackgroundColor, lineDataSet.getHoverBackgroundColor())
                    .put(Constants.borderColor, lineDataSet.getBorderColor())
                    .put(Constants.hoverBorderColor, lineDataSet.getHoverBorderColor())
                    .put(Constants.borderWidth, lineDataSet.getBorderWidth())
                    .put(Constants.hoverBorderWidth, lineDataSet.getHoverBorderWidth())
                    .put(Constants.clip, lineDataSet.getClip())
                    .put(Constants.label, lineDataSet.getLabel())
                    .put(Constants.borderJoinStyle, lineDataSet.getBorderJoinStyle())
                    .put(Constants.hoverBorderJoinStyle, lineDataSet.getHoverBorderJoinStyle())
                    .put(Constants.borderCapStyle, lineDataSet.getBorderCapStyle())
                    .put(Constants.hoverBorderCapStyle, lineDataSet.getHoverBorderCapStyle())
                    .put(Constants.pointStyle, lineDataSet.getPointStyle())
                    .put(Constants.borderDash, lineDataSet.getBorderDash())
                    .put(Constants.hoverBorderDash, lineDataSet.getHoverBorderDash())
                    .put(Constants.borderDashOffset, lineDataSet.getBorderDashOffset())
                    .put(Constants.hoverBorderDashOffset, lineDataSet.getHoverBorderDashOffset())
                    .put(Constants.lineTension, lineDataSet.getLineTension())
                    .put(Constants.pointBorderWidth, lineDataSet.getPointBorderWidth())
                    .put(Constants.pointHoverBorderWidth, lineDataSet.getPointHoverBorderWidth())
                    .put(Constants.pointHitRadius, lineDataSet.getPointHitRadius())
                    .put(Constants.pointRadius, lineDataSet.getPointRadius())
                    .put(Constants.pointHoverRadius, lineDataSet.getPointHoverRadius())
                    .put(Constants.pointRotation, lineDataSet.getPointRotation())
                    .put(Constants.order, lineDataSet.getOrder())
                    .put(Constants.fill, lineDataSet.getFill())
                    .put(Constants.spanGaps, lineDataSet.getSpanGaps())
                    .put(Constants.showLine, lineDataSet.getShowLine())
                    .put(Constants.pointBackgroundColor, lineDataSet.getPointBackgroundColor())
                    .put(Constants.pointBorderColor, lineDataSet.getPointBorderColor())
                    .put(Constants.pointHoverBackgroundColor, lineDataSet.getPointHoverBackgroundColor())
                    .put(Constants.pointHoverBorderColor, lineDataSet.getPointHoverBorderColor());
            dataSets.put(dataSet);
        });
        dataObject.put(Constants.datasets, dataSets);
        JsonObject optionObject = new JsonObject();
        if(Objects.nonNull(getOptions())){
            Options options = getOptions();
            if(Objects.nonNull(options.getAnimation())) {

            }
            if(Objects.nonNull(options.getCircumference())) {

            }
            if(Objects.nonNull(options.getLayout())) {

            }
            if(Objects.nonNull(options.getLegend())) {
                JsonObject legendObject = new JsonObject();
                if(Objects.nonNull(options.getLegend().getDisplay()))
                    legendObject.put("display", options.getLegend().getDisplay());
                optionObject.put("legend", legendObject);
            }
            if(Objects.nonNull(options.getRotation())) {

            }
            if(Objects.nonNull(options.getScale())) {
                JsonObject scaleObject = new JsonObject();
                Scale scale = options.getScale();
                if(Objects.nonNull(scale.getBeginAtZero()))
                    scaleObject.put("beginAtZero", scale.getBeginAtZero());
                if(Objects.nonNull(scale.getMin()))
                    scaleObject.put("min", scale.getMin());
                if(Objects.nonNull(scale.getMax()))
                    scaleObject.put("max", scale.getMax());
                if(Objects.nonNull(scale.getStepSize()))
                    scaleObject.put("stepSize", scale.getStepSize());
                optionObject.put("scale", new JsonObject().put("ticks", scaleObject));
            }
            if(Objects.nonNull(options.getTitle())) {

            }
            if(Objects.nonNull(options.getTooltip())) {

            }
        }
        config.put(Constants.type, getType().name())
                .put(Constants.data, dataObject)
                .put(Constants.options, optionObject);
        return config.convertJsonString();
    }
}
