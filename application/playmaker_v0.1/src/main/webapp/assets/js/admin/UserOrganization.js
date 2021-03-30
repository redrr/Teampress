$(document).ready(function () {
    $().ready(function () {
        createDataTable('table')
    });
});

function del(id){
    $.post(
        "/org/userorg/del",
        {
            id: id
        },
        function (result) {

        });
}

function get(id){
    $.post(
        "/org/userorg/get",
        {
            id: id
        },
        function (result) {
            var u = JSON.parse(result);
            $('#id').val(u.id).trigger('change');
            $('#user').val(u.user).trigger('change');
            $('#organiaztion').val(u.org).trigger('change');
            $('#type').val(u.type).trigger('change');
            $('#liga').val(u.liga).trigger('change');
        });
}
