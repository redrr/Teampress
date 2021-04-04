package com.teampress.common.factory.chartjs;

import com.teampress.common.factory.chartjs.common.enums.BorderAlign;

public abstract class AreaTypeDataSet extends DataSet {

    private BorderAlign borderAlign;

    //region[Region] Setters

    public void setBorderAlign(BorderAlign borderAlign) {
        this.borderAlign = borderAlign;
    }

    //endregion

    //region [Region] Getters

    BorderAlign getBorderAlign() {
        return borderAlign;
    }

    //endregion
}
