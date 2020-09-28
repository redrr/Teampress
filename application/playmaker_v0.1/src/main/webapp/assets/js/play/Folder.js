$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#table'));
        $('#id').val('');
        $('#name').val('');
        $('#desc').val('');
    });
});

function show(id, desc, name) {
    $("#name").val(name);
    $("#desc").val(desc);
    $("#id").val(id);
}

function del(id) {
    deleteEntry(id, '/folder');
}