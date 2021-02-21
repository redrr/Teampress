package hu.playmaker.form;

public class TrainingPlanForm extends BaseForm {

    public String date, data;
    public Integer team;


    //region Getter & Setter

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public Integer getTeam() {
        return team;
    }

    public void setTeam(Integer team) {
        this.team = team;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    //endregion

}
