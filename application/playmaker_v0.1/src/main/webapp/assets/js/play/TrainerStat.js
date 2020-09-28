var trainerChartData;
var trainerChartDataConfig;
$(document).ready(function(){
    $('#trainerQueryBody').hide();
    $('#trainerSelect').select2();
    $('#trainerQueryOption').on('change', function () {
        $.post(
            "/statistics/query/gettrainerfords",
            {
                option : $('#trainerQueryOption').val(),
            },
            function (result) {
                if(result === ""){
                    console.log("Hibás diagram típus!")
                } else {
                    var r = JSON.parse(result);
                    var scale = "";
                    for(var i = 0; i < r.scale.length; i++){
                        scale +=
                            "<option value='"+r.scale[i]+"'>"+r.scale[i]+"</option>";
                    }
                    if(r.flag === true){
                        var scale = "";
                        for(var i = 0; i < r.scale.length; i++){
                            scale += "<option value='"+r.scale[i]+"'>"+r.scale[i]+"</option>";
                        }
                        $('#trainerQueryForduloFromHolder')[0].innerHTML = '<select id="trainerQueryForduloFrom" class="form-control">' +scale+ '</select>';
                        $('#trainerQueryForduloToHolder')[0].innerHTML = '<select id="trainerQueryForduloTo" class="form-control">' + scale + '</select>';
                    } else {
                        $('#trainerQueryForduloFromHolder')[0].innerHTML = '<input class="form-control" id="trainerQueryForduloFrom"/>';
                        $('#trainerQueryForduloFrom').datetimepicker({
                            format: 'YYYY/MM/DD',
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
                        $('#trainerQueryForduloToHolder')[0].innerHTML = '<input class="form-control" id="trainerQueryForduloTo"/>';
                        $('#trainerQueryForduloTo').datetimepicker({
                            format: 'YYYY/MM/DD',
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
                    }
                }
            }
        );
    });
});

function postTrainerQuery() {
    $('#trainerQueryBody').show();
    var players = "";
    const select = $('#trainerSelect').find(':selected');
    for(var i = 0; i< select.length; i++){
        players += select[i].value;
        if(i < select.length-1)
            players += ";";
    }
    const from = $('#trainerQueryForduloFrom').val();
    const to = $('#trainerQueryForduloTo').val();
    if(from <= to){
        $.post("/statistics/query/gettrainerstat",{option: $('#trainerQueryOption').val(), from: from, to: to, type: $('#trainerChartType').val(), player: players},function (result, s) {
            if(!(result === "")){
                trainerChartDataConfig = JSON.parse(result);
                if(!(trainerChartData===undefined)){
                    trainerChartData.destroy();
                }
                setTimeout(function () {
                    trainerChartData = new Chart($('#trainerChartHolder'), trainerChartDataConfig);
                    trainerChartData.update({
                        duration: 800,
                        easing: 'easeOutBounce'
                    });
                }, 200);
            }
        });
    } else {
        console.log("rossz from to");
    }
}