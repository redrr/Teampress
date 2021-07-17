let count = 0;
let sortable;

$(document).ready(function () {
    $().ready(function () {
        createDataTable('trainingPlanTable');
        $('#date').datetimepicker({
            format: 'YYYY/MM/DD/HH:mm',
            locale: 'hu',
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
        holder[0].innerHTML = "";
        for(var i = 0; i < value.exercises.length; i++){
            let array = value.exercises[i].split(',');
            holder[0].innerHTML += addExerciseToList(array[3], array, value.time[i]);
        }
        $('#modifyTraining_id').val(id);
        updateExerciseList();
        sortable = new Sortable(holder[0], {
            animation: 250,
            onMove: function (evt, originalEvent) {
                updateExerciseList();
            }
        });
    });
}

function addExercise(exercise, duration) {
    let array = exercise.val().split(",");
    let holder = $('#exerciseHolder');
    holder[0].innerHTML += addExerciseToList("", array, duration.val());
    $('#close').click()
    updateExerciseList();
    sortable = new Sortable(holder[0], {
        animation: 250,
        onMove: function (evt, originalEvent) {
            updateExerciseList();
        }
    });
}

function removeExercise(exercise) {
    exercise.parent().parent().remove();
    sortable = new Sortable($('#exerciseHolder')[0], {
        animation: 250,
        onMove: function (evt, originalEvent) {
            updateExerciseList();
        }
    });
    let id = exercise.parent().parent().children(".id").val();
    if (id !== "") {
        $.ajax({
            url: "/training/plan/connection/del",
            type: "POST",
            data: {
                id: id,
            }
        });
    }
}

function addExerciseToList(id, array, duration) {
    return "<li class=\"row my-2 py-2 draggg\">\n" +
    "   <input class='id' type='hidden' value='"+id+"'/>" +
    "   <input type='hidden' value='"+array[0]+","+duration+"'/>" +
    "   <div class=\"col-2\"><i class=\"ti-move\"></i></div>\n" +
    "   <div class=\"col-3\">\n" + array[1] + "</div>\n" +
    "   <div class=\"col-3\">\n" + array[2] + "</div>\n" +
    "   <div class=\"col-2\">\n" + duration + " perc</div>\n" +
    "   <div class=\"col-2\">\n"+
    "       <button style='margin-right: 6px;float: right;margin-top: -4px' class=\"btn btn-danger btn-mini\" onclick=\"removeExercise($(this))\">\n" +
    "           <i class=\"ti-trash\"></i>\n" +
    "       </button>\n" +
    "   </div>\n" +
    "</li>";
}

function updateExerciseList() {
    setTimeout(function () {
        let exercises = $('#trainingData');
        exercises.val('');
        let inputs = $('#exerciseHolder input');
        for (let i = 0; i < inputs.length; i++) {
            let appender = exercises.val() === '' ? '' : ';';
            exercises.val(exercises.val()+appender+inputs[i].value);
        }
        console.log(exercises.val())
    }, 500);
}

function delTrainging(id) {
    deleteEntry(id, '/training/plan');
}
