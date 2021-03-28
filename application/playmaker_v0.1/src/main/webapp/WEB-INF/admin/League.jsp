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
        <%@include file="../include/Header2.jsp" %>
        <div class="pcoded-main-container">
            <div class="pcoded-wrapper">
                <%@include file="../include/Sidebar2.jsp" %>
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
                                                        <h4 class="card-title">Liga felvétel</h4>
                                                        <hr>
                                                        <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/org/league' method='POST' modelAttribute="model">
                                                            <div class="form-group row">
                                                                <label for="evad" class="col-sm-4 col-form-label">Évad</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="evad" type="text" required="" autocomplete="off" path="evad" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="szervezo" class="col-sm-4 col-form-label">Szervező</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="szervezo" type="text" required="" autocomplete="off" path="szervezo" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="liga" class="col-sm-4 col-form-label">Liga</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="liga" type="text" required="" autocomplete="off" path="liga" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="klubName" class="col-sm-4 col-form-label">Egyesület</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="klubName" type="text" required="" autocomplete="off" path="klubName" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="team" class="col-sm-4 col-form-label">Team</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input id="team" type="text" required="" autocomplete="off" path="team" cssErrorClass="form-control" cssClass="form-control"/>
                                                                </div>
                                                            </div>
                                                            <f:hidden path="version" id="version"/>
                                                            <f:hidden path="id" id="id"/>
                                                            <div class="form-group row">
                                                                <div class="dt-btn-flex">
                                                                    <input id="submit" class="btn btn-success" name="save" type="submit" value="Mentés"/>
                                                                    <button type="button" id="clear-form-btn" class="btn btn-light" onclick="window.location = '/org/league'">
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
                                                        <h4 class="card-title">Ligák</h4>
                                                    </div>
                                                    <div class="card-body">
                                                        <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>#</th>
                                                                <th>Évad</th>
                                                                <th>Szervező</th>
                                                                <th>Liga</th>
                                                                <th>Egyesület</th>
                                                                <th>Csapat</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${datas}">
                                                                <tr>
                                                                    <td>${data.id}</td>
                                                                    <td>${data.evad}</td>
                                                                    <td>${data.szervezo}</td>
                                                                    <td>${data.liga}</td>
                                                                    <td>${data.klubName}</td>
                                                                    <td>${data.team}</td>
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
<script src="<c:url value="/assets/js/admin/League.js"/>"></script>
</body>
</html>
