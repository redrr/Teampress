var isplaying = false;
var isEdit = false;
var width, height;
var videoId;
var pos = [];
var mode;
$(document).ready(function () {
    $().ready(function () {
        //Setup
        createDataTable($('#table'));
        const video = $('#video')[0];
        drawer();
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
                video.pause();
                changeSidebar($('#actionsSidebar'), $('#recordActionSidebar'));
                $('#container').show();
                isEdit = true;
            } else {
                console.log('ERROR - Need to change sidebar!')
                video.play();
                $('#container').hide();
                isEdit = false;
            }
        });
        $('#saveAction').on('click', function () {
            if(isEdit){
                video.play();
                changeSidebar($('#recordActionSidebar'), $('#actionsSidebar'));
                $('#container').show();
                isEdit = false;
            } else {
                console.log('ERROR - Need to change sidebar!')
                video.pause();
                $('#container').hide();
                isEdit = true;
            }
        });
        $('#clear').on('click', function () {
            drawer();
        });
        $('#mode').on("change", function() {
            pos = [];
            mode = $('#mode').val();
        });
    });
});

//Create Analyzer
function drawer() {
    var stage = new Konva.Stage({
        container: 'container',
        width: width,
        height: height
    });

    // add canvas element
    var layer = new Konva.Layer();
    stage.add(layer);
    layer.draw();

    // add cursor styling
    stage.on('click', function() {
        //log
        console.log(stage.getPointerPosition());
        //main
        pos.push(stage.getPointerPosition().x);
        pos.push(stage.getPointerPosition().y);
        if(mode === 'line') {
            var line = new Konva.Line({
                points: pos,
                stroke: $('#color').val(),
                strokeWidth: 4,
                lineCap: 'round',
                lineJoin: 'round',
            });
            layer.add(line);
        }
        if(mode === 'arrow') {
            var arrow = new Konva.Arrow({
                points: pos,
                stroke: $('#color').val(),
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
                    fill: $('#color').val(),
                    stroke: $('#color').val(),
                    strokeWidth: 4,
                    lineCap: 'round',
                    lineJoin: 'round',
                });
                layer.add(select);
                pos = [];
            }
        }
        layer.draw();
    });

}

//Load video
function setupVideo(id,url) {
    videoId = id;
    $('#analyzer').show();
    $('#source').attr('src', '/content/videoAnalytics/upload/'+url);
    $('#video')[0].load();
    width = $('#video').width();
    height = $('#video').height();
    console.log($('#video').width()+", "+$('#video').height());
}

function changeSidebar(from, to) {
    const hideCssClass = "highlight-sidebar-hidden";
    from.addClass(hideCssClass);
    to.removeClass(hideCssClass);
}