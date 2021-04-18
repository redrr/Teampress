$(document).ready(function () {
    createDataTable('playerTable');
});

function manageUser(id, status) {
    $.post(
        "/dashboard/manageuser",
        {
            username    :   id,
            status      :   status
        }, function () {
            window.location = '/dashboard';
        }
    )
}
