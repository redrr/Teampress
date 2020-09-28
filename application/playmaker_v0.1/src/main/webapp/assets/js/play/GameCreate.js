$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#table'));
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
    });
});

function load(id) {
    $.post(
        "/game/get",
        {
            id: id
        },
        function (result) {
            console.log(JSON.parse(result));
            const json = JSON.parse(result);
            $('#id').val(json.id);
            $('#date').val(json.date);
            $('#team').val(json.teamId).trigger("change");
            $('#enemy').val(json.enemy);
            $('#place').val(json.place);
        }
    )
}