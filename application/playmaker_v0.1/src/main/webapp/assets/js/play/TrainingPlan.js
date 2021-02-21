var count = 0;

$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#trainingPlanTable'));
        $('#date').datetimepicker({
            format: 'YYYY/MM/DD/HH:mm',
            locale: 'hu',
            minDate: new Date(),
            icons: {
                time: "ti-alarm-clock",
                date: "ti-calendar",
                up: "ti-angle-up",
                down: "ti-angle-down",
                previous: "ti-angle-left",
                next: "ti-angle-right",
                today: "ti-calendar",
                clear: "ti-trash"
            }
        });
        handleEnter('form');
    });
});

function showTraining(id) {
    $.post("/training/plan/get", {id: id}, function (result) {
        console.log(JSON.parse(result));
        const value = JSON.parse(result);
        $('#date').val(value.date);
        $('#team').val(value.team).trigger("change");
        let holder = $('#exerciseHolder');
        holder[0].innerHTML += "";
        for(var i = 0; i < value.exercises.length; i++){
            let array = value.exercises[i].split(',');
            holder[0].innerHTML += addExerciseToList(array, value.time[i]);
        }
        $('#modifyTraining_id').val(id);
        updateExerciseList();
    });
}

function addExercise(exercise, duration) {
    let array = exercise.val().split(",");
    $('#exerciseHolder')[0].innerHTML += addExerciseToList(array, duration.val());
    $('#close').click()
    updateExerciseList();
}

function addExerciseToList(array, duration) {
    return "<div class=\"row my-2\">\n" +
    "   <input type='hidden' value='"+array[0]+","+duration+"'/>" +
    "   <div class=\"col-4\">\n" + array[1] + "</div>\n" +
    "   <div class=\"col-4\">\n" + array[2] + "</div>\n" +
    "   <div class=\"col-2\">\n" + duration + " perc</div>\n" +
    "   <div class=\"col-2\">\n"+
    "       <button style='margin-right: 6px;float: right;margin-top: -4px' class=\"btn btn-danger btn-mini\" onclick=\"$(this).parent().parent().remove()\">\n" +
    "           <i class=\"ti-trash\"></i>\n" +
    "       </button>\n" +
    "   </div>\n" +
    "</div>";
}

function updateExerciseList() {
    let exercises = $('#trainingData');
    exercises.val('');
    let inputs = $('#exerciseHolder input');
    for (let i = 0; i < inputs.length; i++) {
        let appender = exercises.val() === '' ? '' : ';';
        exercises.val(exercises.val()+appender+inputs[i].value);
    }
}

function delTrainging(id) {
    deleteEntry(id, '/training/plan');
}
