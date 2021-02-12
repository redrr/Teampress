var historyChartDataConfig, historyChartData,
    pointsChartDataConfig, pointsChartData,
    leagueChartDataConfig, leagueChartData,
    goalChartDataConfig, goalChartData,
    gameChartDataConfig, gameChartData;
$(document).ready(function () {
    $.post("/statistics/dashboard/points", { liga: 'MEGYEI I.' },function (result, s) {
        if(!(result === "")){
            const cfg = {
                type: 'doughnut',
                data: {
                    labels: [
                        'Szerzett pontok',
                        'Elvesztett pontok'
                    ],
                    datasets: [{
                        label: 'My First Dataset',
                        data: JSON.parse(result),
                        backgroundColor: [
                            '#1abc9c',
                            '#bdc3c7'
                        ]
                    }]
                },
                options: {
                    responsive: true,
                    circumference: 3.14,
                    rotation: -3.14,
                    animation: {
                        animateScale: false,
                        animateRotate: true,
                        duration: 2500,
                        delay: 500
                    }
                }
            };
            if(!(pointsChartData===undefined)){
                pointsChartData.destroy();
            }
            setTimeout(function () {
                pointsChartData = new Chart($('#1'), cfg);
            }, 0);
        }
    });
    $.post("/statistics/dashboard/goals", { liga: 'MEGYEI I.' },function (result, s) {
        if(!(result === "")){
            goalChartDataConfig = JSON.parse(result);
            const cfg = {
                type: 'bar',
                data: {
                    labels: [
                        ''
                    ],
                    datasets: [
                        {
                            label: 'Lőtt gólok',
                            data: [goalChartDataConfig.lgoals],
                            backgroundColor: [
                                '#1abc9c'
                            ]
                        },
                        {
                            label: 'Kapott gólok',
                            data: [goalChartDataConfig.kgoals],
                            backgroundColor: [
                                '#e74c3c'
                            ]
                        }
                    ]
                },
                options: {
                    animation: {
                        duration: 2500,
                        delay: 500
                    }
                }
            };
            if(!(goalChartData===undefined)){
                goalChartData.destroy();
            }
            setTimeout(function () {
                goalChartData = new Chart($('#2'), cfg);
            }, 0);
        }
    });
    $.post("/statistics/dashboard/games", { liga: 'MEGYEI I.' },function (result, s) {
        if(!(result === "")){
            const cfg = {
                type: 'doughnut',
                data: {
                    labels: [
                        'Győzelem',
                        'Döntetlen',
                        'Vereség'
                    ],
                    datasets: [{
                        label: 'My First Dataset',
                        data: JSON.parse(result),
                        backgroundColor: [
                            '#1abc9c',
                            '#bdc3c7',
                            '#e74c3c'
                        ],
                        hoverOffset: 8
                    }]
                },
                options: {
                    animation: {
                        animateScale: false,
                        animateRotate: true,
                        duration: 2500,
                        delay: 500
                    }
                }
            };
            if(!(gameChartData===undefined)){
                gameChartData.destroy();
            }
            setTimeout(function () {
                gameChartData = new Chart($('#3'), cfg);
            }, 0);
        }
    });
    $.post("/statistics/dashboard/history", { liga: 'MEGYEI I.' },function (result, s) {
        if(!(result === "")){
            historyChartDataConfig = JSON.parse(result);
            if(!(historyChartData===undefined)){
                historyChartData.destroy();
            }
            setTimeout(function () {
                historyChartData = new Chart($('#4'), historyChartDataConfig);
            }, 0);
        }
    });
    $.post("/statistics/dashboard/league", { liga: 'MEGYEI I.' },function (result, s) {
        if(!(result === "")){
            leagueChartDataConfig = JSON.parse(result);
            console.log(result);
            if(!(leagueChartData===undefined)){
                leagueChartData.destroy();
            }
            setTimeout(function () {
                leagueChartData = new Chart($('#5'), leagueChartDataConfig);
            }, 0);
        }
    });

});