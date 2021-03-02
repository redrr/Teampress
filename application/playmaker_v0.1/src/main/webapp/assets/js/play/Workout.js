var json;
var id;
$(document).ready(function() {
    $('#date1').datetimepicker({
        format: 'YYYY-MM-DD',
        locale: 'hu',
        maxDate: new Date(),
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
        maxDate: new Date(),
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
    createDataTable($('#OwnerTrainingsTable'));
    createDataTable($('#trainingsTable'));
    createDataTablePlus($('#trainingPlanTable'), {ordering : true, searching : true, responsive : true, order: [[ 0, 'asc' ]]});
    const rangevalue = $('.rangevalue');
    const range = $('#range');
    range.val(0);
    rangevalue.html(range.val());
    range.on('input change', () => {
        rangevalue.html(range.val());
    });

    const percentvalue = $('.percentvalue');
    const percent = $('#percent');
    percent.val(0);
    percentvalue.html(percent.val());
    percent.on('input change', () => {
        percentvalue.html(percent.val());
    });

    $('#content').hide();

    const playerColumns = $('.playerColumn');
    for(let i = 0; i < playerColumns.length; i++){
        const teamId = playerColumns[i].title;
        $.post("/training/workout/getPlayers", {team: teamId}, function (players) {
            playerColumns[i].empty;
            let select = "";
            var playerList = players.split(';');
            playerList.forEach(function (player) {
                if(player !== ""){
                    var id = player.split(',')[0];
                    var Pname = player.split(',')[1];
                    select +=
                        "<option value=\""+id+"\">"+Pname+"</option>\n";
                }
            });
            playerColumns[i].innerHTML = select;
        })
    }

    const statuses = $('.status');
    for(let i = 0; i < statuses.length; i++){
        const tr = statuses[i].title;
        $.post("/training/workout/status", {id: tr}, function (stat) {
            var status = JSON.parse(stat);
            statuses[i].innerHTML = "<h5><span class=\"badge badge-pill badge-"+status.css+"\">"+status.val+"</span></h5>";
        })
    }

    const progress = $('.start-progress');
    const button = $('.start-progress-btn');
    for(let i = 0; i < progress.length; i++) {
        const data = progress[i].title;
        $.post("/training/workout/status", {id: data}, function (stat) {
            var status = JSON.parse(stat);
            if(status.val === "Értékelve"){
                progress[i].innerHTML = "<h5><span class=\"badge badge-pill badge-"+status.css+"\">"+status.val+"</span></h5>";
            }
        });
    }
});

function pushResult(){
    var toSend = "";
    const dot = ",";
    const split = ";";
    for(var i  = 0; i < $('.jelen').length; i++) {
        toSend += $('.jelen .jelenname')[i].title + dot;
        toSend += $('.jelen .jelenval')[i].title + dot;
        for (var j = 0; j < $('.exercise').length; j++){
            toSend += $('#exercise'+j+'')[0].title + ":";
            let result = "";
            const selector = $('#exercise' + j + ' .p' + i + ' :input');
            for(var k = 0; k < selector.length; k++){
                result += selector[k].value;
                if(k + 1 < selector.length){
                    result += "/";
                }
            }
            console.log('exercise id: '+$('#exercise'+j+'')[0].title+';  data: '+result);
            toSend += result + dot;
        }
        toSend += split;
    }
    $.post("/training/workout/post", {id: id, data: toSend}, function (training) {});
    window.location="/training/workout";
}

function toshow(checkbox, id) {
    if(!(checkbox === 'jelen')){
        id.hide()
    } else {
        id.show()
    }
}

function getTrainingConsole(trainingId, teamId, teamName) {
    const navBar = $('#trainingNav');
    const bodyObj = $('#trainingBody');
    id = trainingId;
    navBar.empty();
    navBar.append(
        "<li class=\"nav-item\">" +
        "   <a class=\"nav-link active\" data-toggle=\"tab\" href=\"#jelen\">Jelenléti ív</a>\n" +
        "</li>"
    );
    bodyObj.empty();
    bodyObj.append(
        "<div id=\"jelen\" class=\"tab-pane active\"></div>"
    );
    $.post("/training/workout/get", {id: trainingId, team: teamId}, function (training) {
        training = JSON.parse(training);
        setTitle(teamName);
        setJelenleti(training.players.split(';'), training.profile);
        setExercises(training.exercises.split(';'), training.players.split(';'), navBar, bodyObj, training.profile);
        $('#content').show();
        $('.tr-table').hide();
        $('.start-progress-btn').hide();
        $('.all_number').hide();
        $('.starinput').hide();
        $('.exercise .tohide').hide();
        window.scrollTo(0);
    });
}

function setTitle(team) {
    const trainingTitle = $('#trainingTitle');
    trainingTitle.text("");
    trainingTitle.text(team+" csapat edzése");
}

function setJelenleti(playerList, profile) {
    var jelen =
        "<div class=\"form-horizontal\">" +
        "   <div class='row' style='margin-right: 0; margin-left: 0; width: 100%'>";
    const jelenObj = $('#jelen');
    jelenObj.empty();
    playerList.forEach(function (value, i) {
        jelen +=
            "<div class=\"col-4 jelen\">\n" +
            "   <div class=\"row\" style='margin-top: 16px'>\n" +
            "       <div class='col-2' style='padding: 0'>\n" +
            "           <img alt=\"Image placeholder\" class=\"col-form-label rounded-circle player-icon-sm\" src='/content/profileImages/"+profile[i]+"'>\n" +
            "       </div>\n" +
            "       <div class='col-6' style='padding: 0; padding-left: 10px'>\n" +
            "           <label for='player"+value.split(',')[0]+"' title='"+value.split(',')[0]+"' class=\"col-form-label jelenname\">"+value.split(',')[1]+"</label>" +
            "       </div>\n" +
            "       <div class='col-4 col-form-label' style='padding: 0'>\n" +
            "           <div class=\"dropdown-secondary dropdown f-right\" style='padding-right: 16px; padding-top: 8px'>\n" +
            "               <button title='2' class=\"btn btn-danger btn-mini dropdown-toggle waves-effect waves-light jelenval\" type=\"button\" id=\"dropdown"+value.split(',')[0]+"\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">Igazolatlan</button>\n" +
            "               <div class=\"dropdown-menu\" aria-labelledby=\"dropdown6\" data-dropdown-in=\"fadeIn\" data-dropdown-out=\"fadeOut\">\n" +
            "                   <button class=\"dropdown-item waves-light waves-effect\" onclick=\"changeButton($('#dropdown"+value.split(',')[0]+"'), 'Igazolatlan', 'btn-danger', 2, "+i+");toshow('false', $('.play-"+i+"'));\"><span class=\"point-marker bg-danger\"></span>Igazolatlan</button>\n" +
            "                   <button class=\"dropdown-item waves-light waves-effect\" onclick=\"changeButton($('#dropdown"+value.split(',')[0]+"'), 'Igazolt', 'btn-info', 1, "+i+");toshow('true', $('.play-"+i+"'));\"><span class=\"point-marker bg-info\"></span>Igazolt</button>\n" +
            "                   <button class=\"dropdown-item waves-light waves-effect\" onclick=\"changeButton($('#dropdown"+value.split(',')[0]+"'), 'Jelen', 'btn-primary', 0, "+i+");toshow('jelen', $('.play-"+i+"'));\"><span class=\"point-marker bg-primary\"></span>Jelen</button>\n" +
            "               </div>\n" +
            "           </div>\n" +
            "       </div>\n" +
            "   </div>"+
            "</div>";
    });
    jelen +=
        "   </div>" +
        "</div>";
    jelenObj.append(jelen);
}

function setExercises(exerciseList, playerList, navBar, bodyObj, profile) {
    exerciseList.forEach(function (exercise, index) {
        var id = exercise.split(',')[0];
        var type = exercise.split(',')[1];
        var name = exercise.split(',')[2];
        var nav =  "<li class=\"nav-item\">\n" +
            "   <a class=\"nav-link\" data-toggle=\"tab\" href=\"#exercise"+index+"\" role='tab'>"+ name + "</a>\n" +
            "</li>";
        navBar.append(nav);
        var body =
            "<div title='"+id+"' id=\"exercise"+index+"\" class=\"tab-pane exercise\">" +
            "   <div class=\"form-horizontal \">";
        if(type === 'Sikeres/darabszám'){
            body +=
                "   <div class='form-row'>" +
                "       <div class='col-10'></div>" +
                "       <div class='col-1'>" +
                "           <label class=\"col-form-label\" for=\"all_number\">Összes:</label>\n" +
                "       </div>" +
                "       <div class='col-1 '>" +
                "           <input class=\"form-control\" onchange=\"$('.all_number').val($(this).val())\" value='1' id=\"all_number\" type=\"number\" min=\"1\" max=\"1000\">\n" +
                "       </div>" +
                "   </div>" +
                "<hr>";
        }
            body +=
            "       <div class='row'>";
        playerList.forEach(function (playerName, i) {
            body +=
                "<div class=\"col-6 form-group tohide play-"+i+"\">" +
                "   <div class='row'>" +
                "       <div class='col-2' style='padding: 0'>" +
                "           <img alt=\"Image placeholder\" class=\"col-form-label rounded-circle player-icon-sm\" src='/content/profileImages/"+profile[i]+"'>" +
                "       </div>" +
                "       <div class='col-3' style='padding: 0; padding-left: 10px; overflow: hidden'>" +
                "           <label class=\"col-form-label\">"+playerName.split(',')[1]+"</label>"+
                "       </div>"+
                "       <div class='col-7'>";
                if(type === 'Csillagok'){
                        body += "<div class=\"rate col-form-label exerciseresult"+index+"\">\n" +
                        "   <input type=\"checkbox\" id=\"star5"+i+"\" name=\"rate\" value=\"5\" onchange=\"$('#star-inp-"+i+"')[0].value = 5\"/>\n" +
                        "   <label for=\"star5"+i+"\" title=\"star5\">5 stars</label>\n" +
                        "   <input type=\"checkbox\" id=\"star4"+i+"\" name=\"rate\" value=\"4\" onchange=\"$('#star-inp-"+i+"')[0].value = 4\"/>\n" +
                        "   <label for=\"star4"+i+"\" title=\"star4\">4 stars</label>\n" +
                        "   <input type=\"checkbox\" id=\"star3"+i+"\" name=\"rate\" value=\"3\" onchange=\"$('#star-inp-"+i+"')[0].value = 3\"/>\n" +
                        "   <label for=\"star3"+i+"\" title=\"star3\">3 stars</label>\n" +
                        "   <input type=\"checkbox\" id=\"star2"+i+"\" name=\"rate\" value=\"2\" onchange=\"$('#star-inp-"+i+"')[0].value = 2\"/>\n" +
                        "   <label for=\"star2"+i+"\" title=\"star2\">2 stars</label>\n" +
                        "   <input type=\"checkbox\" id=\"star1"+i+"\" name=\"rate\" value=\"1\" onchange=\"$('#star-inp-"+i+"')[0].value = 1\"/>\n" +
                        "   <label for=\"star1"+i+"\" title=\"star1\">1 star</label>" +
                        "<div class=' p"+i+"'>" +
                        "   <input value='0' type=\"text\" class='starinput' id='star-inp-"+i+"'>" +
                        "</div>" +
                        "</div>";
                }
                if(type === 'Szöveges értékelés'){
                    body +=
                        "<div class=\"col-12 p"+i+" exerciseresult"+index+"\">\n" +
                        "   <input class=\"form-control\" id=\"text-rating"+i+"\" type=\"text\" name=\"text-rating\" placeholder=\"Értékelés\"  maxlength=\"255\"/>\n" +
                        "</div>";
                }
                if(type === '1-10 -es skála'){
                    body += "<div class=\"d-flex justify-content-center my-2 p"+i+" exerciseresult"+index+" row\">\n" +
                        "   <div class=\"col-10\">\n" +
                        "       <input type=\"range\" class=\"custom-range\" value='0' onchange=\"$('#ex"+index+"rangevalue"+i+"').text($(this).val())\" id=\"range"+i+"\" min=\"0\" max=\"10\" step=\"1\"/>\n" +
                        "   </div>\n" +
                        "   <span class=\"col-2 font-weight-bold text-primary rangevalue p-0\" id='ex"+index+"rangevalue"+i+"'>0</span>\n" +
                        "</div>";
                }
                if(type === 'Százalék'){
                    body +=
                        "<div class=\"d-flex justify-content-center my-2 p"+i+" exerciseresult"+index+" row\">\n" +
                        "   <div class=\"col-10\">\n" +
                        "       <input type=\"range\" class=\"custom-range\"  onchange=\"$('#ex"+index+"percentvalue"+i+"').text($(this).val()+' %')\" value='0' id=\"percent"+i+"\" min=\"0\" max=\"100\"/>\n" +
                        "   </div>\n" +
                        "   <span class=\"col-2 font-weight-bold text-primary percentvalue p-0\" id='ex"+index+"percentvalue"+i+"'>0</span>\n" +
                        "</div>";
                }
                if(type === 'Sikeres/darabszám'){
                    body +=
                        "<div class=\"row p"+i+" exerciseresult"+index+"\">\n" +
                        "   <div class=\"col-3\">\n" +
                        "       <label class=\"col-form-label\" for=\"success"+i+"\">Sikeres:</label>\n" +
                        "   </div>\n" +
                        "   <div class=\"col-6\">\n" +
                        "       <input class=\"form-control\" value='0' id=\"success"+i+"\" type=\"number\" min=\"0\" max=\"1000\">\n" +
                        "   </div>\n" +
                        "       <input class=\"form-control all_number\" value='0' id=\"all_number"+i+"\" type=\"number\" min=\"0\" max=\"1000\">\n" +
                        "</div>";
                }
            body +=
                "       </div>"+
                "   </div>"+
                "</div>";
        });
        body +=
            "       </div>" +
            "   </div>" +
            "</div>";
        bodyObj.append(body);
    });
}

function change(value, text) {

}

function changeButton(element, text, className, title, playerId) {
    element[0].title = title;
    element.removeClass('btn-primary').removeClass('btn-info').removeClass('btn-danger');
    element.text(text);
    element.addClass(className);
    if(title === 0) {
        let player = $('.exercise .play-'+playerId);
        player.show();
        player.removeClass().addClass("col-6 form-group tohide play-"+playerId);
    }
}

function starSettings(id, val) {
    $('#star1').val("");
    $('#star2').val("");
    $('#star3').val("");
    $('#star4').val("");
    $('#star5').val("");
    $('#'+id).val(val);
}

function setupTrainingModal(id, date, playerId) {
    const tile = $('#trainingModalTitle');
    const body = $('#trainingModalBody');
    tile.empty();
    body.empty();
    tile.text(date);
    $.post("/training/workout/getModalData", {id: id, playerId: playerId[0].selectedOptions[0].value}, function (jsonTrainingData) {
        const trainingData = JSON.parse(jsonTrainingData);
        console.log(trainingData);
        $('#chartholder')[0].innerHTML = "<canvas id=\"trainingStat\" width=\"400\" height=\"400\"></canvas>";
        modalBody(trainingData);
        $('#trainingModalBody').height($('#trainingStat').height());
    });
}

function setupTrainingModalForPlayer(id, date) {
    const tile = $('#trainingModalTitle');
    tile.empty();
    tile.text(date);
   $.post("/training/workout/getModalDataForPlayer", {id: id}, function (jsonTrainingData) {
        const trainingData = JSON.parse(jsonTrainingData);
        console.log(jsonTrainingData);
        modalBody(trainingData);
    });
}

function ignoreTraining() {
    $.confirm({
        title: 'Biztosan bezárod?',
        content: 'A nem mentett változtatások elfognak veszni!',
        type: 'red',
        theme: 'supervan',
        animation: 'zoom',
        animationBounce: 1.5,
        typeAnimated: true,
        buttons: {
            delete: {
                text: 'Bezárás',
                btnClass: 'btn-red',
                action: function() {
                    window.location="/training/workout";
                }
            },
            cancel: {
                text: 'Mégse',
                btnClass: 'btn-grey',
            }
        }
    })
}

function saveTraining() {
    $.confirm({
        title: 'Biztosan mented?',
        content: 'Az elmentett edzésmunkák újból nem értékelhetők!',
        type: 'red',
        theme: 'supervan',
        animation: 'zoom',
        animationBounce: 1.5,
        typeAnimated: true,
        buttons: {
            delete: {
                text: 'Mentés',
                btnClass: 'btn-green',
                action: function() {
                    pushResult();
                }
            },
            cancel: {
                text: 'Mégse',
                btnClass: 'btn-grey',
            }
        }
    })
}

function exportData() {
    $('#closeModal').click();
    window.location="/training/workout/export/"+$('#team').val()+"/"+$('#date1').val()+"/"+$('#date2').val();
}
