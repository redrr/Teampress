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
    <title>Teampress | Statisztika</title>
    <%@include file="../include/Css.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
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
                                    <c:if test="${sessionHandler.userHasPermission('PLAYERS_STAT')}">
                                        <!--Player Query Card-->
                                        <div class="row animated fadeInUpBig">
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-9 col-md-10">
                                                                <h5>Játékos statisztika</h5>
                                                                <span>Játékos statisztikák lekérdezése</span>
                                                            </div>
                                                            <div class="col-3 col-md-2">
                                                                <button class="btn btn-primary btn-soft" data-toggle="modal" data-target="#playerQueryModal"><i class="ti-plus"></i> Új lekérdezés</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-block" id="playerQueryBody">
                                                        <canvas id="playerChartHolder"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--Player Query modal -->
                                        <div class="modal fade" id="playerQueryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Játékos statisztika lekérdezés</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <div class="row">
                                                                    <div class="col-12">
                                                                        <b>Szempont</b>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <select id="playerQueryOption">
                                                                            <option></option>
                                                                            <c:forEach var="data" items="${playerLeagueOptions}">
                                                                                <option value="${data.key}">${data.value}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <div id="playerQueryLeagueTitle" class="col-12">
                                                                        <b id="playerQueryLeagueLabel">Liga</b>
                                                                    </div>
                                                                    <div id="playerQueryLeagueHolder" class="col-12">
                                                                        <div id="playerQueryLeagueRule" style="display: none"></div>
                                                                        <select id="playerQueryLeague">
                                                                            <option></option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <b>Játékosok</b>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <select id="playerSelect" class="js-example-basic-multiple" name="states[]" multiple="multiple">
                                                                            <option></option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-6">
                                                                <div class="row">
                                                                    <div id="yearHolder" class="col-12">
                                                                        <b>Év</b>
                                                                        <select id="year">
                                                                            <option></option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <b>Tól</b>
                                                                    </div>
                                                                    <div id="fordulofromHolder" class="col-12">
                                                                        <select id="fordulofrom">
                                                                            <option></option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <b>Ig</b>
                                                                    </div>
                                                                    <div id="fordulotoHolder" class="col-12">
                                                                        <select id="forduloto">
                                                                            <option></option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <b>Megjelenés</b>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <select id="typeSimpleData">
                                                                            <option></option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button class="btn btn-primary btn-soft" type="button" onclick="postPlayerQuery()">Kész</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${sessionHandler.userHasPermission('TRAINERS_STAT')}">
                                        <!--Trainer Query Card-->
                                        <div class="row animated fadeInUpBig">
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-9 col-md-10">
                                                                <h5>Edző statisztika</h5>
                                                                <span>Edzői statisztikák lekérdezése</span>
                                                            </div>
                                                            <div class="col-3 col-md-2">
                                                                <button class="btn btn-primary btn-soft" data-toggle="modal" data-target="#trainerQueryModal"><i class="ti-plus"></i> Új lekérdezés</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-block" id="trainerQueryBody">
                                                        <canvas id="trainerChartHolder"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--Trainer Query modal -->
                                        <div class="modal fade" id="trainerQueryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Edző statisztika lekérdezés</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <div class="row">
                                                                    <div class="col-12">
                                                                        <b>Szempont</b>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <select id="trainerQueryOption">
                                                                            <option></option>
                                                                            <c:forEach var="data" items="${trainerOptions}">
                                                                                <option value="${data.key}">${data.value}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <b>Megjelenés</b>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <select id="trainerChartType">
                                                                            <c:forEach var="data" items="${trainerChartTypes}">
                                                                                <option value="${data.key}">${data.value}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <b>Edzők</b>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <select id="trainerSelect" class="js-example-basic-multiple" name="states[]" multiple="multiple">
                                                                            <option></option>
                                                                            <c:forEach var="data" items="${trainers}">
                                                                                <option value="${data.key}">${data.value}</option>
                                                                            </c:forEach>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-6">
                                                                <div class="row">
                                                                    <div class="col-12">
                                                                        <b>Tól</b>
                                                                    </div>
                                                                    <div id="trainerQueryForduloFromHolder" class="col-12">
                                                                        <select id="trainerQueryForduloFrom">
                                                                            <option></option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="col-12">
                                                                        <b>Ig</b>
                                                                    </div>
                                                                    <div id="trainerQueryForduloToHolder" class="col-12">
                                                                        <select id="trainerQueryForduloTo">
                                                                            <option></option>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button class="btn btn-primary btn-soft" type="button" onclick="postTrainerQuery()">Kész</button>
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
<script src="../../assets/js/play/PlayerStat.js"></script>
<script src="../../assets/js/play/TrainerStat.js"></script>
</body>
</html>
