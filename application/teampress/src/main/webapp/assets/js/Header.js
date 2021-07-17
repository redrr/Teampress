var workoutChart;

$(document).ready(function(){
    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    });
    getProfileImg();
    $("select").addClass("form-control").addClass("cr-pointer");
    getNoti();
    $('.notification').on('click', function () {
    });
    getRating();
    handleMenu();
});

function handleMenu() {
    const actives = $('.pcoded-hasmenu.active');
    if(actives.length === 1){
        actives.click();
    }
}

function createDataTable(tableId) {
    let search = '<tr>';
    $('#'+tableId+' thead th').each(function () {
        let searchAttr = $(this).attr('search');
        if (searchAttr !== 'disabled') {
            if (searchAttr === undefined) {
                search += '<th><input class="form-control" type="text"/></th>';
            } else  {
                search += '<th><input class="form-control" type="'+searchAttr+'"/></th>';
            }
        } else {
            search += '<th></th>';
        }
    });
    search += '</tr>'
    $('#'+tableId+' tfoot').html(search);
    $('#'+tableId+'').DataTable({
        ordering    :   true,
        searching   :   true,
        responsive  :   true,
        colReorder  :   true,
        language: {
            url: 'https://cdn.datatables.net/plug-ins/1.10.24/i18n/Hungarian.json'
        },
        dom: 'Blrtip',
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5',
            'pdfHtml5'
        ],
        initComplete: function () {
            // Apply the search
            this.api().columns().every(function () {
                let that = this;
                let input = $("input", this.footer());
                input.on('change', function (ev) {
                    that.columns(that[0]).search(this.value).draw();
                });
            });
        }
    });
}

function createDataTablePlus(table, data) {
    table.DataTable(data);
}

function getRating() {
    $.post("/getratings",{}, function (rating) {
        if(!(rating === '')){
            $('#ratingModal').attr('title', rating);
            $('#ratingButton').click();
        }
    });
}

function sendRating(id, slider) {
    var idx = id[0].title;
    var value = slider.val();
    $.post("/sendrating",
        {
            id  :   idx,
            value   :   value
        },function (value) {
            if(value === 'success'){
                location.reload();
            }
    });
}

function getNoti() {
    const notificationList = $('#notiList');
    var body =
        "<li style='background-color: #f1f1f1'>" +
        "  <h6>Értesítések</h6>" +
        "</li>";
    $.post("/getnoti", {}, function (notifications) {
        var noti = JSON.parse(notifications);
        const badge = $('#notiCounter');
        if(noti.count > 0){
            badge.text(noti.count);
        } else {
            badge.text();
        }
        if(noti.count > 0){
            var notiList = noti.list.split(';');
            notiList.forEach(function (n, i) {
                var msg = n.split('|');
                body +=
                    "<li class='cr-pointer' onclick='readNoti(\""+msg[0]+"\","+noti.id.split(';')[i]+")'>\n" +
                    "   <div class=\"media\">\n" +
                    "       <div class=\"media-body row\">\n" +
                    "           <h5 class=\"notification-user col-6\">"+msg[2]+"</h5>\n" +
                    "           <span class=\"notification-time col-6\"><p class='float-right'>"+msg[1]+"</p></span>\n" +
                    "           <p class=\"notification-msg col-12\">"+msg[3]+"</p>\n" +
                    "       </div>\n" +
                    "   </div>\n" +
                    "</li>";
            });
        } else {
            body +=
                "<li>\n" +
                "   <div class=\"media\">\n" +
                "       <div class=\"media-body\">\n" +
                "           <p class=\"notification-msg\">Nincs új értesítésed</p>\n" +
                "       </div>\n" +
                "   </div>\n" +
                "</li>";
        }
        notificationList.empty();
        notificationList.append(body);
    });
}

function readNoti(href, id) {
    $.post("/readnotification",{id: id}, function () {
            window.location=href;
    })
}

function getProfileImg(){
    $.post(
        '/home/getimg',
        {},
        function (d) {
            var data = JSON.parse(d);
            $("#useravatar").attr("src", '/content/profileImages/'+data.pic);
            $(".comment-avatar").attr("src", '/content/profileImages/'+data.pic);
            $("#post-avatar").attr("src", '/content/profileImages/'+data.pic);
            $('#profile-name').text(data.name);
        }
    );
}

function handleEnter(formID) {
    $('#' + formID).submit(function () {
        return $(this).find("[type='submit']").is(":visible");
    });
}

