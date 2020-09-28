$(document).ready(function () {
    $().ready(function () {
        $('#table').DataTable({
            responsive: true
        });
    });
});

function del(id){
    $.post(
        "/usr/userrole/del",
        {
            id: id
        },
        function (result) {

        });
}

function get(id){
    $.post(
        "/usr/userrole/get",
        {
            id: id
        },
        function (result) {
            var u = JSON.parse(result);
            $('#id').val(u.id);
            $('#userId').val(u.user).trigger('change');
            $('#roleId').val(u.role).trigger('change');
        });
}