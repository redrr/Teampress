$(document).ready(function () {
    $().ready(function () {
        $('#table').DataTable({
            responsive: true
        });
    });
});

function del(id){
    $.post(
        "/org/league/del",
        {
            id: id
        },
        function (result) {

        });
}

function get(id){
    $.post(
        "/org/league/get",
        {
            id: id
        },
        function (result) {
            var l = JSON.parse(result);
            $('#id').val(l.id);
            $('#evad').val(l.ev);
            $('#szervezo').val(l.szerv);
            $('#liga').val(l.liga);
            $('#klubName').val(l.klub);
            $('#team').val(l.team);
        });
}