function deleteEntry(id, url) {
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
                    $.ajax({
                        url: url+"/del",
                        type: "POST",
                        data: {
                            id: id,
                        },
                        success: function () {
                            window.location=url;
                        },
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

function UUID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random() * 16 | 0, v = c === 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}

function redirect(str, id) {
    window.location.replace(str + "/" + id);
}

function scrollToId(id) {
    document.getElementById(id).scrollIntoView(true);
}

function disableButton($button) {
    $button.prop("disabled", true);
}

function enableButton($button) {
    $button.prop("disabled", false);
}

function remove(arr, thing) {
    if(scontains(arr, thing)) {
        return arr.slice(0, arr.indexOf(thing)).concat(arr.slice(arr.indexOf(thing) + 1, arr.length));
    } else {
        return arr;
    }
}

function scontains(array, it) {
    return array.indexOf(it) !== -1;
}

function modalBody(trainingData){
    const body = $('#trainingModalBody');
    var labels = [];
    var datas1 = [];
    body.empty();
    trainingData.exercises.split(';').forEach(function (exercise,index) {
        const name = exercise.split(',')[0];
        const type = exercise.split(',')[1];
        const result = exercise.split(',')[2];
        let percent;
        let bodyHtml =
            "<div class=\"row\" style='margin-bottom: 4px'>" +
            "   <div class='col-5'>" +
            "       <b>"+name+"</b>" +
            "   </div>" +
            "   <div class='col-7'>";
        let writtenHtml = '';
        if(trainingData.pastTraining){
            if(result === 'H~h~H'){
                bodyHtml +=
                    "<p>Hiányzott!</p>"
            } else {
                if(type === 'Csillagok'){
                    percent = result/5*100;
                    bodyHtml +=
                        "<b style='float: right'>"+result/5*10+"</b>";
                }
                else if(type === 'Szöveges értékelés'){
                    writtenHtml = "<div class=\"row\" style='margin-bottom: 4px'>" +
                        "   <div class='col-12'>" +
                        "       <b>"+name+"</b>" +
                        "   </div>" +
                        "   <div class='col-10 mx-auto'>"+
                                "<p style='word-break: break-all;'>"+result+"</p>" +
                        "   </div>" +
                        "</div>";
                    body.append(writtenHtml);
                }
                else if(type === '1-10 -es skála'){
                    percent = result*10;
                    bodyHtml +=
                        "<b style='float: right'>"+
                            result+
                        "</b>"
                    ;
                }
                else if(type === 'Százalék'){
                    percent = result;
                    bodyHtml +=
                        "<b style='float: right'>"+result/10+"</b>"

                }
                else if(type === 'Sikeres/darabszám'){
                    percent = result.split('/')[0] / result.split('/')[1] *100;
                    bodyHtml +=
                        "<b style='float: right'>" +
                        result.split('/')[0] / result.split('/')[1] *10 +
                        "</b>";
                }
            }
        } else {
            bodyHtml +=
                "<b>Értékelésre vár!</b>"
        }

        bodyHtml +=
            "   </div>" +
            "</div>";
        bodyHtml +=
            "<div class='row' style='margin-bottom: 16px'>" +
            "   <div class='col-12'>" +
            "       <div style='background-color: #e9ecef; border-radius: 8px; width: 100%'>" +
            "           <div style='background-color: #28e1bd;width: "+percent+"%;border-radius: 8px; height: 8px'>" +
            "           </div>" +
            "       </div>"+
            "   </div>"+
            "</div>";
        if (writtenHtml === ''){
            body.append(bodyHtml);
        }
    });
    destroy(workoutChart);
    if(!(trainingData.chart===undefined)){
        chartBuilder(JSON.parse(trainingData.chart), 'trainingStat', workoutChart);
    }

}

function oldModalBody(trainingData){
    const body = $('#trainingModalBody');
    var labels = [];
    var datas1 = [];
    body.empty();
    trainingData.exercises.split(';').forEach(function (exercise,index) {
        const name = exercise.split(',')[0];
        const type = exercise.split(',')[1];
        const result = exercise.split(',')[2];
        var bodyHtml =
            "<div class=\"row\">" +
            "   <div class='col-5'>" +
            "       <h4 class='title'>"+name+"</h4>" +
            "   </div>" +
            "   <div class='col-7'>";
        if(trainingData.pastTraining){
            if(result === 'H~h~H'){
                bodyHtml +=
                    "<p>Hiányzott!</p>"
            } else {
                if(type === 'Csillagok'){
                    bodyHtml +=
                        "<div class=\"rate2 col-form-label\">\n" +
                        "   <label for=\"star5\" title=\"star5\"";
                    if(result > 4){
                        bodyHtml += "style='color: #ffc700'";
                    }
                    bodyHtml +=
                        ">5 stars</label>\n" +
                        "  <label for=\"star4\" title=\"star4\"";
                    if(result > 3){
                        bodyHtml += "style='color: #ffc700'"
                    }
                    bodyHtml +=
                        " >4 stars</label>\n" +
                        "   <label for=\"star3\" title=\"star3\"";
                    if(result > 2){
                        bodyHtml += "style='color: #ffc700'";
                    }
                    bodyHtml +=
                        ">3 stars</label>\n" +
                        "   <label for=\"star2\" title=\"star2\"";
                    if(result > 1){
                        bodyHtml += "style='color: #ffc700'";
                    }
                    bodyHtml +=
                        ">2 stars</label>\n" +
                        "   <label for=\"star1\" title=\"star1\"";
                    if(result > 0){
                        bodyHtml += "style='color: #ffc700'";
                    }
                    bodyHtml +=
                        ">1 star</label>\n" +
                        "</div>";
                }
                else if(type === 'Szöveges értékelés'){
                    bodyHtml +=
                        "<span class=\"font-weight-bold ml-2\">\n" +
                        result +
                        "</span>"
                    ;
                }
                else if(type === '1-10 -es skála'){
                    bodyHtml +=
                        "<div class=\"d-flex justify-content-center my-2\">\n" +
                        "   <span class=\"font-weight-bold text-info ml-2\">" +
                        "10 / " + result +
                        "</span>\n" +
                        "</div>"
                    ;
                }
                else if(type === 'Százalék'){
                    bodyHtml +=
                        "<div class=\"row\">\n" +
                        "    <div class=\"col-12\">\n" +
                        "        <div class=\"row\">\n" +
                        "            <div class=\"col-8\">\n" +
                        "                <label for=\"l"+index+"\">"+name+"</label>\n" +
                        "            </div>\n" +
                        "            <div class=\"col-2\">\n" +
                        "                <label for=\"l"+index+"\">"+result/10.0+"</label>\n" +
                        "            </div>\n" +
                        "            <div class=\"col-2\">\n" +
                        "                <i class=\"cil-movie\"></i>\n" +
                        "            </div>\n" +
                        "        </div>\n" +
                        "        <div class=\"row\">\n" +
                        "            <div class=\"col-12\">\n" +
                        "                <div id='l"+index+"' class=\"progress mb-3\">\n" +
                        "                    <div class=\"progress-bar\" role=\"progressbar\" style=\"width: "+result+"%\" aria-valuenow=\"25\" aria-valuemin=\"0\" aria-valuemax=\"100\"></div>\n" +
                        "                </div>\n" +
                        "            </div>\n" +
                        "        </div>\n" +
                        "    </div>\n" +
                        "</div>";

                }
                else if(type === 'Sikeres/darabszám'){
                    bodyHtml +=
                        "<div class=\"form-inline\">\n" +
                        "   <div class=\"form-group\">\n" +
                        "       <label class=\"font-weight-bold text-info ml-2\">Sikeres: " +
                        result.split('/')[0] +
                        "       </label>\n" +
                        "   </div>\n" +
                        "   <div class=\"form-group\">\n" +
                        "       <label class=\"font-weight-bold text-info ml-2\">/ Összes: " +
                        result.split('/')[1] +
                        "       </label>\n" +
                        "   </div>\n" +
                        "</div>";
                }
            }
        } else {
            bodyHtml +=
                "<p>Értékelésre vár!</p>"
        }
        bodyHtml +=
            "   </div>" +
            "</div>"
        ;
        body.append(bodyHtml);
    });
    destroy(workoutChart);
    if(!(trainingData.chart===undefined)){
        chartBuilder(JSON.parse(trainingData.chart), 'trainingStat', workoutChart);
    }

}

function chartBuilder(config, ElementId, variable) {
    destroy(variable);
    var ctx = document.getElementById(ElementId);
    variable = new Chart(ctx, config);
    variable.update();
}

function destroy(variable) {
    if(!(variable===undefined)){
        variable.destroy();
    }
}
