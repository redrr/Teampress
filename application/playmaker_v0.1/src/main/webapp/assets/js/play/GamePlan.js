var imageObj;
var flag;
var players = ["asd", "asdasd"];
var width, height, stage, layer, tween, postId, postX, postY, postAttendance;
$(document).ready(function () {
    flag = true;
    width = 550;
    height = 800;
    $('#planner').hide();
    createDataTable($('#sorsolasTable'));
    createDataTable($('#customTable'));
    createDataTable($('#completeTable'));
});

//region setup Map
function createStage() {
    stage = new Konva.Stage({
        container: 'container',
        width: width,
        height: height
    });
}

function setupLayer(id, url, x, y, size, dragable) {
    var imageObj = new Image();
    imageObj.src = '/content/profileImages/'+url;
    imageObj.onload = function () {
        var img = new Konva.Circle({
            id: id,
            name:'player',
            fillPatternImage: imageObj,
            fillPatternOffset: { x: -100, y: 80 },
            fillPatternScale:{ x: 0.375, y: 0.375},
            x: parseInt(x),
            y: parseInt(y),
            width: parseInt(size),
            height: parseInt(size),
            shadowColor: 'black',
            shadowBlur: 15,
            shadowOffset: { x: 15, y: 15 },
            shadowOpacity: 0.75,
            draggable: dragable
        });
        if(dragable){
            img.on('mouseover', function() {
                document.body.style.cursor = 'pointer';
            });
            img.on('mouseout', function() {
                document.body.style.cursor = 'default';
            });
        }
        layer.add(img);
        layer.batchDraw();
    }
}

function setupButtons(id, sors, type) {
    $('#r1'+id)[0].addEventListener(
        'click',
        function () {
            asd(id);
        },
        false
    );
    $('#r2'+id)[0].addEventListener(
        'click',
        function () {
            asd(id);
        },
        false
    );
    $('#r3'+id)[0].addEventListener(
        'click',
        function () {
            asd(id);
        },
        false
    );
    $('#saveTeam')[0].addEventListener(
        'click',
        function () {
            postId = '';
            postY = '';
            postX = '';
            postAttendance = '';
            const nodes = stage.find('.player');
            for(var i = 0; i < nodes.length; i++){
                const node = nodes[i];
                const id = node.id();
                const input1 = $('#r1'+id+'')[0];
                const input2 = $('#r2'+id+'')[0];
                const input3 = $('#r3'+id+'')[0];
                console.log(input1);
                var attend;
                if(input1.checked){
                   attend = '2';
                }
                if(input2.checked){
                    attend = '1';
                }
                if(input3.checked){
                    attend = '0';
                }
                postAttendance += attend;
                postId += id;
                if(node.width() > 0){
                    postX += node.absolutePosition().x;
                    postY += node.absolutePosition().y;
                } else {
                    postX += 'del';
                    postY += 'del';
                }
                if(i !== nodes.length){
                    postId += ';';
                    postY += ';';
                    postX += ';';
                    postAttendance += ';';
                }
            }
            if(flag === true){
                flag = false;
                $.post('/gameplan/setplayers', {playerId: postId, gameId: sors, gameType: type, x: postX, y: postY, attendance: postAttendance}, function (result) {
                    if(result === 'success'){
                        $('#teamPlayers').mCustomScrollbar('destroy');
                        setTimeout(function (){
                            window.location = "/gameplan";
                        }, 100);
                    }
                });
            }
        },
        false
    );
}

function asd(id) {
    var currentWidth, currentHeight;
    var shape = stage.find('#'+id)[0];
    if (tween) {
        tween.destroy();
    }
    if($('#player'+id)[0].checked){
        currentHeight = 60;
        currentWidth = 60;
    } else {
        currentHeight = 0;
        currentWidth = 0;
    }
    tween = new Konva.Tween({
        node: shape,
        duration: 0.5,
        width: currentWidth,
        height: currentHeight,
        easing: Konva.Easings.StrongEaseInOut,
    }).play();
}

function loadEditorForTrainer(sd, teamId, hazai, vendeg, sors, type){
    getPlayersByPlayer(sd, teamId, hazai, vendeg, sors, type, true)
}

