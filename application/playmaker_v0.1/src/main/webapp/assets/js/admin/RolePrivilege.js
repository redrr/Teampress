$(document).ready(function () {
    $().ready(function () {
        createDataTable('table')
    });
});

function del(id){
    $.post(
        "/priv/rolepriv/del",
        {
            id: id
        },
        function (result) {

        });
}

function get(id){
    $.post(
        "/priv/rolepriv/get",
        {
            id: id
        },
        function (result) {
            var  r = JSON.parse(result);
            console.log(r);
            $('#privId').val(r.priv).trigger('change');
            $('#roleId').val(r.role).trigger('change');
            $('#id').val(r.id);
        });
}
