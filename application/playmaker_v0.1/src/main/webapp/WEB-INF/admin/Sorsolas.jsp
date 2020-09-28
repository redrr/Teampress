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
                                                <h4 class="card-title">Sorsolás</h4>
                                            </div>
                                            <div class="card-body">
                                                <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                    <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Liga</th>
                                                        <th>Hazai</th>
                                                        <th>Hazai URL</th>
                                                        <th>Eredmény</th>
                                                        <th>Vendég</th>
                                                        <th>Vendég URL</th>
                                                        <th>Dátum</th>
                                                        <th>Helyszín</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="data" items="${datas}">
                                                        <tr>
                                                            <td>${data.id}</td>
                                                            <td>${data.liga.liga}</td>
                                                            <td>${data.hazai}</td>
                                                            <td>${data.hazaiURL}</td>
                                                            <td>${data.eredmeny}</td>
                                                            <td>${data.vendeg}</td>
                                                            <td>${data.vendegURL}</td>
                                                            <td>${data.getDateAs(false)}</td>
                                                            <td>${data.hely}</td>
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
            <script src="<c:url value="/assets/js/admin/Sorsolas.js"/>"></script>
        </div>
    </body>
</html>
