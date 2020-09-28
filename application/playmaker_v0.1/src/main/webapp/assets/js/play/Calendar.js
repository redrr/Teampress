document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        plugins: [ 'interaction', 'dayGrid', 'bootstrap', 'rrule' ],
        initialView: 'timeGridWeek',
        themeSystem: 'bootstrap',
        locale: 'hun',
        header: {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,dayGridWeek,dayGridDay',
        },
        buttonText: {
            today: 'mai nap',
            month: 'hónap',
            week: 'hét',
            day: 'nap',
            list: 'lista'
        },
        eventTimeFormat: {
            hour: '2-digit',
            minute: '2-digit',
            hour12: false
        },
        eventSources: [
            {
                url: '/calendar/getevents',
                method: 'POST',
                failure: function() {
                    alert('Rendszerhiba: Nem sikerült frissíteni az eseményeket!');
                },
                color: '#34495E',   // a non-ajax option
                textColor: '#fff', // a non-ajax option
            }
        ]
    });
    calendar.render();
});

$(document).ready(function () {
    $('#date').datetimepicker({
        format: 'YYYY/MM/DD HH:mm',
        locale: 'hu',
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
});

function createCalendarEvent() {
    $.post("/calendar",
        {
            name : $('#name').val(),
            type : $('#type').val(),
            date : $('#date').val()
        }, function () {
            $('#close').click();
        }
    )
}