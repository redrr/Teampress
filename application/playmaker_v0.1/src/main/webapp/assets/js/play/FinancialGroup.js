$(document).ready(function () {
    $().ready(function () {
        createDataTable('table');
    });
});

function createGroup() {
    $.post("/financial/group/create",
        {
            id: $('#id')[0].value,
            name: $('#name')[0].value,
            desc: $('#description')[0].value
        }, function () {});
    setTimeout(function (){
        window.location = "/financial/group";
    }, 500);
}

function modifyGroup(id, name, desc) {
    $('#id')[0].value = id;
    $('#name')[0].value = name;
    $('#description')[0].value = desc;
}

function deleteGroup(id) {
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
                        "/financial/group/del",
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
                                window.location='/financial/group';
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
