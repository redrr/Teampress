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
                                        <div class="card col-12">
                                            <div class="card-header">
                                                <h4 class="card-title">Értesítések</h4>
                                            </div>
                                            <div class="card-body">
                                                <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                    <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Felhasználó</th>
                                                        <th>Átirányítás</th>
                                                        <th>Cím</th>
                                                        <th>Leírás</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="data" items="${datas}">
                                                        <tr>
                                                            <td>${data.id}</td>
                                                            <td>${data.user.username}</td>
                                                            <td>${data.location}</td>
                                                            <td>${data.title}</td>
                                                            <td>${data.description}</td>
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
            <script src="<c:url value="/assets/js/admin/Notification.js"/>"></script>
        </div>
    </body>
</html>
