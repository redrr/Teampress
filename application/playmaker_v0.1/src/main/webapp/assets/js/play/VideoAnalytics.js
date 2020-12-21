var isEdit = false;
var width, height;
var videoId;
var pos = [];
var mode = 'line';
var color = '#f3f3f3';
var bluePrintJSON;
var actionsTime = [];
var actionsId = [];

$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#table'));
        const video = $('#video')[0];
        video.oncanplay = function() {
            video.width = $('#videoHolder').width();
        };
        let pastTime = -1;
        video.ontimeupdate = function () {
            let shortCurrentTime = Math.round(video.currentTime);
            if (pastTime !== shortCurrentTime){
                pastTime = shortCurrentTime;
                if(!video.paused) {
                    console.log(actionsTime.includes(shortCurrentTime.toString()));
                    if(actionsTime.includes(shortCurrentTime.toString())) {
                        let action = actionsId[actionsTime.indexOf(shortCurrentTime.toString())];
                        loadLayerForViewer(action, false, false);
                    }
                }
            }
        }
        visibleLayer(false);
        $('#edit').on('click', function () {
            if(!isEdit){
                isEdit = true;
                let realTime = Math.round(video.currentTime);
                video.currentTime = getFreeTime(realTime);
                clearActionInputs();
                stopVideo();
                changeSidebar($('#actionsSidebar'), $('#recordActionSidebar'));
                initLayer('');
                visibleLayer(true);
            } else {
                console.log('ERROR - You are already in edit mode!')
            }
        });
        $('#clear').on('click', function () {
            if(bluePrintJSON !== ''){
                $.confirm({
                    title: 'Biztosan törlöd?',
                    content: 'Az akció tervezet örökre törlődni fog!',
                    type: 'red',
                    theme: 'supervan',
                    animation: 'zoom',
                    animationBounce: 1.5,
                    typeAnimated: true,
                    buttons: {
                        delete: {
                            text: 'Törlés',
                            btnClass: 'btn-red',
                            action: function() {
                                initLayer('');
                            }
                        },
                        cancel: {
                            text: 'Mégse',
                            btnClass: 'btn-blue',
                        }
                    }
                })
            }
        });
        $('#saveAction').on('click', function () {
            if(isEdit){
                $.post(
                    "/videoanalytics/recordAction",
                    {
                        id          :   $('#actionId').val(),
                        time        :   video.currentTime,
                        videoId     :   videoId,
                        bluePrint   :   bluePrintJSON,
                        name        :   $('#actionName').val(),
                        players     :   $('#actionPlayers').val(),
                        comment     :   $('#actionComment').val()
                    },
                    function (data) {
                        if(data === "")
                            clearLayerAndCloseEdit();
                        else
                            addError(data);
                    }
                )
            } else {
                console.log('ERROR - You are in view mode!')
            }
        });
        $('#cancelAction').on('click', function () {
            if(bluePrintJSON !== '') {
                $.confirm({
                    title: 'Biztosan visszalépsz?',
                    content: 'A nem mentett változtatások örökre el fognak veszni!',
                    type: 'red',
                    theme: 'supervan',
                    animation: 'zoom',
                    animationBounce: 1.5,
                    typeAnimated: true,
                    buttons: {
                        delete: {
                            text: 'Tovább',
                            btnClass: 'btn-red',
                            action: function() {
                                clearLayerAndCloseEdit();
                            }
                        },
                        cancel: {
                            text: 'Mégse',
                            btnClass: 'btn-blue',
                        }
                    }
                })
            } else {
                clearLayerAndCloseEdit();
            }
        });
        //$(window).keypress(function (e) {});
    });
});

function getFreeTime(time) {
    let realTime = time;
    while (true) {
        if(actionsTime.includes(realTime.toString())) {
            realTime++;
        } else {
            console.log(time+','+realTime);
            return realTime;
        }
    }
}

