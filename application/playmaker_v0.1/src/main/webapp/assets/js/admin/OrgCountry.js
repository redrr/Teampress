$(document).ready(function () {
    $().ready(function () {
        createDataTable('table')
    });
});

function del(id){
    $.post(
        "/org/orgcountry/del",
        {
            id: id
        },
        function (result) {
            window.location = '/org/orgcountry';
        });
}

function get(id){
    $.post(
        "/org/orgcountry/get",
        {
            id: id
        },
        function (result) {
            var o = JSON.parse(result);
            $('#organizationId').val(o.orgId).trigger('change');
            $('#fullname').val(o.name);
            $('#country').val(o.country);
            $('#postCode').val(o.pcode);
            $('#city').val(o.city);
            $('#street').val(o.street);
            $('#street2').val(o.street2);
            $('#id').val(o.id);
        });
}
