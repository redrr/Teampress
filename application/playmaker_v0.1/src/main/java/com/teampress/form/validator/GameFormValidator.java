package com.teampress.form.validator;

import com.teampress.form.GameForm;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public class GameFormValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.getSimpleName().equals(GameForm.class.getSimpleName());
    }

    @Override
    public void validate(Object target, Errors errors) {
        if(errors.hasErrors())  return;
        GameForm gameForm = (GameForm) target;
        if(gameForm.getDate().equals("")){
            errors.rejectValue("name", "", "Nem lett dátum megadva!");
        }
        if (gameForm.getEnemy().equals("")){
            errors.rejectValue("name", "", "Nem lett ellenfél megadva!");
        }
        if (gameForm.getPlace().equals("")){
            errors.rejectValue("name", "", "Nem lett helyszín megadva!");
        }
    }
}