//Load video
function setupVideo(id, url ,teamId) {
    videoId = id;
    $.post(
        "/videoanalytics/getActionsAsArray",
        {
            videoId  :   videoId
        },
        function (actionsArray) {
            $('#analyzer').show();
            $('#tableCard').hide();
            $('#source').attr('src', '/content/videoAnalytics/upload/'+url);
            $('#video')[0].load();
            loadActionCards(actionsArray);
            let select = $('#actionPlayers');
            $.post(
                "/videoanalytics/getPlayers",
                {
                    id  :   teamId
                },
                function (teamPlayersArray) {
                    select[0].innerHTML = '';
                    let teamPlayers = JSON.parse(teamPlayersArray);
                    teamPlayers.forEach(function (player) {
                        select[0].innerHTML +=
                            "<option value='"+player.id+"'>"+player.name+"</option>"
                    });
                    select.trigger("change");
                }
            );
        }
    )
}

//region[region] Action
function initLayer(config) {
    bluePrintJSON = config;
    pos = [];
    var stage;
    if(config === ''){
        stage= new Konva.Stage({
            container: 'container',
            width: width,
            height: height
        });
    } else {
        stage = Konva.Node.create(config, 'container');
    }

    // add canvas element
    var layer = new Konva.Layer();
    stage.add(layer);
    layer.draw();

    // add cursor styling
    stage.on('click', function() {
        //log
        console.log(stage.getPointerPosition());
        //main
        if(isEdit) {
            pos.push(stage.getPointerPosition().x);
            pos.push(stage.getPointerPosition().y);
            if(mode === 'line') {
                var line = new Konva.Line({
                    points: pos,
                    stroke: color,
                    strokeWidth: 4,
                    lineCap: 'round',
                    lineJoin: 'round',
                });
                layer.add(line);
            }
            if(mode === 'arrow') {
                var arrow = new Konva.Arrow({
                    points: pos,
                    stroke: color,
                    strokeWidth: 4,
                    lineCap: 'round',
                    lineJoin: 'round',
                });
                layer.add(arrow);
            }
            if(mode === 'select') {
                if(pos.length === 2) {
                    var select = new Konva.RegularPolygon({
                        x: pos[0],
                        y: pos[1],
                        sides: 3,
                        radius: 8,
                        fill: color,
                        stroke: color,
                        strokeWidth: 4,
                        lineCap: 'round',
                        lineJoin: 'round',
                    });
                    layer.add(select);
                    pos = [];
                }
            }
            layer.draw();
            bluePrintJSON = stage.toJSON();
        } else {
            clearLayerAndCloseEdit();
            startVideo();
        }
    });

}

function loadLayerForViewer(id, forEdit, isEditView) {
    $.post(
        "/videoanalytics/getAction",
        {
            analyticsActionId  :   id
        },
        function (jsonString) {
            let object = JSON.parse(jsonString);
            isEdit = forEdit;
            if (isEditView) {
                changeSidebar($('#actionsSidebar'), $('#recordActionSidebar'));
            }
            let video = $('#video')[0];
            stopVideo();
            video.currentTime = object.time;
            $('#actionId').val(object.id);
            $('#actionName').val(object.name);
            $('#actionPlayers').val(object.player).trigger("change");
            $('#actionComment').val(object.comment);
            initLayer(object.data);
            visibleLayer(true);
        }
    )
}

function clearLayerAndCloseEdit() {
    isEdit = false;
    clearActionInputs();
    initLayer('');
    visibleLayer(false);
    let video = $('#video')[0];
    stopVideo();
    changeSidebar($('#recordActionSidebar'), $('#actionsSidebar'));
    $.post(
        "/videoanalytics/getActionsAsArray",
        {
            videoId  :   videoId
        },
        function (array) {
            loadActionCards(array);
        }
    )
}

function deleteAction(id, element, url) {
    $.confirm({
        title: 'Biztosan törlöd?',
        content: '',
        type: 'red',
        theme: 'supervan',
        animation: 'zoom',
        animationBounce: 1.5,
        typeAnimated: true,
        buttons: {
            delete: {
                text: 'Törlés',
                btnClass: 'btn-red',
                action: function() {
                    $.ajax({
                        url: url+"/del",
                        type: "POST",
                        data: {
                            analyticsActionId: id,
                        },
                        success: function () {
                            $.post(
                                "/videoanalytics/getActionsAsArray",
                                {
                                    videoId  :   videoId
                                },
                                function (array) {
                                    loadActionCards(array);
                                }
                            )
                        },
                    });
                }
            },
            cancel: {
                text: 'Mégse',
                btnClass: 'btn-blue',
            }
        }
    })
}
//endregion

