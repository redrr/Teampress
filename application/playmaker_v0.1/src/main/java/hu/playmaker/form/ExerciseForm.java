package hu.playmaker.form;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

public class ExerciseForm extends BaseForm {

    public Integer typeId;

    public String name;

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
