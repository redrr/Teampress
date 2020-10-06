var count = 0;

$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#trainingPlanTable'));
        $('.bmd-form-group').hide();
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
    $('.bmd-form-group').hide();
    $.post("/training/plan/get", {id: id}, function (result) {
        console.log(JSON.parse(result));
        const value = JSON.parse(result);
        $('#date').val(value.date);
        $('#team').val(value.team).trigger("change");
        for(var i = 0; i < value.exercises.length; i++){
            $("#exercise"+(i+1)).val(value.exercises[i]).trigger("change");
            $("#exercise"+(i+1)+"Time").val(value.time[i]);
            if($("#exerciserow"+(i+1)).css('display')==="none"){
                $('#add').click();
            }
        }
        $('#modifyTraining_id').val(id);
    });
}

function delTrainging(id) {
    deleteEntry(id, '/training/plan');
}

function shownext() {
    if(count < 19) {
        $('.bmd-form-group').get(count).removeAttribute("style");
        count++;
    }
    if(count === 19) {
        $('#add').prop('disabled', true);
    }
}