var isplaying = false;
var isModalOpen = false;
var cuting = false;
var startTime, endTime, videoId;
$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#table'));
        const video = $('#video')[0];
        if(!isModalOpen){
            $(window).keypress(function (e) {
                if(e.key === 'c' || e.key === 'C') {
                    const video = $('#video')[0];
                    if(!cuting) {
                        if(startTime === undefined){
                            cuting = true;
                            endTime = undefined;
                            startTime = video.currentTime;
                        }
                    } else {
                        if(startTime !== undefined && endTime === undefined) {
                            endTime = video.currentTime;
                            setupVideoModal();
                            $('#addVideoModalButton').click();
                            video.pause();
                            cuting = false;
                        }
                    }
                    console.log('start: '+startTime+', end: '+endTime)
                }
            });
        }
    });
});

function setupVideo(id,url) {
    videoId = id;
    $('#analyzer').show();
    $('#source').attr('src', '/content/videoAnalytics/upload/'+url);
    $('#video')[0].load();
}

function sendVideo() {
    const video = $('#video')[0];
    video.pause();
    $.post(
        "/videoeditor/cut",
        {
            videoId : videoId,
            folderId : $('#folder').val(),
            userId : $('#user').val(),
            start : startTime,
            end : endTime,
            name : $('#sceneName').val(),
            desc : $('#sceneDesc').val()
        },
        function (value) {
            if(value === 'done') {
                $('#closeModal').click();
                video.play();
            } else {
                alert("Nem sikerült kivágni a jelenetet!");
                console.log('nem sikerült a vágás!')
            }
        }
    )
}

function setupVideoModal() {
    isModalOpen = true;
    $.post(
        "/videoeditor/getusers",
        {
            videoId : videoId
        },
        function (value) {
            if(!(value === '')) {
                var players = JSON.parse(value);
                var options = "";
                players.forEach(function (data) {
                    options += "<option value='"+data.id+"'>"+data.name+"</option>"
                });
                $('#user')[0].innerHTML = options;
            } else {
                console.log('players hiba!')
            }
        }
    );
    $.post(
        "/videoeditor/getfolders",
        {
            videoId : videoId
        },
        function (value) {
            if(!(value === '')) {
                var folders = JSON.parse(value);
                var options = "";
                folders.forEach(function (data) {
                    options += "<option value='"+data.id+"'>"+data.name+"</option>"
                });
                $('#folder')[0].innerHTML = options;
            } else {
                console.log('players hiba!')
            }
        }
    )
}

function setClose() {
    isModalOpen = false;
}