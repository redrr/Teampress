<%--
  Created by IntelliJ IDEA.
  User: Matyi
  Date: 2020. 07. 24.
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/JSTL.jsp" %>
<c:if test="${!sessionHandler.userHasPermission('ADMIN')}">
    <html>
    <head>
        <title>Teampress | Kezdőlap</title>
        <%@include file="include/Css.jsp" %>
        <link rel="stylesheet" type="text/css" href="../assets/vendor/assets/icon/SVG-animated/svg-weather.css">
    </head>
    <body>
    <!-- Pre-loader start -->
    <div class="theme-loader">
        <div class="ball-scale">
            <div></div>
        </div>
    </div>
    <!-- Pre-loader end -->
    <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">
            <%@include file="include/Header2.jsp" %>
            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <%@include file="include/Sidebar2.jsp" %>
                    <div class="pcoded-content" style="overflow-y: scroll; top:4em">
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <div class="page-body">
                                        <div class="row animated fadeInUpBig">
                                            <div class="col-9">
                                                <c:if test="${sessionHandler.userHasPermission('HOME_HEADER_BUTTONS')}">
                                                    <div class="row">
                                                        <div class="col-12 col-xl-4">
                                                            <a href="/statistics/league" class="card overflow-hidden">
                                                                <div class="card-body p-0 d-flex align-items-center" style="height: 100px">
                                                                    <div class="row p-0 d-flex align-items-center">
                                                                        <div class="col-5" style="padding-right: 0">
                                                                            <img class="mfe-3" style="width: 100%" src="${teamHeader.profImg}">
                                                                        </div>
                                                                        <div class="col-7" style="padding-left: 0">
                                                                            <div class="text-value-lg text-center">${teamHeader.name}</div>
                                                                            <div class="text-center">
                                                                                <c:forEach var="item" begin="0" end="4">
                                                                                    <span class="badge badge-${teamHeader.cssClass[item]}">${teamHeader.data[item]}</span>
                                                                                </c:forEach>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </div>
                                                        <div class="col-12 col-xl-4">
                                                            <a href="/training/workout" class="card overflow-hidden">
                                                                <div class="card-body p-0 d-flex align-items-center" style="height: 100px">
                                                                    <div class="row p-0 d-flex align-items-center" style="width: 100%">
                                                                        <div class="col-6" style="padding-right: 0">
                                                                            <img class="img-circle" style="width: 100%;max-width: 100px;max-height: 80px;margin-left: 10px;width: 80px;height: 80px;" src="/content/profileImages/${playerHeader.profImg}">
                                                                        </div>
                                                                        <div class="col-6" style="padding-left: 0">
                                                                            <div class="text-value-lg text-center">${playerHeader.name}</div>
                                                                            <div class="text-center">
                                                                                <c:forEach var="item" begin="0" end="4">
                                                                                    <span class="badge badge-${playerHeader.cssClass[item]}">${playerHeader.data[item]}</span>
                                                                                </c:forEach>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </div>
                                                        <div class="col-12 col-xl-4">
                                                            <a href="/gameplan" class="card overflow-hidden">
                                                                <div class="card-body p-0 d-flex align-items-center" style="height: 100px">
                                                                    <div class="row p-0 d-flex align-items-center">
                                                                        <div class="col-4" style="padding-right: 0">
                                                                            <img class="mfe-3" style="width: 100%;max-width: 100px;border-radius: 8px" src="${sorsolasHeader.hazaiUrl}">
                                                                        </div>
                                                                        <div class="col-4" style="padding-right: 0; padding-left: 0">
                                                                            <div class="text-value text-center">${sorsolasHeader.eredmeny}</div>
                                                                            <div div class="text-muted  text-center text-uppercase font-weight-bold small">VS.</div>
                                                                        </div>
                                                                        <div class="col-4" style="padding-left: 0">
                                                                            <img class="mfe-3" style="width: 100%;max-width: 100px;border-radius: 8px" src="${sorsolasHeader.vendegUrl}">
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${sessionHandler.userHasPermission('POST_COMMENT_CREATE')}">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div class="card bg-white">
                                                                <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/dopost' method='POST' modelAttribute="createPost" enctype="multipart/form-data">
                                                                    <div class="post-new-contain row card-block">
                                                                        <div class="col-md-1 col-xs-3 post-profile">
                                                                            <img id="post-avatar" src="../assets/vendor/assets/images/social/pro_icon.jpg" class="img-circle" alt="" style="width: 50px;height: 50px;">
                                                                        </div>
                                                                        <div class="col-md-10 col-xs-6">
                                                                            <div class="">
                                                                                <f:input type="text" required="" path="postText" placeholder="Ossz meg valamit....." cssErrorClass="form-control" cssClass="form-control post-input" id="post-message" style="margin-top: 5px;background-color: #4b556614;padding: 10px;"/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-1 col-xs-3">
                                                                            <div class="btn btn-default btn-icon image-upload" style="padding: 0;padding-top: 5px; margin-top: 4px;padding-left: 3px">
                                                                                <label class="cr-pointer" for="file-input" style="margin: 0">
                                                                                    <i style="font-size: 25px; margin: 0" class="icofont icofont-image text-muted"></i>
                                                                                </label>
                                                                                <f:input id="file-input" type="file" path="file"/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="post-new-footer b-t-muted p-15">
                                                                        <input id="submit" class="btn btn-primary btn-soft" name="save" type="submit" value="Mentés"/>
                                                                    </div>
                                                                </f:form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${sessionHandler.userHasPermission('POST_COMMENT_READ')}">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div>
                                                                <c:forEach var="post" items="${posts}">
                                                                    <div class="card bg-white p-relative">
                                                                        <div class="card-block">
                                                                            <div class="media">
                                                                                <div class="media-left media-middle friend-box">
                                                                                    <a>
                                                                                        <img class="media-object img-circle m-r-20" src="/content/profileImages/${post.key.user.profilImg}" alt="">
                                                                                    </a>
                                                                                </div>
                                                                                <div class="media-body">
                                                                                    <div class="chat-header">${post.key.user.name}</div>
                                                                                    <div class="f-13 text-muted">${post.key.getRealDate()}</div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="card-block">
                                                                            <div class="timeline-details">
                                                                                <c:if test="${post.key.post != null}">
                                                                                    ${post.key.post}
                                                                                </c:if>
                                                                                <c:if test="${post.key.imageUrl != null}">
                                                                                    <img src="/content/postImages/${post.key.imageUrl}" style="width: 100%; border-radius: 16px">
                                                                                </c:if>
                                                                            </div>
                                                                        </div>
                                                                        <!--<div class="b-t-theme social-msg">
                                                                            <a>
                                                                                <i class="icofont icofont-heart-alt text-muted"></i><span class="b-r-theme">Like</span>
                                                                            </a>
                                                                            <a>
                                                                                <i class="icofont icofont-comment text-muted"></i><span class="b-r-theme">Comments</span>
                                                                            </a>
                                                                        </div>-->
                                                                        <div class="card-block user-box" style="padding-top: 0">
                                                                            <c:forEach var="comment" items="${post.value}">
                                                                                <div class="media" style="padding-top: 1.25rem">
                                                                                    <a class="media-left" style="padding-right: 0">
                                                                                        <img class="media-object img-circle m-r-20" src="/content/profileImages/${comment.value.user.profilImg}" alt="Generic placeholder image">
                                                                                    </a>
                                                                                    <div class="media-body" style="border-radius: 8px;background-color: #4b556614;padding: 16px;">
                                                                                        <div class="chat-header">${comment.value.user.name}</div>
                                                                                        <p class="text-muted" style="margin: 0">${comment.value.comment}</p>
                                                                                    </div>
                                                                                </div>
                                                                            </c:forEach>
                                                                            <hr>
                                                                            <div class="media">
                                                                                <a class="media-left">
                                                                                    <img class="media-object img-circle m-r-20 comment-avatar" src="/content/profileImages/${post.key.user.profilImg}" alt="Generic placeholder image">
                                                                                </a>
                                                                                <div class="media-body">
                                                                                    <form class="">
                                                                                        <div class="row">
                                                                                            <input id="text${post.key.id}" class="col-11 f-13 form-control msg-send"/>
                                                                                            <div class="col-1 text-right">
                                                                                                <button style="padding: 0;padding-top: 4px" class="btn btn-primary waves-effect waves-light btn-icon" onclick="$.post('/docomment', {userPostId: ${post.key.id}, comment: document.getElementById('text${post.key.id}').value }, function () { window.location='/home'; });">
                                                                                                    <i style="font-size: 25px;margin: 0" class="icofont icofont-paper-plane"></i>
                                                                                                </button>
                                                                                            </div>
                                                                                        </div>
                                                                                    </form>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="col-3">
                                                <c:if test="${sessionHandler.userHasPermission('HOME_HEADER_BUTTONS')}">
                                                    <div class="row" style="position: fixed;width: auto;">
                                                        <div class="col-12">
                                                            <a href="/calendar" class="card overflow-hidden" style="max-width: 90%;border:none;background-color: #3B5998">
                                                                <div class="card-body">
                                                                    <h1 style="color: #fff;font-size: 65px;font-weight: 600;margin-left: 16px;margin-top: 0;margin-bottom: 16px">${nextTraining.trainingDate.split("-")[1].trim()}</h1>
                                                                    <img style="width: 100%" src="/content/baseImages/119097464_3315359685224384_3814610594506716376_n.png">
                                                                    <c:if test="${nextTraining != null}">
                                                                        <h3 style="color: #fff;margin-top: -130px;margin-bottom: 100px;margin-left: 16px">${nextTrainingDay}</h3>
                                                                        <h3 style="color: #fff;margin-top: -100px;margin-bottom: 100px;margin-left: 16px">${nextTraining.trainingDate.split("-")[0].trim()}</h3>
                                                                    </c:if>
                                                                    <c:if test="${nextTraining == null}">
                                                                        <p>Nincs edzés a közeljövőben.</p>
                                                                    </c:if>
                                                                </div>
                                                            </a>
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="card overflow-hidden" style="max-width: 90%;border:none;background-color: #3B5998">
                                                                <div class="card-body text-center">
                                                                    <h1 style="color: #fff">${city}</h1>
                                                                    <h1 style="color: #fff;font-size: 50px;font-weight: 600;">${temp}°</h1>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Warning Section Starts -->
    <!-- Older IE warning message -->
    <!--[if lt IE 9]>
    <div class="ie-warning">
        <h1>Warning!!</h1>
        <p>You are using an outdated version of Internet Explorer, please upgrade <br/>to any of the following web browsers to access this website.</p>
        <div class="iew-container">
            <ul class="iew-download">
                <li>
                    <a href="http://www.google.com/chrome/">
                        <img src="../assets/vendor/assets/images/browser/chrome.png" alt="Chrome">
                        <div>Chrome</div>
                    </a>
                </li>
                <li>
                    <a href="https://www.mozilla.org/en-US/firefox/new/">
                        <img src="../assets/vendor/assets/images/browser/firefox.png" alt="Firefox">
                        <div>Firefox</div>
                    </a>
                </li>
                <li>
                    <a href="http://www.opera.com">
                        <img src="../assets/vendor/assets/images/browser/opera.png" alt="Opera">
                        <div>Opera</div>
                    </a>
                </li>
                <li>
                    <a href="https://www.apple.com/safari/">
                        <img src="../assets/vendor/assets/images/browser/safari.png" alt="Safari">
                        <div>Safari</div>
                    </a>
                </li>
                <li>
                    <a href="http://windows.microsoft.com/en-us/internet-explorer/download-ie">
                        <img src="../assets/vendor/assets/images/browser/ie.png" alt="">
                        <div>IE (9 & above)</div>
                    </a>
                </li>
            </ul>
        </div>
        <p>Sorry for the inconvenience!</p>
    </div>
    <![endif]-->
    <!-- Warning Section Ends -->
    <!-- Required Jquery -->
    <script type="text/javascript" src="../assets/vendor/bower_components/jquery/js/jquery.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/jquery-ui/js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/popper.js/js/popper.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/bootstrap/js/bootstrap.min.js"></script>
    <!-- jquery slimscroll js -->
    <script type="text/javascript" src="../assets/vendor/bower_components/jquery-slimscroll/js/jquery.slimscroll.js"></script>
    <!-- modernizr js -->
    <script type="text/javascript" src="../assets/vendor/bower_components/modernizr/js/modernizr.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/modernizr/js/css-scrollbars.js"></script>
    <!-- classie js -->
    <script type="text/javascript" src="../assets/vendor/bower_components/classie/js/classie.js"></script>
    <!-- i18next.min.js -->
    <script type="text/javascript" src="../assets/vendor/bower_components/i18next/js/i18next.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/i18next-xhr-backend/js/i18nextXHRBackend.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/i18next-browser-languagedetector/js/i18nextBrowserLanguageDetector.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/jquery-i18next/js/jquery-i18next.min.js"></script>
    <!-- Custom js -->
    <script type="text/javascript" src="../assets/vendor/assets/js/script.js"></script>
    <script src="../assets/vendor/assets/js/pcoded.min.js"></script>
    <script src="../assets/vendor/assets/js/demo-12.js"></script>
    <script src="../assets/vendor/assets/js/jquery.mCustomScrollbar.concat.min.js"></script>
    <script src="../assets/vendor/assets/js/jquery.mousewheel.min.js"></script>

    <script src="../assets/js/Header.js"></script>
    <script src="../assets/js/Index.js"></script>
    </body>
    </html>
</c:if>
<c:if test="${sessionHandler.userHasPermission('ADMIN')}">
    <html>
    <head>
        <%@include file="include/Head.jsp" %>
    </head>
    <body class="c-app" id="page-top">
    <%@include file="include/Sidebar.jsp" %>
    <div class="c-wrapper c-fixed-components">
        <%@include file="include/Header.jsp" %>
        <div class="c-body">
            <main class="c-main">
                <div class="container-fluid">
                    <div class="ui-view">
                        <div class="fade-in">
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <%@include file="include/Footer.jsp" %>
        <%@include file="include/Logout.jsp" %>
        <%@include file="include/Js.jsp" %>
    </div>
    </body>
    </html>
</c:if>