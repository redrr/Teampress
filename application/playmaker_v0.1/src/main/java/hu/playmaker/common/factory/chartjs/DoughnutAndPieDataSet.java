package hu.playmaker.common.factory.chartjs;

public class DoughnutAndPieDataSet extends AreaTypeDataSet {

    private Integer hoverOffset, offset, weight;

    //region[Region] Setters

    public void setHoverOffset(Integer hoverOffset) {
        this.hoverOffset = hoverOffset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    //endregion

    //region [Region] Getters

    Integer getHoverOffset() {
        return hoverOffset;
    }

    Integer getOffset() {
        return offset;
    }

    Integer getWeight() {
        return weight;
    }

    //endregion
}
