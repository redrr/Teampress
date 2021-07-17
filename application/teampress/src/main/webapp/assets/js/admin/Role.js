$(document).ready(function () {
    $().ready(function () {
        createDataTable('table')
    });
});

function del(id){
    $.post(
        "/priv/role/del",
        {
            id: id
        },
        function (result) {
            window.location = '/priv/role';
        });
}

function get(id){
    $.post(
        "/priv/role/get",
        {
            id: id
        },
        function (result) {
            var r = JSON.parse(result);
            $("#id").val(r.id);
            $("#name").val(r.name);
            $("#description").val(r.desc);
        });
}
