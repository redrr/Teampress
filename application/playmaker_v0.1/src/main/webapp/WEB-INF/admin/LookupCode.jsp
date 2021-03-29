<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/JSTL.jsp" %>
<html>
    <head>
        <title>Teampress | Elemek</title>
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
                                                                <h4 class="card-title">Elem létrehozás</h4>
                                                                <hr>
                                                                <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/sys/lookup' method='POST' modelAttribute="model">
                                                                    <div class="form-group row">
                                                                        <label for="name" class="col-sm-4 col-form-label">Név</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="name" type="text" required="" path="name" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="lgroup" class="col-sm-4 col-form-label">Csoport</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="lgroup" type="text" required="" path="lgroup" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="code" class="col-sm-4 col-form-label">Kód</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="code" type="text" required="" path="code" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="description" class="col-sm-4 col-form-label">Leírás</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="description" type="text" path="description" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <f:hidden path="version" id="version"/>
                                                                    <f:hidden path="id" id="id"/>
                                                                    <div class="form-group row">
                                                                        <div class="dt-btn-flex">
                                                                            <input id="submit" class="btn btn-success btn-soft" name="save" type="submit" value="Mentés"/>
                                                                            <button type="button" id="clear-form-btn" class="btn btn-light btn-soft" onclick="window.location = '/sys/lookup'">
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
                                                                <h4 class="card-title">Elemek</h4>
                                                            </div>
                                                            <div class="card-body">
                                                                <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                                    <thead>
                                                                    <tr>
                                                                        <th>#</th>
                                                                        <th>Név</th>
                                                                        <th>Csoport</th>
                                                                        <th>Kód</th>
                                                                        <th>Leírás</th>
                                                                        <th></th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <c:forEach var="data" items="${datas}">
                                                                        <tr>
                                                                            <td>${data.id}</td>
                                                                            <td>${data.name}</td>
                                                                            <td>${data.lgroup}</td>
                                                                            <td>${data.code}</td>
                                                                            <td>${data.description}</td>
                                                                            <td>
                                                                                <button type="button" class="btn btn-info btn-soft" onclick="get(${data.id})"><i class="cil-description"></i> Módosítás</button>
                                                                                <button type="button" class="btn btn-danger btn-soft" onclick="del(${data.id})"><i class="cil-trash"></i> Törlés</button>
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
        <script src="<c:url value="/assets/js/admin/LookupCode.js"/>"></script>
    </body>
</html>
