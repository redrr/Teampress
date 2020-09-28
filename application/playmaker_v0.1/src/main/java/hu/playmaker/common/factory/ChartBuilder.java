package hu.playmaker.common.factory;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Objects;

import static java.util.Objects.isNull;

public class ChartBuilder {

    private String type;
    private ArrayList<String> labels;
    private ArrayList<ChartData> dataSet;
    private ChartScale scaleOptions;
    private String[] colors = {
            "255,99,132",
            "44,61,80",
            "231,76,60",
            "238,100,86",
            "240,196,25",
            "209,220,72",
            "78,186,111",
            "118,232,186",
            "28,175,154",
            "5,242,155",
            "159,255,130",
            "70,179,157",
            "52,152,219",
            "143,216,255",
            "127,118,242",
            "149,91,165",
            "230,107,255",
            "178,18,124",
            "255,0,169",
            "255,205,86"
    };

    public String getColor(int i){
        return colors[i];
    }

    public ChartBuilder setType(String type){
        this.type = type;
        return this;
    }

    public ChartBuilder addLabel(String label){
        if(isNull(this.labels))
            this.labels = new ArrayList<>();
        this.labels.add(label);
        return this;
    }

    public boolean hasLabel(String label) {
        if(Objects.nonNull(labels)){
            return this.labels.contains(label);
        }
        return false;
    }

    public ChartBuilder addData(ChartData data){
        if(isNull(this.dataSet))
            this.dataSet = new ArrayList<>();
        this.dataSet.add(data);
        return this;
    }

    public ChartBuilder addScaleOption(ChartScale scaleOptions){
        this.scaleOptions = scaleOptions;
        return this;
    }

    public String build(){
        if(isNull(type)){
            System.out.println("Type is missing!");
            return null;
        }
        if(isNull(labels) || labels.size() < 1){
            System.out.println("Labels are missing for datas!");
            return null;
        }
        if(dataSet.isEmpty()){
            System.out.println("Dataset is empty!");
            return null;
        }
        JSONObject config = new JSONObject();
        try {
            JSONObject fullData = new JSONObject();
            JSONArray dataset = new JSONArray();
            JSONArray data, background, borderColor, pointBackgroundColor, labels;
            config.put("type", type);

            //region AddLabels
            labels = new JSONArray();
            for (String s : this.labels)
                labels.put(s);
            fullData.put("labels", labels);
            //endregion

            //region AddData
            for(ChartData chartData : dataSet){
                JSONObject object = new JSONObject();
                data = new JSONArray();
                background = new JSONArray();
                borderColor = new JSONArray();
                pointBackgroundColor = new JSONArray();
                if(!isNull(chartData.getLabel()))
                    object.put("label", chartData.getLabel());
                if(!isNull(chartData.getData())){
                    for (Object i : chartData.getData())
                        data.put(i);
                    object.put("data", data);
                }
                object.put("fill", chartData.isFill());
                object.put("lineTension", 0.1);
                if(!isNull(chartData.getBackgroundColor()) && chartData.getBackgroundColor().size() > 0){
                    if(chartData.getBackgroundColor().size() == 1){
                        object.put("backgroundColor", chartData.getBackgroundColor().get(0));
                    } else {
                        for (String s : chartData.getBackgroundColor()){
                            background.put(s);
                            object.put("backgroundColor", background);
                        }
                    }
                }
                if(!isNull(chartData.getBorderColor()) && chartData.getBorderColor().size() > 0){
                    if(chartData.getBorderColor().size() == 1) {
                        object.put("borderColor", chartData.getBorderColor().get(0));
                    } else {
                        for (String s : chartData.getBorderColor()){
                            borderColor.put(s);
                            object.put("borderColor", borderColor);
                        }
                    }
                }
                if(!isNull(chartData.getPointBackgroundColor()) && chartData.getPointBackgroundColor().size() > 0){
                    if(chartData.getPointBackgroundColor().size() == 1){
                        for (int i = 0; i < this.labels.size(); i++)
                            object.put("pointBackgroundColor", chartData.getPointBackgroundColor().get(0));
                    } else {
                        for (String s : chartData.getPointBackgroundColor()){
                            pointBackgroundColor.put(s);
                            object.put("pointBackgroundColor", pointBackgroundColor);
                        }
                    }
                }
                if(!isNull(object))
                    dataset.put(object);
            }
            fullData.put("datasets", dataset);
            config.put("data", fullData);
            //endregion

            //region AddOption
            JSONObject options = new JSONObject();
            options.put("responsive", true);
            options.put("showTooltips", true);
            if(!isNull(scaleOptions)){
                JSONObject scale = new JSONObject();
                JSONObject ticks = new JSONObject();
                ticks.put("beginAtZero", scaleOptions.beginAtZero);
                if(!isNull(scaleOptions.max))
                    ticks.put("max", scaleOptions.max);
                if(!isNull(scaleOptions.min))
                    ticks.put("min", scaleOptions.min);
                if(!isNull(scaleOptions.stepSize))
                    ticks.put("stepSize", scaleOptions.stepSize);
                scale.put("ticks", ticks);
                options.put("scale", scale);
            }
            JSONObject animation = new JSONObject();
            animation.put("easing", "linear");
            animation.put("duration", 500);
            options.put("animation", animation);
            config.put("options", options);
            //endregion
        } catch (Exception e){
            e.printStackTrace();
        }
        return config.toString();
    }
}
