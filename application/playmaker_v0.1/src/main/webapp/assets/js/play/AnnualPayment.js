$(document).ready(function () {
    $().ready(function () {
        createDataTable('paymentTable');
        handleEnter('form');
    });
});

function showLanguage(id, typeId, name, amunt, day, groupid) {
        $("#type").val(typeId).trigger("change");
        $("#group").val(groupid).trigger("change");
        $("#name").val(name);
        $("#amount").val(amunt);
        $("#day").val(day);
        $("#id").val(id);
}

function delLanguage(id) {
    deleteEntry(id, '/financial/annual');
}
