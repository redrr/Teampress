$(document).ready(function () {
    $().ready(function () {
        createDataTable('table');
    });
});

function createIncome() {
    $.post("/financial/create/new",
        {
            id: $('#id')[0].value,
            name: $('#name')[0].value,
            type: $('#type')[0].value,
            val: $('#cost')[0].value
        },
        function () {}
    );
    setTimeout(function (){
        window.location = "/financial/create";
    }, 500);
}

function modifyIncome(id, name, type, val) {
    $('#id').val(id);
    $('#name').val(name);
    var a;
    if(type === 'true'){
        a = 1;
    } else {
        a = 0;
    }
    $('#type').val(a).trigger("change");
    $('#cost').val(val);
}

function deleteIncome(id) {
    var that = this;
    $.confirm({
        title: 'Biztosan törlöd?',
        content: '',
        type: 'red',
        theme: 'supervan',
        animation: 'zoom',
        animationBounce: 1.5,
        typeAnimated: true,
        buttons: {
            delete: {
                text: 'Törlés',
                btnClass: 'btn-red',
                action: function() {
                    $('#alert').empty();
                    $.post(
                        "/financial/create/del",
                        {id: id},
                        function (value) {
                            if(value !== ''){
                                var alert = JSON.parse(value);
                                $('#alert').append(
                                    "<div class=\"alert alert-"+alert.class+" alert-dismissible fade show\" role=\"alert\">\n" +
                                    alert.msg +
                                    "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n" +
                                    "    <span aria-hidden=\"true\">&times;</span>\n" +
                                    "  </button>\n" +
                                    "</div>"
                                );
                            } else {
                                setTimeout(function (){
                                    window.location = "/financial/create";
                                }, 200);
                            }
                        });

                }
            },
            cancel: {
                text: 'Mégse',
                btnClass: 'btn-blue',
            }
        }
    })
}
