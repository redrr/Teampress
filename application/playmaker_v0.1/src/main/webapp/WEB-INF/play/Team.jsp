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
                                                            <c:forEach var="teamData" items="${team.value}">
                                                                <c:forEach var="player" items="${teamData.value}">
                                                                    <div class="col-12 col-xl-3">
                                                                        <div class="card overflow-hidden">
                                                                            <div class="card-body p-0 d-flex align-items-center" style="height: 100px">
                                                                                <div class="row p-0 d-flex align-items-center" style="width: 100%">
                                                                                    <div class="col-6" style="padding-right: 0">
                                                                                        <img class="img-circle" style="max-width: 100px;max-height: 80px;margin-left: 10px;width: 80px;height: 80px;" src="/content/profileImages/${player.player.user.profilImg}">
                                                                                    </div>
                                                                                    <div class="col-6" style="padding-left: 0">
                                                                                        <div class="text-center" style="font-size: 16px;font-weight: 600;margin-bottom: 8px;">${player.player.user.name}</div>
                                                                                        <div class="text-center">
                                                                                            <button class="btn btn-primary btn-soft" data-toggle="modal" data-target="#playerModal-${player.player.id}">Részletek</button>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </c:forEach>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                            <!-- Stat modal -->
                                            <c:forEach var="team" items="${teams}">
                                                <c:forEach var="teamData" items="${team.value}">
                                                    <c:forEach var="player" items="${teamData.value}">

                                                        <div class="modal fade" id="playerModal-${player.player.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                            <div class="modal-dialog modal-dialog-centered modal-success modal-lg" role="document">
                                                                <div class="modal-content">
                                                                    <div class="modal-header" style="padding-top: 8px; padding-bottom: 8px">
                                                                        <!--<img class="img-circle" style="max-width: 120px;max-height: 120px;margin-left: 10px;width: 100px;height: 100px;margin-top: -50px; border: 4px solid #fff;background-color: #fff;" src="${player.player.organization.url}">-->
                                                                        <h4 class="modal-title">${player.player.user.name}</h4>
                                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="row">
                                                                            <div class="col-6">
                                                                                <div class="row" style="margin-bottom: 4px">
                                                                                    <div class="col-5">
                                                                                        <b>Meccsek</b>
                                                                                    </div>
                                                                                    <div class="col-7">
                                                                                        <b style="float: right">${player.playerData.meccsek}</b>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row" style="margin-bottom: 16px">
                                                                                    <div class="col-12">
                                                                                        <div style="background-color: #e9ecef; border-radius: 8px; width: 100%">
                                                                                            <div style="background-color: #28e1bd;width: ${player.playerData.meccsek / teamData.key.meccsek * 100}%;border-radius: 8px; height: 8px"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="row" style="margin-bottom: 4px">
                                                                                    <div class="col-5">
                                                                                        <b>Gólok</b>
                                                                                    </div>
                                                                                    <div class="col-7">
                                                                                        <b style="float: right">${player.playerData.golok}</b>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row" style="margin-bottom: 16px">
                                                                                    <div class="col-12">
                                                                                        <div style="background-color: #e9ecef; border-radius: 8px; width: 100%">
                                                                                            <div style="background-color: #28e1bd;width: ${player.playerData.golok / teamData.key.golok * 100}%;border-radius: 8px; height: 8px"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="row" style="margin-bottom: 4px">
                                                                                    <div class="col-5">
                                                                                        <b>Kezdő</b>
                                                                                    </div>
                                                                                    <div class="col-7">
                                                                                        <b style="float: right">${player.playerData.kezdo}</b>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row" style="margin-bottom: 16px">
                                                                                    <div class="col-12">
                                                                                        <div style="background-color: #e9ecef; border-radius: 8px; width: 100%">
                                                                                            <div style="background-color: #28e1bd;width: ${player.playerData.kezdo / teamData.key.kezdo * 100}%;border-radius: 8px; height: 8px"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="row" style="margin-bottom: 4px">
                                                                                    <div class="col-5">
                                                                                        <b>Csere</b>
                                                                                    </div>
                                                                                    <div class="col-7">
                                                                                        <b style="float: right">${player.playerData.csere}</b>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row" style="margin-bottom: 16px">
                                                                                    <div class="col-12">
                                                                                        <div style="background-color: #e9ecef; border-radius: 8px; width: 100%">
                                                                                            <div style="background-color: #28e1bd;width: ${player.playerData.csere / teamData.key.csere * 100}%;border-radius: 8px; height: 8px"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-6">
                                                                                <div class="row" style="margin-bottom: 4px">
                                                                                    <div class="col-5">
                                                                                        <b>Kispad</b>
                                                                                    </div>
                                                                                    <div class="col-7">
                                                                                        <b style="float: right">${player.playerData.kispad}</b>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row" style="margin-bottom: 16px">
                                                                                    <div class="col-12">
                                                                                        <div style="background-color: #e9ecef; border-radius: 8px; width: 100%">
                                                                                            <div style="background-color: #28e1bd;width: ${player.playerData.kispad / teamData.key.kispad* 100}%;border-radius: 8px; height: 8px"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="row" style="margin-bottom: 4px">
                                                                                    <div class="col-5">
                                                                                        <b>Öngólok</b>
                                                                                    </div>
                                                                                    <div class="col-7">
                                                                                        <b style="float: right">${player.playerData.onGolok}</b>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row" style="margin-bottom: 16px">
                                                                                    <div class="col-12">
                                                                                        <div style="background-color: #e9ecef; border-radius: 8px; width: 100%">
                                                                                            <div style="background-color: #28e1bd;width: ${player.playerData.onGolok / teamData.key.onGolok * 100}%;border-radius: 8px; height: 8px"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="row" style="margin-bottom: 4px">
                                                                                    <div class="col-5">
                                                                                        <b>Sárgalapok</b>
                                                                                    </div>
                                                                                    <div class="col-7">
                                                                                        <b style="float: right">${player.playerData.sargaLap}</b>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row" style="margin-bottom: 16px">
                                                                                    <div class="col-12">
                                                                                        <div style="background-color: #e9ecef; border-radius: 8px; width: 100%">
                                                                                            <div style="background-color: #28e1bd;width: ${player.playerData.sargaLap / teamData.key.sargaLap * 100}%;border-radius: 8px; height: 8px"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>

                                                                                <div class="row" style="margin-bottom: 4px">
                                                                                    <div class="col-5">
                                                                                        <b>Piroslapok</b>
                                                                                    </div>
                                                                                    <div class="col-7">
                                                                                        <b style="float: right">${player.playerData.pirosLap}</b>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row" style="margin-bottom: 16px">
                                                                                    <div class="col-12">
                                                                                        <div style="background-color: #e9ecef; border-radius: 8px; width: 100%">
                                                                                            <div style="background-color: #28e1bd;width: ${player.playerData.pirosLap / teamData.key.pirosLap * 100}%;border-radius: 8px; height: 8px"></div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:forEach>
                                            </c:forEach>
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
        <%@include file="../../assets/js/play/Team.js" %>
    </script>
</body>
</html>