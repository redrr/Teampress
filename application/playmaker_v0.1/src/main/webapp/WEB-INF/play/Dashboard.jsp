<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/JSTL.jsp" %>
<html>
    <head>
        <title>Teampress | </title>
        <%@include file="../include/Css.jsp" %>
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
                                        <div class="row animated fadeInUpBig">
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Sportolóim</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="playerTable" class="table table-striped table-bordered" style="width:100%; font-size: 14px">
                                                            <thead>
                                                            <tr>
                                                                <th data-priority="1">Név</th>
                                                                <th>Csapat</th>
                                                                <th>Email cím</th>
                                                                <th data-priority="1">Műveletek</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="uOrg" items="${players}">
                                                                <tr>
                                                                    <td>${uOrg.user.name}</td>
                                                                    <td>${uOrg.teamsToDisplay()}</td>
                                                                    <td>${uOrg.user.email}</td>
                                                                    <c:if test="${uOrg.user.enabled}">
                                                                        <td>
                                                                            <button class="btn btn-icon btn-danger" onclick="manageUser('${uOrg.user.username}', false)">
                                                                                <i class="ti-lock"></i>
                                                                            </button>
                                                                        </td>
                                                                    </c:if>
                                                                    <c:if test="${!uOrg.user.enabled}">
                                                                        <td>
                                                                            <button class="btn btn-icon btn-primary" onclick="manageUser('${uOrg.user.username}', true)">
                                                                                <i class="ti-unlock"></i>
                                                                            </button>
                                                                        </td>
                                                                    </c:if>
                                                                </tr>
                                                            </c:forEach>
                                                            </tbody>
                                                            <tfoot>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <c:if test="${sessionHandler.userHasPermission('MY_CLUB')}">
                                                <div class="col-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h5>Edzőim</h5>
                                                        </div>
                                                        <div class="card-block">
                                                            <table id="trainerTable" class="table table-striped table-bordered" style="width:100%; font-size: 14px">
                                                                <thead>
                                                                <tr>
                                                                    <th data-priority="1">Név</th>
                                                                    <th>Csapat</th>
                                                                    <th>Email cím</th>
                                                                    <th data-priority="1">Műveletek</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                <c:forEach var="uOrg" items="${trainers}">
                                                                    <tr>
                                                                        <td>${uOrg.user.name}</td>
                                                                        <td>${uOrg.teamsToDisplay()}</td>
                                                                        <td>${uOrg.user.email}</td>
                                                                        <c:if test="${uOrg.user.enabled}">
                                                                            <td>
                                                                                <button class="btn btn-icon btn-danger" onclick="manageUser('${uOrg.user.username}', false)">
                                                                                    <i class="ti-lock"></i>
                                                                                </button>
                                                                            </td>
                                                                        </c:if>
                                                                        <c:if test="${!uOrg.user.enabled}">
                                                                            <td>
                                                                                <button class="btn btn-icon btn-primary" onclick="manageUser('${uOrg.user.username}', true)">
                                                                                    <i class="ti-unlock"></i>
                                                                                </button>
                                                                            </td>
                                                                        </c:if>
                                                                    </tr>
                                                                </c:forEach>
                                                                </tbody>
                                                                <tfoot>
                                                                </tfoot>
                                                            </table>
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
    <%@include file="../include/IE.jsp" %>
    <%@include file="../include/JavaScript.jsp" %>
    <script src="../../assets/js/play/Dashboard.js"></script>
    </body>
</html>
