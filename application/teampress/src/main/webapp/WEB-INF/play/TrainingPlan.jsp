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
    <title>Teampress | Edzéstervező</title>
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
                                            <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <h5>Edzés létrehozás</h5>
                                                                <span>Edzés összeállítása</span>
                                                            </div>
                                                            <div class="col-6">
                                                                <button class="btn btn-primary btn-soft" style="float: right" data-toggle="modal" data-target="#add-exercise-modal">
                                                                    <i class="ti-plus"></i> Új gyakorlat
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/training/plan' method='POST' modelAttribute="modifyTrainingPlan">
                                                            <c:if test="${!error.equals('')}">
                                                                <div class="errors">
                                                                    <div class="row">
                                                                        <div class="col-12">
                                                                            <div class="alert alert-danger">${error}</div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                            <div class="form-group row">
                                                                <label for="date" class="col-3 col-form-label">Edzés időpont</label>
                                                                <div class="col-9 col-form-label" id="asd">
                                                                    <f:input type="text" required="true"  autocomplete="off" path="date" cssErrorClass="form-control" cssClass="form-control" id="date"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="team" class="col-3 col-form-label">Csapat</label>
                                                                <div class="col-9 col-form-label">
                                                                    <f:select path="team" required="true" id="team" cssClass="selectpicker show-tick" data-size="5" data-live-search="true">
                                                                        <c:forEach items="${teams}" var="t">
                                                                            <option value="${t.type.id}">
                                                                                    ${t.type.code}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-2">
                                                                    <b>#</b>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Név</b>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Típus</b>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Időtartam</b>
                                                                </div>
                                                                <div class="col-12">
                                                                    <hr>
                                                                </div>
                                                                <ul id="exerciseHolder" class="col-12"></ul>
                                                            </div>
                                                            <f:input path="data" id="trainingData" cssStyle="display: none"/>
                                                            <f:hidden path="version" id="modifyTraining_version"/>
                                                            <f:hidden path="id" id="modifyTraining_id"/>
                                                            <div class="form-group row">
                                                                <div class="col-12">
                                                                    <button class="btn btn-primary btn-soft" type="submit"><i class="ti-save"></i> Mentés</button>
                                                                    <button type="button" id="clear" class="btn btn-secondary btn-soft" onclick="window.location='/training/plan'"><i class="ti-close"></i> Mégse</button>
                                                                </div>
                                                            </div>
                                                        </f:form>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Edzéseim</h5>
                                                        <span>Általam felvett edzések</span>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="trainingPlanTable" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Időpont</th>
                                                                <th>Csapat</th>
                                                                <c:if test="${sessionHandler.userHasPermission('TRAIN_CREATE')}">
                                                                    <th search="disabled"></th>
                                                                </c:if>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${datas}">
                                                                <tr>
                                                                    <td>${data.formattedTrainingDate}</td>
                                                                    <td>${data.team.code}</td>
                                                                    <c:if test="${sessionHandler.userHasPermission('TRAIN_CREATE')}">
                                                                        <td>
                                                                            <button type="button" class="btn btn-primary btn-soft" onclick='showTraining(${data.id})'><i class="ti-pencil-alt"></i> Módosítás</button>
                                                                            <button type="button" class="btn btn-danger btn-soft" onclick="delTrainging(${data.id})"><i class="ti-trash"></i> Törlés</button>
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
    <div class="modal fade" id="add-exercise-modal" tabindex="-1">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Gyakorlat hozzáadás</h4>
                    <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label for="exercise" class="col-3 col-lg-2 col-form-label">Exercise</label>
                        <div class="col-9 col-lg-10">
                            <div class="form-group bmd-form-group">
                                <select id="exercise" title="" class="selectpicker" data-style="select-with-transition" data-live-search="true" data-dropup-auto="false" data-size="5" data-width="100%" >
                                    <c:forEach items="${exercises}" var="exercise">
                                        <option value="${exercise.id},${exercise.name},${exercise.type.code}">
                                                ${exercise.name} (<i>${exercise.type.code}</i>)
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="duration" class="col-3 col-lg-2 col-form-label">Duration</label>
                        <div class="col-9 col-lg-10">
                            <div class="input-group bmd-form-group">
                                <input type="number" autocomplete="off"  class="form-control" id="duration" aria-describedby="basic-addon2">
                                <div class="input-group-addon">
                                    <span class="input-group-text" id="basic-addon2">perc</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary btn-soft" onclick="addExercise($('#exercise'), $('#duration'))">Mentés</button>
                    <button type="button" id="close" class="btn btn-default btn-soft" data-dismiss="modal">Mégse</button>
                </div>
            </div>
        </div>
    </div>
    <%@include file="../include/IE.jsp" %>
    <%@include file="../include/JavaScript.jsp" %>
    <!-- jsDelivr :: Sortable :: Latest (https://www.jsdelivr.com/package/npm/sortablejs) -->
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"></script>
    <script>
        <%@include file="../../assets/js/play/TrainingPlan.js" %>
    </script>
</body>
</html>
