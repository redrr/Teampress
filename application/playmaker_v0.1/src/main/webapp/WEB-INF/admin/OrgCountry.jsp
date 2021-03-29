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
                                    <c:if test="${sessionHandler.userHasPermission('ADMIN')}">
                                        <div class="row animated fadeInUpBig">
                                            <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h4 class="card-title">Klubadat felvétel</h4>
                                                        <hr>
                                                        <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/org/orgcountry' method='POST' modelAttribute="model">
                                                            <div class="form-group row bmd-form-group">
                                                                <label for="organizationId" class="col-sm-4 col-form-label">Klub</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:select path="organizationId" required="true" id="organizationId">
                                                                        <c:forEach items="${org}" var="type">
                                                                            <option value="${type.getId()}">
                                                                                    ${type.getName()}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="fullname" class="col-sm-4 col-form-label">Teljes név</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="fullname" type="text" required="" autocomplete="off" path="fullname" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="country" class="col-sm-4 col-form-label">Ország</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="country" type="text" required="" autocomplete="off" path="country" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="postCode" class="col-sm-4 col-form-label">Irányítószám</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="postCode" type="number" required="" autocomplete="off" path="postCode" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="city" class="col-sm-4 col-form-label">Város</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="city" type="text" required="" autocomplete="off" path="city" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="street" class="col-sm-4 col-form-label">Utca</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="street" type="text" required="" autocomplete="off" path="street" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="street2" class="col-sm-4 col-form-label">Utca2</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="street2" type="text" required="" autocomplete="off" path="street2" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <f:hidden path="version" id="version"/>
                                                            <f:hidden path="id" id="id"/>
                                                            <div class="form-group row">
                                                                <div class="dt-btn-flex">
                                                                    <input id="submit" class="btn btn-success" name="save" type="submit" value="Mentés"/>
                                                                    <button type="button" id="clear-form-btn" class="btn btn-light" onclick="window.location = '/org/orgcountry'">
                                                                        Mégse
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </f:form>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h4 class="card-title">Klubok adatai</h4>
                                                    </div>
                                                    <div class="card-body">
                                                        <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Név</th>
                                                                <th>Ország</th>
                                                                <th>Irányítószám</th>
                                                                <th>Város</th>
                                                                <th>Utca</th>
                                                                <th>Utca2</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${datas}">
                                                                <tr>
                                                                    <td>${data.id}</td>
                                                                    <td>${data.name}</td>
                                                                    <td>${data.country}</td>
                                                                    <td>${data.postCode}</td>
                                                                    <td>${data.city}</td>
                                                                    <td>${data.street}</td>
                                                                    <td>${data.street2}</td>
                                                                    <td>
                                                                        <button type="button" class="btn btn-info" onclick="get(${data.id})"><i class="cil-description"></i> Módosítás</button>
                                                                        <button type="button" class="btn btn-danger" onclick="del(${data.id})"><i class="cil-trash"></i> Törlés</button>
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
<script src="<c:url value="/assets/js/admin/OrgCountry.js"/>"></script>
</body>
</html>
