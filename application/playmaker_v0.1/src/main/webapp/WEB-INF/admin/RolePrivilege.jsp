<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/JSTL.jsp" %>
<html>
    <head>
        <%@include file="../include/Head.jsp" %>
    </head>
    <body>
        <%@include file="../include/Sidebar.jsp" %>
        <div class="c-wrapper c-fixed-components">
            <%@include file="../include/Header.jsp" %>
            <div class="c-body">
                <main class="c-main">
                    <div class="container-fluid">
                        <div class="ui-view">
                            <div class="fade-in">
                                <c:if test="${sessionHandler.userHasPermission('ADMIN')}">
                                    <div class="row">
                                        <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                            <div class="card">
                                                <div class="card-body">
                                                    <h4 class="card-title">Szerepkör jogosultság hozzáadás</h4>
                                                    <hr>
                                                    <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/priv/rolepriv' method='POST' modelAttribute="model">
                                                        <div class="form-group row bmd-form-group">
                                                            <label for="roleId" class="col-sm-4 col-form-label">Szerepkör</label>
                                                            <div class="col-sm-8 label-static">
                                                                <f:select path="roleId" required="true" id="roleId">
                                                                    <c:forEach items="${roles}" var="type">
                                                                        <option value="${type.id}">
                                                                                ${type.name}
                                                                        </option>
                                                                    </c:forEach>
                                                                </f:select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row bmd-form-group">
                                                            <label for="privId" class="col-sm-4 col-form-label">Jogosultság</label>
                                                            <div class="col-sm-8 label-static">
                                                                <f:select path="privId" required="true" id="privId">
                                                                    <c:forEach items="${privs}" var="type">
                                                                        <option value="${type.id}">
                                                                                ${type.name}
                                                                        </option>
                                                                    </c:forEach>
                                                                </f:select>
                                                            </div>
                                                        </div>
                                                        <f:hidden path="version" id="version"/>
                                                        <f:hidden path="id" id="id"/>
                                                        <div class="form-group row">
                                                            <div class="dt-btn-flex">
                                                                <input id="submit" class="btn btn-success btn-soft" name="save" type="submit" value="Mentés"/>
                                                                <button type="button" id="clear-form-btn" class="btn btn-light btn-soft" onclick="window.location = '/priv/rolepriv'">
                                                                    Mégse
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </f:form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="card col-12">
                                            <div class="card-header">
                                                <h4 class="card-title">Szerepkörök jogosultságai</h4>
                                            </div>
                                            <div class="card-body">
                                                <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                    <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Szerepkör</th>
                                                        <th>Jogosultság</th>
                                                        <th></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="data" items="${datas}">
                                                        <tr>
                                                            <td>${data.id}</td>
                                                            <td>${data.role.name}</td>
                                                            <td>${data.privilege.name}</td>
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
                                </c:if>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <%@include file="../include/Footer.jsp" %>
            <%@include file="../include/Js.jsp" %>
            <script src="<c:url value="/assets/js/admin/RolePrivilege.js"/>"></script>
        </div>
    </body>
</html>
