$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#table'));
    });
});

function createGroup() {
    $.post("/financial/grouping/create", {
        id: $('#id').val(),
        group: $('#group').val(),
        item: $('#type').val()
    }, function () {});
    setTimeout(function (){
        window.location = "/financial/grouping";
    }, 500);
}

function modifyGroup(id, group, type) {
    $('#id').val(id);
    $('#group').val(group);
    $('#type').val(type)
}