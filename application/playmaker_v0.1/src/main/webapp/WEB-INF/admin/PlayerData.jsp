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
                                                <h4 class="card-title">Játékos adatok</h4>
                                            </div>
                                            <div class="card-body">
                                                <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                    <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Felhasználó</th>
                                                        <th>Született</th>
                                                        <th>Kor</th>
                                                        <th>Meccsek száma</th>
                                                        <th>Gólok száma</th>
                                                        <th>Öngólok száma</th>
                                                        <th>Sárgalapok száma</th>
                                                        <th>Piroslapok száma</th>
                                                        <th>Kezdő</th>
                                                        <th>Csere</th>
                                                        <th>Kispad</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="data" items="${datas}">
                                                        <tr>
                                                            <td>${data.id}</td>
                                                            <td>${data.user.username}</td>
                                                            <td>${data.szulDate}</td>
                                                            <td>${data.kor}</td>
                                                            <td>${data.meccsek}</td>
                                                            <td>${data.golok}</td>
                                                            <td>${data.onGolok}</td>
                                                            <td>${data.sargaLap}</td>
                                                            <td>${data.pirosLap}</td>
                                                            <td>${data.kezdo}</td>
                                                            <td>${data.csere}</td>
                                                            <td>${data.kispad}</td>
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
            <script src="<c:url value="/assets/js/admin/PlayerData.js"/>"></script>
        </div>
    </body>
</html>