//region[region] Helpers
function changeSidebar(from, to) {
    const hideCssClass = "highlight-sidebar-hidden";
    const tools = $('#analyticTools');
    from.addClass(hideCssClass);
    to.removeClass(hideCssClass);
    if(!isEdit)
        tools.addClass(hideCssClass);
    else
        tools.removeClass(hideCssClass);
}

function visibleLayer(isVisible) {
    let layer = $('#container');
    if(isVisible)
        layer.show()
    else
        layer.hide()
}

function loadActionCards(array) {
    let body = '';
    let jsonArray = JSON.parse(array);
    let holder = $('#actionsHolder');
    holder.mCustomScrollbar('destroy');
    holder[0].innerHTML = '';
    actionsTime = [];
    actionsId = [];
    jsonArray.forEach(function (val, i) {
        actionsTime.push(val.time);
        actionsId.push(val.id);
        let jsonObject = val;
        let randId = i;
        let minutes = Math.floor(jsonObject.time / 60);
        let seconds = jsonObject.time - minutes * 60;
        body =
            '<div id="'+randId+'" class="btn-soft bg-light m-1 p-1">\n' +
            '   <div class="row">\n' +
            '       <div class="col-6">\n' +
            '           <b class="text-left">'+minutes+':'+seconds+'</b>\n' +
            '       </div>\n' +
            '       <div class="col-6 pl-0">\n' +
            '           <div class="btn-group f-right" role="group">\n' +
            '               <button type="button" class="btn btn-dark btn-mini" onclick="loadLayerForViewer('+jsonObject.id+','+false+','+false+')" data-toggle="tooltip" data-placement="top" title="Megtekintés"><i class="ti-eye"></i></button>\n' +
            '               <button type="button" class="btn btn-dark btn-mini" onclick="loadLayerForViewer('+jsonObject.id+','+true+','+true+')" data-toggle="tooltip" data-placement="top" title="Szerkesztés"><i class="ti-pencil"></i></button>\n' +
            '               <button type="button" class="btn btn-danger btn-mini" onclick="deleteAction('+jsonObject.id+','+randId+',\'/videoanalytics\')" data-toggle="tooltip" data-placement="top" title="Törlés"><i class="ti-trash"></i></button>\n' +
            '           </div>' +
            '       </div>\n' +
            '       <div class="col-12">\n' +
            '           <p class="text-left">'+jsonObject.name+'</p>\n' +
            '       </div>\n' +
            '       <div class="col-12">\n' +
            '           <p class="text-left">Típus: Támadás</p>\n' +
            '       </div>\n' +
            '       <div class="col-12">\n' +
            '           <p class="text-left">Játékos: '+jsonObject.player+'</p>\n' +
            '       </div>\n' +
            '   </div>\n' +
            '</div>';
        holder[0].innerHTML += body;
        $('#actionsHolder button').tooltip();
    });
    setTimeout(function (){
        let video = $('#video');
        $('#actionsHolder').height(video.height() - 80);
        height = video.height()
        width = video.width();
        initLayer('');
    }, 300);
    setTimeout(function (){
        $('#actionsHolder').mCustomScrollbar({
            theme:"dark-thick",
            scrollInertia: 200
        });
    }, 300);
}

function changeColor(newColor) {
    color = newColor;
    $('#dropdown-2 i').css('color', newColor);
}

function clearActionInputs() {
    $('#actionId').val("");
    $('#actionName').val("");
    $('#actionPlayers').val("").trigger("change");
    $('#actionComment').val("");
}

function addError(message) {
    let error =
        "<div class=\"alert alert-danger background-danger\">\n" +
        "   <button type=\"button\" class=\"btn btn-icon\" data-dismiss=\"alert\" aria-label=\"Close\">\n" +
        "       <i class=\"ti-close\"></i>\n" +
        "   </button>\n" +
        "   "+message+"\n" +
        "</div>"
    $('#errorHolder').html(error);
}

function startVideo() {
    $('#video')[0].play();
}

function stopVideo() {
    $('#video')[0].pause();
}
//endregion