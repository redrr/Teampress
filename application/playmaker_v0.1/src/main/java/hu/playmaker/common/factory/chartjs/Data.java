package hu.playmaker.common.factory.chartjs;

import java.util.ArrayList;
import java.util.List;

public class Data<T extends DataSet> {

    private List<String> labels = new ArrayList<>();
    private List<T> datasets = new ArrayList<>();

    public Data() {}

    public Data<T> addDataset(T dataset) {
        this.datasets.add(dataset);
        return this;
    }

    public void addLabel(String label) {
        this.labels.add(label);
    }

    List<String> getLabels() {
        return new ArrayList<>(labels);
    }

    List<T> getDatasets() {
        return new ArrayList<>(datasets);
    }
}
