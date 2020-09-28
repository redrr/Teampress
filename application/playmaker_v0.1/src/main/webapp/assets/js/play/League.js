var historyChartDataConfig, historyChartData;
$(document).ready(function () {
    var select = $('#ligaSelect');
    $.post("/statistics/league/history", { liga: select.text() },function (result, s) {
        if(!(result === "")){
            historyChartDataConfig = JSON.parse(result);
            if(!(historyChartData===undefined)){
                historyChartData.destroy();
            }
            setTimeout(function () {
                historyChartData = new Chart($('#history'), historyChartDataConfig);
            }, 0);
        }
    });
    select.on('change', function () {
        var tabs = $('.ligaTab');
        tabs.hide();
        console.log(tabs[select[0].selectedIndex]);
    });
});