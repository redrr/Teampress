var playerChartData;
var playerChartDataConfig;
//var month = ["Január", "Február", "Március", "Április", "Május", "Június", "Július", "Augusztus", "Szeptember", "Október", "November", "December"];
$(document).ready(function(){
    $('#playerQueryBody').hide();
    $('#yearHolder').hide();
    $('#playerSelect').select2();
    $('#playerQueryOption').on('change', function () {
        $('#typeSimpleData')[0].innerHTML = "<option value=''></option>;";
        $.post(
          "/statistics/query/getypes",
            {
                option : $('#playerQueryOption').val()
            },
            function (result) {
                if(result === ""){
                    console.log("Hibás diagram típus!")
                } else {
                    var r = JSON.parse(result);
                    var opt = "";
                    for( var i = 0; i < r.type.length; i++){
                        opt +=
                            "<option value='"+r.type[i]+"'>"+r.name[i]+"</option>";
                    }
                    $('#typeSimpleData')[0].innerHTML = opt;
                    if(r.liga === true){
                        $('#playerQueryLeagueLabel')[0].innerHTML = "Liga";
                    } else {
                        $('#playerQueryLeagueLabel')[0].innerHTML = "Csapat";
                        $('#playerQueryLeagueHolder').removeClass('col-2').addClass('col-1');
                        $('#playerQueryLeagueTitle').removeClass('col-2').addClass('col-1');
                    }
                    var lig = "<option>Válassz</option>";
                    for( var j = 0; j < r.ligaId.length; j++){
                        lig +=
                            "<option value='"+r.ligaId[j]+"'>"+r.ligaName[j]+"</option>";
                    }
                    $('#playerQueryLeague')[0].innerHTML = lig;
                    $('#playerQueryLeagueRule')[0].innerText = r.liga;
                }
            }
        );
    });
    $('#playerQueryLeague').on('change', function () {
        const ligaId = $('#playerQueryLeague').val();
        const rule = $('#playerQueryLeagueRule')[0].innerText;
        $.post(
            "/statistics/query/getplayerfords",
            {
                liga : ligaId,
                option : $('#playerQueryOption').val(),
                rule : rule
            },
            function (result) {
                if(result === ""){
                    console.log("Hibás diagram típus!")
                } else {
                    var r = JSON.parse(result);
                    if(r.flag === true){
                        var scale = "";
                        for(var i = 0; i < r.scale.length; i++){
                            scale += "<option value='"+r.scale[i]+"'>"+r.scale[i]+"</option>";
                        }
                        $('#fordulofromHolder')[0].innerHTML = '<select id="fordulofrom" class="form-control">' +scale+ '</select>';
                        $('#fordulotoHolder')[0].innerHTML = '<select id="forduloto" class="form-control">' + scale + '</select>';
                    } else {
                        $('#fordulofromHolder')[0].innerHTML = '<input class="form-control" id="fordulofrom"/>';
                        $('#fordulofrom').datetimepicker({
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
                        $('#fordulotoHolder')[0].innerHTML = '<input class="form-control" id="forduloto"/>';
                        $('#forduloto').datetimepicker({
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
        $.post(
            "/statistics/query/getplayers",
            {
                liga : ligaId,
                flag : rule
            },
            function (result) {
                if(result === ""){
                    console.log("Hibás diagram típus!")
                } else {
                    var r = JSON.parse(result);
                    var scale = "";
                    for(var i = 0; i < r.id.length; i++){
                        scale +=
                            "<option value='"+r.id[i]+"'>"+r.name[i]+"</option>";
                    }
                    const element = $('#playerSelect');
                    element[0].innerHTML  = scale;
                    element.select2();
                }
            }
        );
    });
});

function postPlayerQuery() {
    $('#playerQueryBody').show();
    var players = "";
    const select = $('#playerSelect').find(':selected');
    for(var i = 0; i< select.length; i++){
        players += select[i].value;
        if(i < select.length-1)
            players += ";";
    }
    const from = $('#fordulofrom').val();
    const to = $('#forduloto').val();
    const flag = $('#playerQueryLeagueRule')[0].innerText;
    if(from <= to){
        $.post("/statistics/query/getplayerstat",{flag: flag, option: $('#playerQueryOption').val(), from: from, to: to, liga: $('#playerQueryLeague').val(), type: $('#typeSimpleData').val(), player: players},function (result, s) {
            if(!(result === "")){
                playerChartDataConfig = JSON.parse(result);
                if(!(playerChartData===undefined)){
                    playerChartData.destroy();
                }
                setTimeout(function () {
                    playerChartData = new Chart($('#playerChartHolder'), playerChartDataConfig);
                    playerChartData.update({
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