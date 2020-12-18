var isplaying = false;
var isEdit = false;
var width, height;
var videoId;
var pos = [];
var mode = 'line';
var color = '#fff';
var bluePrintJSON;
$(document).ready(function () {
    $().ready(function () {
        //Setup
        createDataTable($('#table'));
        const video = $('#video')[0];
        video.oncanplay = function() {
            video.width = $('#videoHolder').width();
        };
        $('#container').hide();
        //Control
        $(window).keypress(function (e) {
            if (e.key === ' ' || e.key === 'Spacebar') {
                // ' ' is standard, 'Spacebar' was used by IE9 and Firefox < 37
                e.preventDefault();
                if(!isplaying){
                    isplaying = true;
                    video.play();
                } else {
                    isplaying = false;
                    video.pause();
                }
            }
        });
        $('#edit').on('click', function () {
            if(!isEdit){
                isEdit = true;
                video.pause();
                video.controls = false;
                changeSidebar($('#actionsSidebar'), $('#recordActionSidebar'));
                $('#container').show();
                initLayer('');
            } else {
                console.log('ERROR - Need to change sidebar!')
            }
        });
        $('#clear').on('click', function () {
            //TODO: Confirm.js
            initLayer('');
        });
        $('#saveAction').on('click', function () {
            if(isEdit){
                $.post(
                    "/videoanalytics/recordAction",
                    {
                        time        :   video.currentTime,
                        videoId     :   videoId,
                        bluePrint   :   bluePrintJSON
                    },
                    function () {
                        clearLayerAndCloseEdit();
                    }
                )
            } else {
                console.log('ERROR - Need to change sidebar!')
            }
        });
        $('#cancelAction').on('click', function () {
            if(isEdit){
                //TODO: Confirm.js
                clearLayerAndCloseEdit();
            } else {
                console.log('ERROR - Need to change sidebar!')
            }
        });
    });
});

//Create Analyzer
function initLayer(config) {
    bluePrintJSON = "";
    pos = [];
    var stage;
    if(config === ''){
        stage= new Konva.Stage({
            container: 'container',
            width: width,
            height: height
        });
    } else {
        stage = Konva.Node.create(json, 'container');
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
        }
    });

}

function clearLayerAndCloseEdit() {
    initLayer('');
    isEdit = false;
    let video = $('#video');
    video.play();
    video.controls = true;
    changeSidebar($('#recordActionSidebar'), $('#actionsSidebar'));
    $('#container').hide();
}

function loadLayerForViewer(id) {
    $.post(
        "/videoanalytics/getActionBlueprint",
        {
            id  :   id
        },
        function (jsonString) {
            initLayer(jsonString)
        }
    )
}

//Load video
function setupVideo(id,url) {
    videoId = id;
    $.post(
        "/videoanalytics/getActionsAsArray",
        {
            videoId  :   videoId
        },
        function (array) {
            let body = '';
            console.log(array);
            let jsonArray = array;
            var holder = $('#actionsHolder');
            holder[0].innerHTML = '';
            jsonArray.forEach(function (val) {
                console.log(val);
                let jsonObject = JSON(val);
                body =
                    '<button class="btn btn-light btn-soft m-1 p-1" onclick="loadLayerForViewer('+jsonObject.id+')">\n' +
                    '   <div class="row">\n' +
                    '       <div class="col-4">\n' +
                    '           <b>'+jsonObject.time+'</b>\n' +
                    '       </div>\n' +
                    '       <div class="col-8">\n' +
                    '           <p class="text-left">Teszt akció</p>\n' +
                    '       </div>\n' +
                    '       <div class="col-12">\n' +
                    '           <p class="text-left">Típus: Támadás</p>\n' +
                    '       </div>\n' +
                    '       <div class="col-12">\n' +
                    '           <p class="text-left">Játékos: Faragó Sámuel</p>\n' +
                    '       </div>\n' +
                    '   </div>\n' +
                    '</button>';
                holder[0].innerHTML += body;
            })
        }
    )
    $('#analyzer').show();
    $('#tableCard').hide();
    $('#source').attr('src', '/content/videoAnalytics/upload/'+url);
    $('#video')[0].load();
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