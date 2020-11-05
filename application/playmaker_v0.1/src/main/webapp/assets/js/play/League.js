$(document).ready(function () {
    var select = $('#ligaSelect');
    select.on('change', function () {
        var tabs = $('.ligaTab');
        tabs.hide();
        console.log(tabs[select[0].selectedIndex]);
    });
});