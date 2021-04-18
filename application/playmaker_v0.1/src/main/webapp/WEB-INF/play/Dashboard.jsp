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
                                                                <th data-priority="2" search="disabled">Műveletek</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="uOrg" items="${players}">
                                                                <tr>
                                                                    <td>${uOrg.user.name}</td>
                                                                    <td>${uOrg.teamsToDisplay()}</td>
                                                                    <td>${uOrg.user.email}</td>
                                                                    <td>
                                                                        <c:if test="${uOrg.user.enabled}">
                                                                            <button class="btn btn-icon btn-danger" onclick="manageUser('${uOrg.user.username}', false)">
                                                                                <i class="ti-lock"></i>
                                                                            </button>
                                                                        </c:if>
                                                                        <c:if test="${!uOrg.user.enabled}">
                                                                            <button class="btn btn-icon btn-primary" onclick="manageUser('${uOrg.user.username}', true)">
                                                                                <i class="ti-unlock"></i>
                                                                            </button>
                                                                        </c:if>
                                                                        <button class="btn btn-info btn-icon" onclick="changeTeam('${uOrg.teamsToDisplay()}','${uOrg.user.username}')">
                                                                            <i class="ti-exchange-vertical"></i>
                                                                        </button>
                                                                        <button class="btn btn-primary btn-icon" onclick="addTeam('${uOrg.user.username}')">
                                                                            <i class="ti-plus"></i>
                                                                        </button>
                                                                        <button class="btn btn-danger btn-icon" onclick="removeTeam('${uOrg.teamsToDisplay()}','${uOrg.user.username}')">
                                                                            <i class="ti-trash"></i>
                                                                        </button>
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
                                                                    <th data-priority="2" search="disabled">Műveletek</th>
                                                                </tr>
                                                                </thead>
                                                                <tbody>
                                                                <c:forEach var="uOrg" items="${trainers}">
                                                                    <tr>
                                                                        <td>${uOrg.user.name}</td>
                                                                        <td>${uOrg.teamsToDisplay()}</td>
                                                                        <td>${uOrg.user.email}</td>
                                                                        <td>
                                                                            <c:if test="${uOrg.user.enabled}">
                                                                                <button class="btn btn-icon btn-danger" onclick="manageUser('${uOrg.user.username}', false)">
                                                                                    <i class="ti-lock"></i>
                                                                                </button>
                                                                            </c:if>
                                                                            <c:if test="${!uOrg.user.enabled}">
                                                                                <button class="btn btn-icon btn-primary" onclick="manageUser('${uOrg.user.username}', true)">
                                                                                    <i class="ti-unlock"></i>
                                                                                </button>
                                                                            </c:if>
                                                                            <button class="btn btn-info btn-icon" onclick="changeTeam('${uOrg.teamsToDisplay()}','${uOrg.user.username}')">
                                                                                <i class="ti-exchange-vertical"></i>
                                                                            </button>
                                                                            <button class="btn btn-primary btn-icon" onclick="addTeam('${uOrg.user.username}')">
                                                                                <i class="ti-plus"></i>
                                                                            </button>
                                                                            <button class="btn btn-danger btn-icon" onclick="removeTeam('${uOrg.teamsToDisplay()}','${uOrg.user.username}')">
                                                                                <i class="ti-trash"></i>
                                                                            </button>
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
                                        <!-- Change Team -->
                                        <button id="btnChangeTeam" style="display: none" class="btn btn-primary btn-soft" data-toggle="modal" data-target="#teamModal"></button>
                                        <div class="modal fade" id="teamModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Átigazolás</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="form-group row">
                                                            <div class="col-12 col-md-6">
                                                                <label for="origTeamsChangeTeam">Eredeti csapat</label>
                                                            </div>
                                                            <div class="col-12 col-md-6">
                                                                <select id="origTeamsChangeTeam"></select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-12 col-md-6">
                                                                <label for="allTeamsChangeTeam">Új csapat</label>
                                                            </div>
                                                            <div class="col-12 col-md-6">
                                                                <select id="allTeamsChangeTeam">
                                                                    <c:forEach var="team" items="${allTeam}">
                                                                        <option value="${team.code}">${team.code}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <input id="entityChangeTeam" type="hidden">
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-12">
                                                                <button onclick="changeTeamPost()" class="btn btn-primary btn-soft">Mentés</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Remove from Team -->
                                        <button id="btnRemoveTeam" style="display: none" class="btn btn-primary btn-soft" data-toggle="modal" data-target="#removeModal"></button>
                                        <div class="modal fade" id="removeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Tag eltávolítás</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="form-group row">
                                                            <div class="col-12 col-md-6">
                                                                <label for="origTeamsRemoveTeam">Eredeti csapat</label>
                                                            </div>
                                                            <div class="col-12 col-md-6">
                                                                <select id="origTeamsRemoveTeam"></select>
                                                            </div>
                                                            <input id="entityRemoveTeam" type="hidden">
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-12">
                                                                <button onclick="modifyTeamPost($('#entityRemoveTeam'), $('#origTeamsRemoveTeam'), false)" class="btn btn-primary btn-soft">Mentés</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Add Team -->
                                        <button id="btnAddTeam" style="display: none" class="btn btn-primary btn-soft" data-toggle="modal" data-target="#addModal"></button>
                                        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Tagfelvétel</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="form-group row">
                                                            <div class="col-12 col-md-6">
                                                                <label for="allTeamsAddTeam">Új csapat</label>
                                                            </div>
                                                            <div class="col-12 col-md-6">
                                                                <select id="allTeamsAddTeam">
                                                                    <c:forEach var="team" items="${allTeam}">
                                                                        <option value="${team.code}">${team.code}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <input id="entityAddTeam" type="hidden">
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-12">
                                                                <button onclick="modifyTeamPost($('#entityAddTeam'),$('#allTeamsAddTeam'), true)" class="btn btn-primary btn-soft">Mentés</button>
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
    <script src="../../assets/js/play/Dashboard.js"></script>
    </body>
</html>
