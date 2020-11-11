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
                                            <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <h5>Edzés létrehozás</h5>
                                                                <span>Edzés összeállítása</span>
                                                            </div>
                                                            <div class="col-6">
                                                                <button id="add" onclick="shownext()" type="button" style="float: right" class="btn btn-primary btn-soft"><i class="ti-plus"></i> Új gyakorlat</button>
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
                                                                    <f:select path="team" required="true" id="team">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${teams}" var="t">
                                                                            <option value="${t.type.id}">
                                                                                    ${t.type.code}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col-3">
                                                                    <b>#</b>
                                                                </div>
                                                                <div class="col-6">
                                                                    <b>Gyakorlat</b>
                                                                </div>
                                                                <div class="col-3">
                                                                    <b>Időtartam</b>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow1" class="form-group row">
                                                                <label for="exercise1" class="col-3 col-form-label">1.</label>
                                                                <div class="col-6 col-form-label">
                                                                    <f:select path="exercise1" required="true" id="exercise1">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 col-form-label">
                                                                    <f:input type="number" required="true" autocomplete="off" path="exercise1Time" cssErrorClass="form-control" cssClass="form-control" id="exercise1Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow2" class="form-group row bmd-form-group">
                                                                <label for="exercise2" class="col-3 col-form-label">2.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise2" id="exercise2">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise2Time" cssErrorClass="form-control" cssClass="form-control" id="exercise2Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow3" class="form-group row bmd-form-group">
                                                                <label for="exercise3" class="col-3 col-form-label">3.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise3" id="exercise3">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise3Time" cssErrorClass="form-control" cssClass="form-control" id="exercise3Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow4" class="form-group row bmd-form-group">
                                                                <label for="exercise4" class="col-3 col-form-label">4.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise4" id="exercise4">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise4Time" cssErrorClass="form-control" cssClass="form-control" id="exercise4Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow5" class="form-group row bmd-form-group">
                                                                <label for="exercise5" class="col-3 col-form-label">5.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise5" id="exercise5">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise5Time" cssErrorClass="form-control" cssClass="form-control" id="exercise5Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow6" class="form-group row bmd-form-group">
                                                                <label for="exercise6" class="col-3 col-form-label">6.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise6" id="exercise6">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise6Time" cssErrorClass="form-control" cssClass="form-control" id="exercise6Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow7" class="form-group row bmd-form-group">
                                                                <label for="exercise7" class="col-3 col-form-label">7.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise7" id="exercise7">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise7Time" cssErrorClass="form-control" cssClass="form-control" id="exercise7Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow8" class="form-group row bmd-form-group">
                                                                <label for="exercise8" class="col-3 col-form-label">8.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise8" id="exercise8">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise8Time" cssErrorClass="form-control" cssClass="form-control" id="exercise8Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow9" class="form-group row bmd-form-group">
                                                                <label for="exercise9" class="col-3 col-form-label">9.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise9" id="exercise9">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise9Time" cssErrorClass="form-control" cssClass="form-control" id="exercise9Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow10" class="form-group row bmd-form-group">
                                                                <label for="exercise10" class="col-3 col-form-label">10.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise10" id="exercise10">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise10Time" cssErrorClass="form-control" cssClass="form-control" id="exercise10Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow11" class="form-group row bmd-form-group">
                                                                <label for="exercise11" class="col-3 col-form-label">11.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise11" id="exercise11">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise11Time" cssErrorClass="form-control" cssClass="form-control" id="exercise11Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow12" class="form-group row bmd-form-group">
                                                                <label for="exercise12" class="col-3 col-form-label">12.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise12" id="exercise12">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise12Time" cssErrorClass="form-control" cssClass="form-control" id="exercise12Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow13" class="form-group row bmd-form-group">
                                                                <label for="exercise13" class="col-3 col-form-label">13.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise13" id="exercise13">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise13Time" cssErrorClass="form-control" cssClass="form-control" id="exercise13Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow14" class="form-group row bmd-form-group">
                                                                <label for="exercise14" class="col-3 col-form-label">14.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise14" id="exercise14">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise14Time" cssErrorClass="form-control" cssClass="form-control" id="exercise14Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow15" class="form-group row bmd-form-group">
                                                                <label for="exercise15" class="col-3 col-form-label">15.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise15" id="exercise15">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise15Time" cssErrorClass="form-control" cssClass="form-control" id="exercise15Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow16" class="form-group row bmd-form-group">
                                                                <label for="exercise16" class="col-3 col-form-label">16.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise16" id="exercise16">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise16Time" cssErrorClass="form-control" cssClass="form-control" id="exercise16Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow17" class="form-group row bmd-form-group">
                                                                <label for="exercise17" class="col-3 col-form-label">17.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise17" id="exercise17">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise17Time" cssErrorClass="form-control" cssClass="form-control" id="exercise17Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow18" class="form-group row bmd-form-group">
                                                                <label for="exercise18" class="col-3 col-form-label">18.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise18" id="exercise18">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise18Time" cssErrorClass="form-control" cssClass="form-control" id="exercise18Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow19" class="form-group row  bmd-form-group">
                                                                <label for="exercise19" class="col-3 col-form-label">19.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise19"  id="exercise19">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise19Time" cssErrorClass="form-control" cssClass="form-control" id="exercise19Time"/>
                                                                </div>
                                                            </div>
                                                            <div id="exerciserow20" class="form-group row bmd-form-group">
                                                                <label for="exercise20" class="col-3 col-form-label">20.</label>
                                                                <div class="col-6 label-static">
                                                                    <f:select path="exercise20" id="exercise20">
                                                                        <option value=""></option>
                                                                        <c:forEach items="${exercises}" var="exercise">
                                                                            <option value="${exercise.id}">
                                                                                    ${exercise.name}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                                <div class="col-3 label-static">
                                                                    <f:input type="number" autocomplete="off" path="exercise20Time" cssErrorClass="form-control" cssClass="form-control" id="exercise20Time"/>
                                                                </div>
                                                            </div>
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
                                                                    <th></th>
                                                                </c:if>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${datas}">
                                                                <tr>
                                                                    <td>${data.trainingDate}</td>
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
    <%@include file="../include/IE.jsp" %>
    <%@include file="../include/JavaScript.jsp" %>
    <script>
        <%@include file="../../assets/js/play/TrainingPlan.js" %>
    </script>
</body>
</html>