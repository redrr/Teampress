package hu.playmaker.form.validator;

import hu.playmaker.form.ExerciseForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import static java.util.Objects.isNull;

public class ExerciseFormValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.getSimpleName().equals(ExerciseForm.class.getSimpleName());
    }

    @Override
    public void validate(Object target, Errors errors) {
        if(errors.hasErrors())  return;
        ExerciseForm exerciseForm = (ExerciseForm) target;
        if(isNull(exerciseForm.getTypeId())){
            errors.rejectValue("name", "Nem lett megadva értékelés típus!");
        }
        if(exerciseForm.getName().equals("")){
            errors.rejectValue("name", "empty", "Nem lett megadva gyakorlatnév!");
        }
    }
}
