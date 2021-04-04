$(document).ready(function () {
    $().ready(function () {
        createDataTable('table')
    });
});

function del(id){
    $.post(
        "/org/organization/del",
        {
            id: id
        },
        function (result) {
            window.location = '/org/organization'
        });
}

function get(id){
    $.post(
        "/org/organization/get",
        {
            id: id
        },
        function (result) {
            var o = JSON.parse(result);
            $('#id').val(o.id);
            $('#name').val(o.name);
            $('#type').val(o.type);
        });
}
