$(document).ready(function () {
    $().ready(function () {
        $('#table').DataTable({
            responsive: true
        });
    });
});

function del(id){
    $.post(
        "/usr/user/del",
        {
            id: id
        },
        function (result) {

        });
}

function get(id){
    $.post(
        "/usr/user/get",
        {
            id: id
        },
        function (result) {
            var u = JSON.parse(result);
            console.log(u);
            $('#id').val(u.id);
            $('#username').val(u.un);
            $('#name').val(u.n);
            $('#email').val(u.em);
            $('#phone').val(u.ph);
            $('#url').val(u.url);
            $('#player').attr('checked', u.p);
            $('#enabled').attr('checked', u.e);
            $('#deleted').attr('checked', u.d);
        });
}