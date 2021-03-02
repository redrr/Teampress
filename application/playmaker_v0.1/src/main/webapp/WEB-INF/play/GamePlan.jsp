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
    <title>Teampress | Felállások</title>
    <%@include file="../include/Css.jsp" %>
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
                                    <div class="page-body">
                                        <div class="row animated fadeInUpBig">
                                            <c:if test="${sessionHandler.userHasPermission('PLANNER') || sessionHandler.userHasPermission('PLANS_TABLE')}">
                                                <div class="col-12">
                                                <div id="planner" class="card" style="display: none">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-8">
                                                                <h5 id="title"></h5>
                                                                <span>Felállás pontos megtervezése</span>
                                                            </div>
                                                            <div class="col-4">
                                                                <button style="float: right" type="button" class="btn btn-icon" onclick="$('#planner').hide();$('#teamPlayers').mCustomScrollbar('destroy')"><i style="margin: 0" class="ti-close"></i></button>
                                                                <c:if test="${sessionHandler.userHasPermission('PLANNER')}">
                                                                    <button style="float: right; margin-right: 24px" type="button" id="saveTeam" class="btn btn-primary btn-soft"><i style="margin: 0" class="ti-save"> Mentés</i></button>
                                                                </c:if>
                                                                <div id="gameTypeHolder" style="display: none"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <div id="container" style="background-image: url('/content/baseImages/${type}.jpg');background-repeat: no-repeat;background-size: 100% ;display: block;width: 100%;height: 812px; border-radius: 16px; margin-top: 38px"></div>
                                                            </div>
                                                            <div class="col-6">
                                                                <div id="playersSection">
                                                                    <div class="row" style="margin-right: 30px">
                                                                        <div class="col-4">
                                                                            <h5 style="margin-top: 16px">Játékos</h5>
                                                                        </div>
                                                                        <div id="statusBar" class="col-3 p-0">
                                                                            <div id="statusIcons" class="row">
                                                                                <div class="col-4">
                                                                                    <img style="max-width: 100%;height: 30px;float: right" src="../../content/icons/shirt_icon.png">
                                                                                </div>
                                                                                <div class="col-4">
                                                                                    <img style="max-width: 100%;height: 30px;padding: 4px" src='../../content/icons/change_icon.png'>
                                                                                </div>
                                                                                <div class="col-4">
                                                                                    <img style="max-width: 100%;height: 30px;padding: 4px" src='../../content/icons/cancel_icon.png'>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div id="statBar" class="col-4">
                                                                            <div class="row">
                                                                                <div class="col-4 text-center">
                                                                                    <img style="max-width: 100%;height: 30px;" src="../../content/icons/map_icon.png">
                                                                                </div>
                                                                                <div class="col-4 text-center">
                                                                                    <img style="max-width: 100%;height: 30px;" src='../../content/icons/shirt_icon.png'>
                                                                                </div>
                                                                                <div class="col-4 text-center">
                                                                                    <img style="max-width: 100%;height: 30px;" src='../../content/icons/ball_icon.png'>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div id="workoutButtonBar" style="padding-right: 0" class="col-1"></div>
                                                                    </div>
                                                                    <hr style="margin-top: 0">
                                                                    <div id="teamPlayers" style="height: 800px;overflow-y: auto;overflow-x: hidden"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            </c:if>
                                            <c:if test="${sessionHandler.userHasPermission('PLANNER')}">
                                                <div class="col-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h5>Liga meccsek</h5>
                                                        </div>
                                                        <div class="card-block">
                                                            <table id="sorsolasTable" class="table table-striped table-bordered" style="width:100%; font-size: 14px">
                                                                <thead>
                                                                <tr>
                                                                    <th data-priority="1">Dátum</th>
                                                                    <th>Liga</th>
                                                                    <th>Hazai</th>
                                                                    <th>Ellenfél</th>
                                                                    <th>Helyszín</th>
                                                                    <th data-priority="2">Művelet</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                <c:forEach var="data" items="${sorsolas}">
                                                                    <tr>
                                                                        <td>${data.getDateAs(false)}</td>
                                                                        <td>${data.liga.liga}</td>
                                                                        <td>${data.hazai}</td>
                                                                        <td>${data.vendeg}</td>
                                                                        <td>${data.hely}</td>
                                                                        <td>
                                                                            <button type="button" class="btn btn-primary btn-soft" onclick="$('#planner').show();loadEditorForTrainer(0,'${data.liga.id}', '${data.hazai}', '${data.vendeg}', '${data.id}', 'sors');"><i class="cil-search"></i> Kiválasztás</button>
                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                                </tbody>
                                                                <tfoot>
                                                                </tfoot>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <div class="card">
                                                        <div class="card-header">
                                                            <h5>Egyéb mérkőzések</h5>
                                                        </div>
                                                        <div class="card-block">
                                                            <table id="customTable" class="table table-striped table-bordered" style="width:100%; font-size: 14px">
                                                                <thead>
                                                                <tr>
                                                                    <th>Dátum</th>
                                                                    <th>Csapat</th>
                                                                    <th>Ellenfél</th>
                                                                    <th>Helyszín</th>
                                                                    <th>Művelet</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                <c:forEach var="data" items="${custom}">
                                                                    <tr>
                                                                        <td>${data.getDateAs(false)}</td>
                                                                        <td>${data.team.code}</td>
                                                                        <td>${data.enemy}</td>
                                                                        <td>${data.place}</td>
                                                                        <td>
                                                                            <button type="button" class="btn btn-primary btn-soft" onclick="$('#planner').show();loadEditorForTrainer(1,'${data.team.code}', '${data.organization.name}', '${data.enemy}', '${data.id}', 'cust');"><i class="cil-search"></i> Kiválasztás</button>
                                                                        </td>
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
                                            <c:if test="${sessionHandler.userHasPermission('PLANNER') || sessionHandler.userHasPermission('PLANS_TABLE')}">
                                                <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Mérkőzés tervek</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="completeTable" class="table table-striped table-bordered" style="width:100%; font-size: 14px">
                                                            <thead>
                                                            <tr>
                                                                <th>Dátum</th>
                                                                <th>Csapat/Liga</th>
                                                                <th>Hazai</th>
                                                                <th>Vendég</th>
                                                                <th>Helyszín</th>
                                                                <th>Művelet</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${table}">
                                                                <tr>
                                                                    <c:if test="${data.customGame != null}">
                                                                        <td>${data.customGame.getDateAs(false)}</td>
                                                                        <td>${data.customGame.team.code}</td>
                                                                        <td>${data.customGame.organization.name}</td>
                                                                        <td>${data.customGame.enemy}</td>
                                                                        <td>${data.customGame.place}</td>
                                                                        <td>
                                                                            <c:if test="${sessionHandler.userHasPermission('PLANNER')}">
                                                                                <button type="button" class="btn btn-primary btn-soft" onclick="$('#planner').show();getPlayersByPlayer(1,'${data.customGame.team.code}', '${data.customGame.organization.name}', '${data.customGame.enemy}', '${data.customGame.id}', 'cust', true);"><i class="ti-search"></i> Módosítás</button>
                                                                            </c:if>
                                                                            <c:if test="${!sessionHandler.userHasPermission('PLANNER')}">
                                                                                <button type="button" class="btn btn-primary btn-soft" onclick="$('#planner').show();getPlayersByPlayer(1,'${data.customGame.team.code}', '${data.customGame.organization.name}', '${data.customGame.enemy}', '${data.customGame.id}', 'cust', false);"><i class="ti-search"></i> Megnéz</button>
                                                                            </c:if>
                                                                        </td>
                                                                    </c:if>
                                                                    <c:if test="${data.sorsolas != null}">
                                                                        <td>${data.sorsolas.getDateAs(false)}</td>
                                                                        <td>${data.sorsolas.liga.liga}</td>
                                                                        <td>${data.sorsolas.hazai}</td>
                                                                        <td>${data.sorsolas.vendeg}</td>
                                                                        <td>${data.sorsolas.hely}</td>
                                                                        <td>
                                                                            <c:if test="${sessionHandler.userHasPermission('PLANNER')}">
                                                                                <button type="button" class="btn btn-primary btn-soft" onclick="$('#planner').show();getPlayersByPlayer(0,'${data.sorsolas.liga.id}', '${data.sorsolas.hazai}', '${data.sorsolas.vendeg}', '${data.sorsolas.id}', 'sors', true);"><i class="ti-search"></i> Módosítás</button>
                                                                            </c:if>
                                                                            <c:if test="${!sessionHandler.userHasPermission('PLANNER')}">
                                                                                <button type="button" class="btn btn-primary btn-soft" onclick="$('#planner').show();getPlayersByPlayer(0,'${data.sorsolas.liga.id}', '${data.sorsolas.hazai}', '${data.sorsolas.vendeg}', '${data.sorsolas.id}', 'sors', false);"><i class="ti-search"></i> Megnéz</button>
                                                                            </c:if>
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
                                        <!-- modal -->
                                        <div class="modal fade" id="trainingModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Edzésmunka</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div id="trainingModalBody" class="col-6"></div>
                                                            <div class="col-6">
                                                                <canvas id="trainingStat" width="400" height="400"></canvas>
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
                </div>
            </div>
        </div>
    </div>
    <%@include file="../include/IE.jsp" %>
    <%@include file="../include/JavaScript.jsp" %>
    <script src="../../assets/js/play/GamePlan.js" ></script>
</body>
</html>
