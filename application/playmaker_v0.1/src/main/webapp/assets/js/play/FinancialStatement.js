$(document).ready(function () {
    $().ready(function () {
        $('#date1').datetimepicker({
            format: 'YYYY-MM-DD',
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
        $('#date2').datetimepicker({
            format: 'YYYY-MM-DD',
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
    statchart();
});

function statchart() {
    var ctx = document.getElementById('plus').getContext('2d');
    $.post("/financial/statement/yeardata", {}, function (data) {
        console.log(data);
        var myChart = new Chart(ctx, JSON.parse(data));
    });
}

function exportData() {
    $('#close').click();
    window.location="/financial/statement/export/"+$('#date1').val()+"/"+$('#date2').val();
}