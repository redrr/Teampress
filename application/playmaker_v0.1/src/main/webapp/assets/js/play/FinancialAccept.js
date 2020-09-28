$(document).ready(function () {
    $().ready(function () {
        createDataTable($('#requestTable'));
        createDataTable($('#stateTable'));
    });
});

function confirm(id) {
    $.confirm({
        title: 'Biztosan elfogadod?',
        content: '',
        type: 'red',
        theme: 'supervan',
        animation: 'zoom',
        animationBounce: 1.5,
        typeAnimated: true,
        buttons: {
            delete: {
                text: 'Elfogad',
                btnClass: 'btn-green',
                action: function() {
                    $.ajax({
                        url: "/financial/accept/confirm",
                        type: "POST",
                        data: {
                            id : id
                        },
                        success: function () {
                            $('#clear-form-btn').click();
                            window.location="/financial/accept";
                        },
                    });
                }
            },
            cancel: {
                text: 'Mégse',
                btnClass: 'btn-grey',
            }
        }
    })
}

function ignore(id) {
    $.confirm({
        title: 'Biztosan elutasítod?',
        content: '',
        type: 'red',
        theme: 'supervan',
        animation: 'zoom',
        animationBounce: 1.5,
        typeAnimated: true,
        buttons: {
            delete: {
                text: 'Elutasít',
                btnClass: 'btn-red',
                action: function() {
                    $.ajax({
                        url: "/financial/accept/ignore",
                        type: "POST",
                        data: {
                            id : id
                        },
                        success: function () {
                            $('#clear-form-btn').click();
                            window.location="/financial/accept";
                        },
                    });
                }
            },
            cancel: {
                text: 'Mégse',
                btnClass: 'btn-grey',
            }
        }
    })
}

function fullIgnore(id) {
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
                        "/financial/accept/ignore",
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
                                window.location='/financial/accept';
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