<%--
  Created by IntelliJ IDEA.
  User: Matyi
  Date: 2020. 07. 24.
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/JSTL.jsp" %>
<html>
<head>
    <title>Teampress | Videótár</title>
    <%@include file="../include/Css.jsp" %>
    <link rel="stylesheet" href="../../assets/css/play/videoCloud.css" type="text/css"/>
</head>
<body>
<%@include file="../include/Loader.jsp" %>
    <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">
            <%@include file="../include/Header2.jsp" %>
            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <%@include file="../include/Sidebar2.jsp" %>
                    <div class="pcoded-content" style="overflow-y: scroll; top:4em">
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <div class="page-body gallery-page">
                                        <div class="row animated fadeInUpBig">
                                            <div class="col-sm-12">
                                                <c:if test="${isFolderPage}">
                                                    <!-- Gallery advance card start -->
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h5>Videótár</h5>
                                                            <span>Elemzett videók jelenetei mappákba rendezve</span>
                                                        </div>
                                                        <div class="card-block">
                                                            <div class="row">
                                                                <div class="col-6 col-sm-12">
                                                                    <div class="grid">
                                                                        <c:forEach var="folder" items="${folders}">
                                                                            <figure class="effect-jazz">
                                                                                <img src="/content/folderImages/${folder.url}" alt="img25" />
                                                                                <figcaption>
                                                                                    <h2><span>${folder.name}</span></h2>
                                                                                    <p>${folder.description}</p>
                                                                                    <a href="/videocloud/${folder.id}">Megnyitás</a>
                                                                                </figcaption>
                                                                            </figure>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Gallery advance card end -->
                                                </c:if>
                                                <c:if test="${!isFolderPage}">
                                                    <!-- Gallery advance card start -->
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <div class="row">
                                                                <div class="col-6">
                                                                    <h5>${currentFolder.name}</h5>
                                                                    <span>${currentFolder.description}</span>
                                                                </div>
                                                                <div class="col-6">
                                                                    <a href="/videocloud" class="btn btn-light btn-soft" style="float: right"><i class="icofont icofont-undo" style="margin-left: 0"></i> Vissza</a>
                                                                    <select style="margin-top: 2px;margin-right: 16px;float: right; width: auto" id="searchByPlayer" onchange="searchByPlayer($(this))">
                                                                        <option value="">Összes</option>
                                                                        <c:forEach var="data" items="${videos}">
                                                                            <option value="${data.user.id}">${data.user.name}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="card-block" style="padding-top: 0;padding-bottom: 0;min-height: 50px;">
                                                            <div class="row">
                                                                <c:if test="${videos.size() < 1}">
                                                                    <div class="col-6" style="margin-bottom: 20px;padding: 2em;">
                                                                        <h6><span>Ez a mappa még üres!</span></h6>
                                                                    </div>
                                                                </c:if>
                                                                <c:forEach var="video" items="${videos}">
                                                                    <div class="col-6 video-element" style="margin-bottom: 20px;padding: 2em;">
                                                                        <div class="video-card">
                                                                            <b class="video-title">${video.name}</b>
                                                                            <video width="100%" controls>
                                                                                <source src="../../content/videoAnalytics/scene/${video.video.fileName}" type="video/mp4">
                                                                                Your browser does not support the video tag.
                                                                            </video>
                                                                            <p class="video-description">${video.description}</p>
                                                                            <div style="display: none" class="player-field">${video.user.id}</div>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <!-- Gallery advance card end -->
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
    <script src="/assets/js/play/VideoCloud.js"></script>
    <%@include file="../include/IE.jsp" %>
    <%@include file="../include/JavaScript.jsp" %>
</body>
</html>