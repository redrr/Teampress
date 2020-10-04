<%--
  Created by IntelliJ IDEA.
  User: Matyi
  Date: 2020. 07. 24.
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@include file="../include/JSTL.jsp" %>
<html>
<head>
    <title>Teampress | Edzésmunka</title>
    <%@include file="../include/Css.jsp" %>
    <style>
        .md-tabs .nav-link.active {
            color: #fff!important;
            border: none!important;
            background-color: #1abc9c!important;
            border-radius: 8px!important;
            padding: 16px 0!important;
        }
    </style>
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
                                    <div class="row animated fadeInUpBig">
                                        <c:if test="${sessionHandler.userHasPermission('WORKOUT_CREATE')}">
                                            <div id="content" class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <h5>Edzés értékelés</h5>
                                                            </div>
                                                            <div class="col-6">
                                                                <button style="float: right" class="btn btn-light btn-icon" onclick="ignoreTraining()"><i style="margin: 0" class="ti-close"></i></button>
                                                                <button class="btn btn-primary btn-soft" style="float: right;margin-right: 16px;" type="button" onclick="saveTraining()"><i class="ti-save"></i>  Mentés</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <div class="nav-tabs-boxed">
                                                            <ul id="trainingNav" class="nav nav-tabs md-tabs tabs-left b-none" role="tablist" style="z-index: 700">
                                                                <!-- exercises list on training session -->
                                                            </ul>
                                                            <div id="trainingBody" class="tab-content tabs-left-content card-block" style="min-height: 100px;z-index: 700">
                                                                <!-- exercises on training session -->
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Edzés értékelés</h5>
                                                        <span>Értékelendő edzések</span>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="trainingPlanTable" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Időpont</th>
                                                                <th>Csapat</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${trainingsForJSP}">
                                                                <tr>
                                                                    <td>${data.trainingDate}</td>
                                                                    <td>${data.team.code}</td>
                                                                    <td class="start-progress" title="${data.id}">
                                                                        <button class="btn btn-primary btn-soft" type="button" onclick="getTrainingConsole(${data.id}, ${data.team.id}, '${data.team.code}')"><i class="ti-pencil-alt"></i>  Értékelés</button>
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
                                        <c:if test="${sessionHandler.userHasPermission('WORKOUT_PLAYER_TABLE')}">
                                            <!-- Player table-->
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Edzéseim</h5>
                                                        <span>Összes edzésem</span>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="trainingsTable" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Időpont</th>
                                                                <th>Csapat</th>
                                                                <th>Edző</th>
                                                                <th>Státusz</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${trainings}">
                                                                <tr>
                                                                    <td>${data.trainingDate}</td>
                                                                    <td>${data.team.code}</td>
                                                                    <td>${data.createdBy}</td>
                                                                    <td class="status" title="${data.id}"></td>
                                                                    <td>
                                                                        <button class="btn btn-primary btn-soft" type="button" data-toggle="modal" data-target="#trainingModal" onclick="setupTrainingModalForPlayer(${data.id}, '${data.trainingDate}')"><i class="ti-search"></i> Megnéz</button>
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
                                        <c:if test="${sessionHandler.userHasPermission('WORKOUT_ALL_TABLE')}">
                                            <!-- Full table-->
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-10">
                                                                <h5>Edzések</h5>
                                                                <span>Felvett edzések</span>
                                                            </div>
                                                            <div class="col-2">
                                                                <button class="btn btn-primary btn-soft" data-toggle="modal" data-target="#exportModal">Jelenlétiív export</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="OwnerTrainingsTable" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Időpont</th>
                                                                <th>Csapat</th>
                                                                <th>Edző</th>
                                                                <th>Státusz</th>
                                                                <th>Játékos</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${trainings}">
                                                                <tr>
                                                                    <td>${data.trainingDate}</td>
                                                                    <td>${data.team.code}</td>
                                                                    <td>${data.createdBy}</td>
                                                                    <td class="status" title="${data.id}"></td>
                                                                    <td>
                                                                        <div class="label-static">
                                                                            <select id="${data.id}" title="${data.team.id}" class="cr-pointer playerColumn"></select>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <button class="btn btn-primary btn-soft" type="button" data-toggle="modal" data-target="#trainingModal" onclick="setupTrainingModal(${data.id}, '${data.trainingDate}', $('#${data.id}'))"><i class="ti-search"></i> Megnéz</button>
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
                                    </div>
                                    <c:if test="${sessionHandler.userHasPermission('WORKOUT_ALL_TABLE') || sessionHandler.userHasPermission('WORKOUT_PLAYER_TABLE')}">
                                        <!-- Result modal-->
                                        <div class="modal" id="trainingModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-xl" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 id="trainingModalTitle" class="modal-title">Modal title</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div id="chartholder" class="col-xl-6 col-lg-8 col-md-12 col-12">
                                                                <canvas id="trainingStat" width="500" height="500"></canvas>
                                                            </div>
                                                            <div id="trainingModalBody" class="col-xl-6 col-lg-8 col-md-12 col-12" style="padding-right: 32px; padding-left: 32px"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Export modal -->
                                        <div class="modal fade" id="exportModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Jelenléti ív export</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="form-group row">
                                                            <div class="col-4 row">
                                                                <label for="team" class="col-sm-4 col-form-label">Csapat</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <select id="team">
                                                                        <c:forEach items="${teams}" var="type">
                                                                            <option value="${type.type.id}">
                                                                                    ${type.type.code}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-4 row">
                                                                <label for="date1" class="col-4 col-form-label">Kezdete</label>
                                                                <div class="col-8 col-form-label">
                                                                    <input type="text" autocomplete="off" class="form-control" id="date1"/>
                                                                </div>
                                                            </div>
                                                            <div class="col-4 row">
                                                                <label for="date2" class="col-4 col-form-label">Vége</label>
                                                                <div class="col-8 col-form-label">
                                                                    <input type="text" autocomplete="off" class="form-control" id="date2"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button class="btn btn-primary btn-soft" type="button" onclick="exportData()">Letöltés</button>
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
<script src="<c:url value="/assets/js/play/Workout.js"/>"></script>
</body>
</html>
