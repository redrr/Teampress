package com.teampress.common.factory.chartjs;

import com.teampress.common.factory.chartjs.common.Constants;

import java.util.ArrayList;
import java.util.List;

class JsonArray {

    private List<Object> array = new ArrayList<>();
    private StringBuilder arrayStringBuilder = new StringBuilder();

    void put(Object object) {
       array.add(object);
    }

    List<Object> getArray() {
        return new ArrayList<>(array);
    }

    String getArrayAsString() {
        if(!array.isEmpty()) {
            this.arrayStringBuilder.append(Constants.startJsonArray);
            array.forEach(value -> {
                if(value instanceof String && !(((String) value).contains(Constants.startJsonObject) && ((String) value).contains(Constants.endJsonObject))) {
                    this.arrayStringBuilder.append(Constants.stringEscape).append(value).append(Constants.stringEscape).append(Constants.objectSeparator);
                }else if(value instanceof JsonArray){
                    this.arrayStringBuilder.append(((JsonArray) value).getArrayAsString()).append(Constants.objectSeparator);
                }else if(value instanceof JsonObject) {
                    this.arrayStringBuilder.append(((JsonObject) value).convertJsonString()).append(Constants.objectSeparator);
                } else {
                    this.arrayStringBuilder.append(value).append(Constants.objectSeparator);
                }
            });
            String result = this.arrayStringBuilder.toString();
            int index = result.length()-1;
            return result.substring(0,index) + Constants.endJsonArray;
        }
        return Constants.emptyJsonArray;
    }
}