function getPlayersByPlayer(data, teamId, hazai, vendeg, gameId, gameType, editor) {
    const element = $('#teamPlayers');
    element.mCustomScrollbar('destroy');
    element.empty();
    $('#title').text(hazai+" - "+vendeg);
    if(editor) {
        $('#statusBar').removeClass("col-2").addClass("col-3");
        $('#workoutButtonBar').show();
        $('#statusIcons').show();
    } else {
        $('#statusBar').removeClass("col-3").addClass("col-2");
        $('#statBar').removeClass("col-4").addClass("col-6");
        $('#workoutButtonBar').hide();
        $('#statusIcons').hide();
    }
    createStage();
    layer = new Konva.Layer();
    $.post("/gameplan/getplayers",{dd: data, teamId : teamId, sors: gameId, type: gameType}, function (playersJson) {
        const players = JSON.parse(playersJson);
        console.log(players);
        for(var i = 0; i < players.id.split(';').length; i++){
            var x = 40;
            var y = 40;
            var size = 0;
            var drag = true;
            if(!(players.x.split(';')[i] === '' && players.y.split(';')[i] === '')){
                x = players.x.split(';')[i];
                y = players.y.split(';')[i];
                size = 60;
                if(!editor){
                   drag = false;
                }
            }
            let id = players.id.split(';')[i];
            var status = players.attendanceType.split(';')[i];
            setupLayer(id, players.url.split(';')[i], x, y, size, drag);
            var body =
                "   <div class=\"row\" style='margin-bottom: 8px; padding-left: 16px'>" +
                "       <div class='col-1' style='padding: 4px'>" +
                "           <img alt=\"Image placeholder\" class=\"rounded-circle player-icon-sm\" src='/content/profileImages/"+players.url.split(';')[i]+"'>" +
                "       </div>" +
                "       <div class='col-3 col-form-label' style='padding-right: 0; padding-left: 0'>" +
                "           <label title='"+id+"' class=\"col-form-label\">"+players.name.split(';')[i]+"</label>" +
                "       </div>";
            if(editor){
                body += "<div class='col-3 col-form-label' style='text-align: center;padding-left: 0;padding-right: 0'>";
                body +=
                    "<div class=\"form-radio\">\n" +
                    "   <form class='row'>\n" +
                    "       <div style='padding: 5px' class=\"col-4 radio radiofill radio-primary\">\n" +
                    "           <label>\n" +
                    "               <input id='r1"+id+"' type=\"radio\" name=\"radio\" onclick='check("+id+")'>\n" +
                    "               <i class=\"helper\"></i>\n" +
                    "           </label>\n" +
                    "       </div>\n" +
                    "       <div style='padding: 5px' class=\"col-4 radio radiofill radio-default\">\n" +
                    "           <label>\n" +
                    "               <input id='r2"+id+"' type=\"radio\" name=\"radio\" onclick='undocheck("+id+")'>\n" +
                    "               <i class=\"helper\"></i>\n" +
                    "           </label>\n" +
                    "       </div>\n" +
                    "       <div style='padding: 5px' class=\"col-4 radio radiofill radio-danger\">\n" +
                    "           <label>\n" +
                    "               <input id='r3"+id+"' type=\"radio\" name=\"radio\" onclick='undocheck("+id+")'>\n" +
                    "               <i class=\"helper\"></i>\n" +
                    "           </label>\n" +
                    "       </div>\n" +
                    "   </form>\n" +
                    "</div>"+
                    "<label style='display: none' class=\"c-switch c-switch-label c-switch-pill c-switch-success col-form-label\">\n" +
                    "   <input id=\"player"+id+"\" class=\"c-switch-input\" type=\"checkbox\"><span class=\"c-switch-slider\"></span>\n" +
                    "</label>";
            } else {
                body += "<div class='col-2 col-form-label' style='text-align: center;padding-left: 0'>";
                if(status === '0'){
                    body +=
                        "<img style='max-width: 100%;height: 24px;padding: 4px;' class='' src='/content/icons/cancel_icon.png'>";
                }else if(status === '1'){
                    body +=
                        "<img style='max-width: 100%;height: 24px;padding: 4px;' class='' src='/content/icons/change_icon.png'>";
                }else if(status === '2'){
                    body +=
                        "<img style='max-width: 100%;height: 24px;' class='' src='/content/icons/shirt_icon.png'>";
                }
            }
            if(editor) {
                body +=
                    "   </div>" +
                    "   <div class='col-4'>";
            } else {
                body +=
                    "   </div>" +
                    "   <div class='col-6'>";
            }
            body +=
                "       <div class='row' style='padding-top: 5px'>"+
                "           <div class='col-4' data-toggle=\"tooltip\" data-placement=\"top\" title=\"\" data-original-title=\"Meccsek száma: "+players.meccsek.split(';')[i]+"\">"+
                "               <b>"+players.meccsek.split(';')[i]+"</b>"+
                "           </div>"+
                "           <div class='col-4' data-toggle=\"tooltip\" data-placement=\"top\" title=\"\" data-original-title=\"Kezdő volt: "+players.kezdo.split(';')[i]+"\">"+
                "               <b>"+players.kezdo.split(';')[i]+"</b>"+
                "           </div>"+
                "           <div class='col-4' data-toggle=\"tooltip\" data-placement=\"top\" title=\"\" data-original-title=\"Lőtt gólok száma: "+players.golok.split(';')[i]+"\">"+
                "               <b>"+players.golok.split(';')[i]+"</b>"+
                "           </div>"+
                "       </div>"+
                "   </div>";
            if(editor) {
                body +=
                    "<div class='col-1 p-0'>" +
                    "   <button class='btn btn-primary btn-icon float-right' data-toggle=\"modal\" data-target=\"#trainingModal\"  onclick='getLastWorkout("+id+")'><i style='margin: 0' class=\"ti-bar-chart\"></i></button>"+
                    "</div>";
            }
            element.append(body);
            $('div[data-toggle="tooltip"]').tooltip();
            if(editor){
                setupButtons(""+id, gameId, gameType);
                if(status === '2'){
                    $('#r1'+id+'')[0].checked = true;
                }else if(status === '0'){
                    $('#r3'+id+'')[0].checked = true;
                } else {
                    $('#r2'+id+'')[0].checked = true;
                }
            }
        }
    });
    stage.add(layer);
    setTimeout(function (){
        $('#teamPlayers').mCustomScrollbar({
            theme:"dark-thick",
            scrollInertia: 200
        });
    }, 300);
    window.scrollTo(0, 0);
    $('[data-toggle="tooltip"]').tooltip();
}
//endregion

function check(id) {
    $('#player'+id)[0].checked = true;
}

function undocheck(id) {
    $('#player'+id)[0].checked = false;
}

function getLastWorkout(id) {
    $('#trainingModal').hide();
    $.post(
        "/gameplan/lastworkout",
        {
            id: id
        },
        function (result) {
            destroy(workoutChart);
            modalBody(JSON.parse(result));
        }
    )
    $('#trainingModal').show();
}
