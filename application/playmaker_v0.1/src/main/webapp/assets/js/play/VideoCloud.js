$(document).ready(function () {
});

function searchByPlayer(select) {
    const elements = $('.video-element');
    const tags = $('.player-field');
    if(select.val() === ''){
        elements.show();
    } else {
        elements.hide();
        for(var i = 0; i < tags.length; i++){
            if(tags[i].innerText === select.val()) {
                elements[i].style.display = 'block';
            }
        }
    }
}