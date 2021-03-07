$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#paymentTable'));
        handleEnter('form');
    });
});

function delLanguage(id) {
    deleteEntry(id, '/financial/paymentrequest');
}
