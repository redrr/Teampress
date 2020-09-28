$(document).ready(function () {
    $().ready(function () {
        $('#table').DataTable({
            responsive: true
        });
    });
});

function del(id){
    $.post(
        "/sys/lookup/del",
        {
            id: id
        },
        function (result) {
            window.location = '/sys/lookup';
        });
}

function get(id){
    $.post(
        "/sys/lookup/get",
        {
            id: id
        },
        function (result) {
            var l = JSON.parse(result);
            console.log(l);
            $('#id').val(l.id);
            $('#name').val(l.name);
            $('#lgroup').val(l.lgroup);
            $('#code').val(l.code);
            $('#description').val(l.description);
        });
}