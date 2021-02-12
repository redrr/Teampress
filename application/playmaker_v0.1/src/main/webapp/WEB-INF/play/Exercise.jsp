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
                                            <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Gyakorlat létrehozás</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/training/exercise' method='POST' modelAttribute="modifyExercise">
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
                                                                <label for="name" class="col-sm-4 col-form-label">Gyakorlat neve</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input type="text" required="" autocomplete="off" path="name" cssErrorClass="form-control" cssClass="form-control" id="name"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row bmd-form-group">
                                                                <label for="type" class="col-sm-4 col-form-label">Értékelés típusa</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:select path="typeId" required="true" id="type" cssClass="selectpicker show-tick" data-size="5" data-live-search="true">
                                                                        <c:forEach items="${types}" var="type">
                                                                            <option value="${type.getId()}">
                                                                                    ${type.getCode()}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                            </div>
                                                            <f:hidden path="version" id="version"/>
                                                            <f:hidden path="id" id="id"/>
                                                            <div class="form-group row bmd-form-group">
                                                                <div class="col-12">
                                                                    <button class="btn btn-primary btn-soft" type="submit"><i class="ti-save"></i> Mentés</button>
                                                                    <button type="button" id="clear" class="btn btn-secondary btn-soft" onclick="window.location='/training/exercise'"><i class="ti-close"></i> Mégse</button>
                                                                </div>
                                                            </div>
                                                        </f:form>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Gyakorlatok</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="exerciseTable" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Név</th>
                                                                <th>Típus</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${datas}">
                                                                <tr>
                                                                    <td>${data.name}</td>
                                                                    <td>${data.type.code}</td>
                                                                    <td>
                                                                        <button type="button" class="btn btn-primary btn-soft" onclick="showLanguage(${data.id}, ${data.type.id}, '${data.name}')"><i class="ti-pencil-alt"></i> Módosítás</button>
                                                                        <button type="button" class="btn btn-danger btn-soft" onclick="delLanguage(${data.id})"><i class="ti-trash"></i> Törlés</button>
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
    <script src="../../assets/js/play/Exercise.js"></script>
</body>
</html>