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
                                                    <h4 class="card-title">Felhasználó létrehozás</h4>
                                                    <hr>
                                                    <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/usr/user' method='POST' modelAttribute="model">
                                                        <div class="form-group row">
                                                            <label for="username" class="col-sm-4 col-form-label">Felhasználónév</label>
                                                            <div class="col-sm-8 label-static">
                                                                <f:input id="username" type="text" required="" path="username" cssErrorClass="form-control" cssClass="form-control"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="name" class="col-sm-4 col-form-label">Név</label>
                                                            <div class="col-sm-8 label-static">
                                                                <f:input id="name" type="text" required="" path="name" cssErrorClass="form-control" cssClass="form-control"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="password" class="col-sm-4 col-form-label">Jelszó</label>
                                                            <div class="col-sm-8 label-static">
                                                                <f:input id="password" type="password" required="" path="password" cssErrorClass="form-control" cssClass="form-control"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="email" class="col-sm-4 col-form-label">Email cím</label>
                                                            <div class="col-sm-8 label-static">
                                                                <f:input id="email" type="email" path="email" cssErrorClass="form-control" cssClass="form-control"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="phone" class="col-sm-4 col-form-label">Telefon szám</label>
                                                            <div class="col-sm-8 label-static">
                                                                <f:input id="phone" type="text" path="phone" cssErrorClass="form-control" cssClass="form-control"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="url" class="col-sm-4 col-form-label">Profil link</label>
                                                            <div class="col-sm-8 label-static">
                                                                <f:input id="url" type="text" required="" path="url" cssErrorClass="form-control" cssClass="form-control"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-md-3 col-form-label">Játékos</label>
                                                            <div class="col-md-9 col-form-label">
                                                                <div class="form-check checkbox">
                                                                    <f:checkbox path="player" class="form-check-input" id="player"  value=""/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-md-3 col-form-label">Engedélyezve</label>
                                                            <div class="col-md-9 col-form-label">
                                                                <div class="form-check checkbox">
                                                                    <f:checkbox path="enabled" class="form-check-input" id="enabled" value=""/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label class="col-md-3 col-form-label">Törölve</label>
                                                            <div class="col-md-9 col-form-label">
                                                                <div class="form-check checkbox">
                                                                    <f:checkbox path="deleted" class="form-check-input" id="deleted" value=""/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <f:hidden path="version" id="version"/>
                                                        <f:hidden path="id" id="id"/>
                                                        <div class="form-group row">
                                                            <div class="dt-btn-flex">
                                                                <input id="submit" class="btn btn-success" name="save" type="submit" value="Mentés"/>
                                                                <button type="button" id="clear-form-btn" class="btn btn-light" onclick="window.location = '/usr/user'">
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
                                                <h4 class="card-title">Felhasználók</h4>
                                            </div>
                                            <div class="card-body">
                                                <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                    <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Felhasználónév</th>
                                                        <th>Név</th>
                                                        <th>Email cím</th>
                                                        <th>Telefon szám</th>
                                                        <th>Profil link</th>
                                                        <th></th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="data" items="${datas}">
                                                        <tr>
                                                            <td>${data.id}</td>
                                                            <td>${data.username}</td>
                                                            <td>${data.name}</td>
                                                            <td>${data.email}</td>
                                                            <td>${data.phoneNumber}</td>
                                                            <td>${data.url}</td>
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
                                </c:if>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <%@include file="../include/Footer.jsp" %>
            <%@include file="../include/Js.jsp" %>
            <script src="<c:url value="/assets/js/admin/User.js"/>"></script>
        </div>
    </body>
</html>
