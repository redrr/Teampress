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
    <title>Teampress | Gyakorlatok</title>
    <%@include file="../include/Css.jsp" %>
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
            <%@include file="../include/Header2.jsp" %>
            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <%@include file="../include/Sidebar2.jsp" %>
                    <div class="pcoded-content" style="overflow-y: scroll; top:4em">
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <div class="page-body">
                                        <c:if test="${sessionHandler.userHasPermission('TEAMS_STAT')}">
                                            <div class="row">
                                                <div class="col-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <div class="row">
                                                                <div class="col-6">
                                                                    <h5>Csapat</h5>
                                                                    <span>Csapatok</span>
                                                                </div>
                                                                <div class="col-6">
                                                                    <select style="float: right; width: auto;min-width: 150px;" id="teamSelect" onchange="selectByTeam($(this))">
                                                                        <c:forEach var="data" items="${teams}">
                                                                            <option value="${data.key.id}">${data.key.code}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <c:forEach var="team" items="${teams}">
                                                        <div id="team_${team.key.id}" class="row">
                                                            <c:forEach var="player" items="${team.value}">
                                                                <div class="col-12 col-xl-3">
                                                                    <div class="card overflow-hidden">
                                                                        <div class="card-body p-0 d-flex align-items-center" style="height: 100px">
                                                                            <div class="row p-0 d-flex align-items-center" style="width: 100%">
                                                                                <div class="col-6" style="padding-right: 0">
                                                                                    <img class="img-circle" style="width: 100%;max-width: 100px;max-height: 80px;margin-left: 10px;width: 80px;height: 80px;" src="/content/profileImages/${player.player.profilImg}">
                                                                                </div>
                                                                                <div class="col-6" style="padding-left: 0">
                                                                                    <div class="text-center" style="font-size: 16px;font-weight: 600;margin-bottom: 8px;">${player.player.name}</div>
                                                                                    <div class="text-center">
                                                                                        <button class="btn btn-primary btn-soft">Részletek</button>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </c:forEach>
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
    <script>
        <%@include file="../../assets/js/play/Exercise.js" %>
    </script>
</body>
</html>