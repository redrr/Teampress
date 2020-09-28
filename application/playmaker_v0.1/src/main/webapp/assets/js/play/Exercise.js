$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#exerciseTable'));
        handleEnter('form');
    });
});

function showLanguage(id, typeId, name) {
        $("#type").val(typeId).trigger("change");
        $("#name").val(name);
        $("#id").val(id);
}

function delLanguage(id) {
    deleteEntry(id, '/training/exercise');
}