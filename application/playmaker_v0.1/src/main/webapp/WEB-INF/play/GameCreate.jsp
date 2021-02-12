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
    <title>Teampress | Meccsek</title>
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
                                        <div class="row  animated fadeInUpBig">
                                            <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Meccs létrehozás</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <f:form id="form" name='f' cssClass="form-wp1" htmlEscape="true" action='/game' method='POST' modelAttribute="modifyGame" autocomplete="off">
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
                                                                <label for="date" class="col-4 col-form-label">Időpont</label>
                                                                <div class="col-8 col-form-label" id="asd">
                                                                    <f:input required="true" type="text" autocomplete="off" path="date" cssErrorClass="form-control" cssClass="form-control" id="date"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row bmd-form-group">
                                                                <label for="team" class="col-4 col-form-label">Csapat</label>
                                                                <div class="col-8 col-form-label">
                                                                    <f:select path="teamId" required="true" id="team" cssClass="selectpicker show-tick" data-size="5" data-live-search="true">
                                                                        <c:forEach var="type" items="${types}">
                                                                            <option value="${type.getId()}">
                                                                                    ${type.getCode()}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="enemy" class="col-4 col-form-label">Ellenfél</label>
                                                                <div class="col-8 col-form-label">
                                                                    <f:input type="text" required="true" autocomplete="off" path="enemy" cssErrorClass="form-control" cssClass="form-control" id="enemy"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="place" class="col-4 col-form-label">Helyszín</label>
                                                                <div class="col-8 col-form-label">
                                                                    <f:input type="text" required="true" autocomplete="off" path="place" cssErrorClass="form-control" cssClass="form-control" id="place"/>
                                                                </div>
                                                            </div>
                                                            <f:hidden path="version" id="modifyLanguage_version"/>
                                                            <f:hidden path="id" id="id"/>
                                                            <div class="form-group row">
                                                                <div class="col-12">
                                                                    <button class="btn btn-primary btn-soft" type="submit"><i class="ti-save"></i> Mentés</button>
                                                                    <button type="button" id="clear" class="btn btn-secondary btn-soft" onclick="window.location='/game'"><i class="ti-close"></i> Mégse</button>
                                                                </div>
                                                            </div>
                                                        </f:form>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Meccsek</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Időpont</th>
                                                                <th>Csapat</th>
                                                                <th>Ellenfél</th>
                                                                <th>Helyszín</th>
                                                                <th>Műveletek</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${table}">
                                                                <tr>
                                                                    <td>${data.getDateAs(false)}</td>
                                                                    <td>${data.team.code}</td>
                                                                    <td>${data.enemy}</td>
                                                                    <td>${data.place}</td>
                                                                    <td>
                                                                        <button type="button" class="btn btn-primary btn-soft" onclick="load(${data.id})"><i class="ti-pencil-alt"></i> Módosítás</button>
                                                                        <button type="button" class="btn btn-danger btn-soft" onclick="deleteEntry(${data.id}, '/game')"><i class="ti-trash"></i> Törlés</button>
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
        <%@include file="../../assets/js/play/GameCreate.js" %>
    </script>
</body>
</html>