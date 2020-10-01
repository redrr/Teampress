package hu.playmaker.common.factory.chartjs;

import hu.playmaker.common.factory.chartjs.common.Constants;
import hu.playmaker.common.factory.chartjs.common.enums.ChartType;

import java.util.Arrays;
import java.util.Objects;

public class LineChartBuilder extends ChartBuilder {

    private Data<LineDataSet> data;

    public LineChartBuilder() {
        this.setType(ChartType.line);
    }

    public void setData(Data<LineDataSet> data) {
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
                    .put(Constants.pointHoverBorderColor, lineDataSet.getPointHoverBorderColor())
                    .put(Constants.stepped, lineDataSet.getStepped())
                    .put(Constants.cubicInterpolationMode, lineDataSet.getCubicInterpolationMode())
                    .put(Constants.xAxisID, lineDataSet.getxAxisID())
                    .put(Constants.yAxisID, lineDataSet.getyAxisID());
            dataSets.put(dataSet.convertJsonString());
        });
        dataObject.put(Constants.datasets, dataSets);
        config.put(Constants.type, getType().name())
                .put(Constants.data, dataObject);
        if(Objects.nonNull(getOptions())){
            JsonObject optionObject = new JsonObject();
            JsonObject animationObject = new JsonObject();
            Animation animation = getOptions().getAnimation();
            animationObject.put(Constants.debug, animation.getDebug());
            animationObject.put(Constants.delay, animation.getDelay());
            animationObject.put(Constants.duration, animation.getDuration());
            animationObject.put(Constants.easing, animation.getEasing());
            animationObject.put(Constants.loop, animation.getLoop());
            animationObject.put(Constants.mode, animation.getMode());
            optionObject.put(Constants.animation, animationObject);
            Layout layout = getOptions().getLayout();
            if(Objects.nonNull(optionObject))
                config.put(Constants.options, optionObject);
        }
        return config.convertJsonString();
    }
}
