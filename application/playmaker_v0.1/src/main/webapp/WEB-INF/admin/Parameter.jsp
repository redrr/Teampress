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
                                                                <h4 class="card-title">Paraméter létrehozás</h4>
                                                                <hr>
                                                                <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/sys/param' method='POST' modelAttribute="model">
                                                                    <div class="form-group row">
                                                                        <label for="group" class="col-sm-4 col-form-label">Csoport</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="group" type="text" required="" autocomplete="off" path="group" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="code" class="col-sm-4 col-form-label">Kód</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="code" type="text" required="" autocomplete="off" path="code" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="value" class="col-sm-4 col-form-label">Érték</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="value" type="text" required="" autocomplete="off" path="value" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="attr1" class="col-sm-4 col-form-label">Attr1</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="attr1" type="text" required="" autocomplete="off" path="attr1" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="attr2" class="col-sm-4 col-form-label">Attr2</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="attr2" type="text" required="" autocomplete="off" path="attr2" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="attr3" class="col-sm-4 col-form-label">Attr3</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="attr3" type="text" required="" autocomplete="off" path="attr3" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="attr4" class="col-sm-4 col-form-label">Attr4</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="attr4" type="text" required="" autocomplete="off" path="attr4" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group row">
                                                                        <label for="attr5" class="col-sm-4 col-form-label">Attr5</label>
                                                                        <div class="col-sm-8 label-static">
                                                                            <f:input id="attr5" type="text" required="" autocomplete="off" path="attr5" cssErrorClass="form-control" cssClass="form-control"/>
                                                                        </div>
                                                                    </div>
                                                                    <f:hidden path="version" id="version"/>
                                                                    <f:hidden path="id" id="id"/>
                                                                    <div class="form-group row">
                                                                        <div class="dt-btn-flex">
                                                                            <input id="submit" class="btn btn-success btn-soft" name="save" type="submit" value="Mentés"/>
                                                                            <button type="button" id="clear-form-btn" class="btn btn-light btn-soft" onclick="window.location = '/sys/param'">
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
                                                                <h4 class="card-title">Paraméterek</h4>
                                                            </div>
                                                            <div class="card-body">
                                                                <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                                    <thead>
                                                                    <tr>
                                                                        <th>#</th>
                                                                        <th>Csoport</th>
                                                                        <th>Kód</th>
                                                                        <th>Érték</th>
                                                                        <th>Attr1</th>
                                                                        <th>Attr2</th>
                                                                        <th>Attr3</th>
                                                                        <th>Attr4</th>
                                                                        <th>Attr5</th>
                                                                        <th></th>
                                                                    </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                    <c:forEach var="data" items="${datas}">
                                                                        <tr>
                                                                            <td>${data.id}</td>
                                                                            <td>${data.group}</td>
                                                                            <td>${data.code}</td>
                                                                            <td>${data.value}</td>
                                                                            <td>${data.attr1}</td>
                                                                            <td>${data.attr2}</td>
                                                                            <td>${data.attr3}</td>
                                                                            <td>${data.attr4}</td>
                                                                            <td>${data.attr5}</td>
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
        <script src="<c:url value="/assets/js/admin/Parameter.js"/>"></script>
    </body>
</html>
