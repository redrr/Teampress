<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
<c:if test="${!sessionHandler.userHasPermission('ADMIN') && sessionHandler.userHasPermission('LOGGED_IN')}">
    let queryOffset = 0;
    const postHolder = $('#posts');
</c:if>

$(document).ready(function () {
    <c:if test="${!sessionHandler.userHasPermission('ADMIN') && sessionHandler.userHasPermission('LOGGED_IN')}">
        nextFivePost();
    </c:if>
});

<c:if test="${!sessionHandler.userHasPermission('ADMIN') && sessionHandler.userHasPermission('LOGGED_IN')}">

    function nextFivePost() {
        $.post(
            "/home/getposts",
            {
                offset  :   queryOffset
            },
            function (result) {
                let array = JSON.parse(result);
                for (let i = 0; i < array.length; i++) {
                    addPost(array[i])
                }
            }
        );
        queryOffset += 5;
    }

    function addPost(json) {
        let body = '';
        body +=
            '<div class="card">\n' +
            '   <div class="card-header">\n' +
            '       <div class="row">\n' +
            '           <div class="col-1 media-left media-middle friend-box">\n' +
            '               <a>\n' +
            '                   <img class="media-object img-circle m-r-20" src="/content/profileImages/'+json.profileImg+'" alt="">\n' +
            '               </a>\n' +
            '           </div>\n' +
            '           <div class="col-9 media-body">\n' +
            '               <div class="chat-header">'+json.name+'</div>\n' +
            '               <div class="f-13 text-muted">'+json.postDate+'</div>\n' +
            '           </div>\n' +
            '           <div class="col-2 media-right">';
            <c:if test="${sessionHandler.userHasPermission('DELETE_POST_COMMENT')}">
            body += '               <button class="btn-delete btn btn-mini float-right btn-danger" onclick="deletePost('+json.id+')">x</button>';
            </c:if>
            body += '           </div>\n' +
            '       </div>\n' +
            '   </div>\n' +
            '   <div class="card-block">\n' +
            '       <div class="timeline-details">\n'+
                        json.text;
        if ('' !== json.content) {
            if (!json.content.toString().endsWith('mp4')) {
                body +=
                    '       <img src="/content/postImages/'+json.content+'" style="width: 100%; border-radius: 16px" alt="">\n';
            } else {
                body +=
                    '       <video controls muted style="width: 100%; border-radius: 16px">\n' +
                    '           <source src="/content/postImages/'+json.content+'" type="video/mp4">\n' +
                    '       </video>\n';
            }
        }
        body +=
            '       </div>\n' +
            '   </div>\n' +
            '   <div class="card-block user-box" style="padding-top: 0">\n';
        if (json.comments.length > 0) {
            body +=
                '   <hr>\n';
            for (let j = 0; j < json.comments.length; j++) {
                let comment = json.comments[j];
                body +=
                    '<div class="row" style="padding-top: 1.25rem; padding-right: 1rem">\n' +
                    '   <div class="col-2 col-md-1" style="padding-right: 0">\n' +
                    '       <img class="media-object img-circle m-r-20" src="/content/profileImages/'+comment.profileImg+'" alt="Generic placeholder image">\n' +
                    '   </div>\n' +
                    '   <div class="col-10 col-md-11" style="border-radius: 8px;background-color: #4b556614;padding: 16px;">\n' +
                    '       <div class="row">' +
                    '           <div class="col-10 chat-header">'+comment.name+'</div>\n' +
                    '           <div class="col-2">';
                    <c:if test="${sessionHandler.userHasPermission('DELETE_POST_COMMENT')}">
                    body += '               <button class="btn-delete btn btn-danger btn-mini float-right" onclick="deleteComment('+comment.id+')">x</button>';
                    </c:if>
                    body += '           </div>\n' +
                    '       </div>\n' +
                    '       <p class="text-muted" style="margin: 0">'+comment.text+'</p>\n' +
                    '   </div>\n' +
                    '</div>\n';
            }
        }
        body +=
            '       <hr>\n' +
            '       <div class="row">\n' +
            '           <div class="col-1 m-auto">\n' +
            '               <img class="media-object img-circle m-r-20 comment-avatar" src="/content/profileImages/'+json.profileImg+'" alt="Generic placeholder image">\n' +
            '           </div>\n' +
            '           <div class="col-9 col-md-10 m-auto">\n' +
            '               <input id="text'+json.id+'" class="form-control msg-send"/>\n' +
            '           </div>\n' +
            '           <div class="col-2 col-md-1 m-auto">\n' +
            '               <button id="btn'+json.id+'" style="padding: 0;padding-top: 4px" class="btn btn-primary waves-effect waves-light btn-icon">\n' +
            '                   <i style="font-size: 25px;margin: 0" class="icofont icofont-paper-plane"></i>\n' +
            '               </button>\n' +
            '           </div>\n' +
            '       </div>\n' +
            '   </div>\n' +
            '</div>';
        postHolder[0].innerHTML += body;
        $('#btn'+json.id+'').on('click', function () {comment(json.id)});
    }

    function deletePost(id) {
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
                        $.post(
                            "/home/deletepost",
                            {
                                id  :   id
                            },
                            function () {
                                window.location = '/';
                            }
                        );
                    }
                },
                cancel: {
                    text: 'Mégse',
                    btnClass: 'btn-blue',
                }
            }
        })
    }

    function comment(id) {
        $.post(
            '/docomment',
            {
                userPostId: id,
                comment: $('#text'+id+'').val()
            },
            function () {
                window.location = "/home";
            }
        );
    }

    function deleteComment(id) {
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
                        $.post(
                            "/home/deletecomment",
                            {
                                id  :   id
                            },
                            function () {
                                window.location = '/';
                            }
                        );
                    }
                },
                cancel: {
                    text: 'Mégse',
                    btnClass: 'btn-blue',
                }
            }
        })
    }

</c:if>
</script>
