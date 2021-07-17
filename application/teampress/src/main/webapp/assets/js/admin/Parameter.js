$(document).ready(function () {
    $().ready(function () {
        createDataTable('table')
    });
});

function del(id){
    $.post(
        "/sys/param/del",
        {
            id: id
        },
        function (result) {
            window.location = '/sys/param';
        });
}

function get(id){
    $.post(
        "/sys/param/get",
        {
            id: id
        },
        function (result) {
            var p = JSON.parse(result);
            $('#id').val(p.id);
            $('#group').val(p.group);
            $('#code').val(p.code);
            $('#value').val(p.value);
            $('#attr1').val(p.a1);
            $('#attr2').val(p.a2);
            $('#attr3').val(p.a3);
            $('#attr4').val(p.a4);
            $('#attr5').val(p.a5);
        });
}
