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
    <title>Teampress | Naptár</title>
    <%@include file="../include/Css.jsp" %>
    <link rel="stylesheet" href="../../assets/css/play/Calendar.css" type="text/css"/>
</head>
<body>
    <%@include file="../include/Loader.jsp" %>
    <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">
            <%@include file="../include/Header.jsp" %>
            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <%@include file="../include/Sidebar.jsp" %>
                    <div class="pcoded-content" style="overflow-y: scroll; top:4em">
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <div class="page-body">
                                        <div class="card animated fadeInUpBig">
                                            <div class="card-header">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <h5>Naptár</h5>
                                                        <span>Téged érintő események</span>
                                                    </div>
                                                    <div class="col-6">
                                                        <c:if test="${sessionHandler.userHasPermission('EVENT_CREATE')}">
                                                            <button style="float: right" class="btn btn-primary btn-soft" data-toggle="modal" data-target="#eventModal"><i class="ti-plus"></i> Új esemény</button>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-block">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <div id='calendar'></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${sessionHandler.userHasPermission('EVENT_CREATE')}">
                                            <div class="modal fade" id="eventModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-success modal-lg" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 id="trainingModalTitle" class="modal-title">Esemény létrehozás</h4>
                                                            <button id="close" class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-12 col-md-4">
                                                                    <input id="name" type="text" class="form-control" required>
                                                                </div>
                                                                <div class="col-12 col-md-4">
                                                                    <select id="type">
                                                                        <c:if test="${sessionHandler.userHasPermission('EVENT_OWNER')}">
                                                                            <option value="0">Teljes egyesület</option>
                                                                        </c:if>
                                                                        <c:forEach var="team" items="${teams}">
                                                                            <option value="${team.type.id}">${team.type.code}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                                <div class="col-12 col-md-4">
                                                                    <input type="text" autocomplete="off" class="form-control" id="date"/>
                                                                </div>
                                                                <div class="col-12">
                                                                    <button onclick="createCalendarEvent()" class="btn btn-primary btn-soft">Mentés</button>
                                                                </div>
                                                            </div>
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
    <%@include file="../include/IE.jsp" %>
    <%@include file="../include/JavaScript.jsp" %>
    <script src="../../assets/js/play/Calendar.js"></script>
</body>
</html>
