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
                                                <h4 class="card-title">Tabella</h4>
                                            </div>
                                            <div class="card-body">
                                                <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                    <thead>
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Liga</th>
                                                        <th>Forduló</th>
                                                        <th>Helyezés</th>
                                                        <th>Csapat</th>
                                                        <th>Győzelemek száma</th>
                                                        <th>Döntetlenek száma</th>
                                                        <th>Vereségek száma</th>
                                                        <th>Lőtt gólok száma</th>
                                                        <th>Kapott gólok száma</th>
                                                        <th>Gólkülönbség</th>
                                                        <th>Pontszám</th>
                                                        <th>Ellenfelek helyezésének átlaga</th>
                                                        <th>Forma</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="data" items="${datas}">
                                                        <tr>
                                                            <td>${data.id}</td>
                                                            <td>${data.liga.liga}</td>
                                                            <td>${data.fordulo}</td>
                                                            <td>${data.helyezes}</td>
                                                            <td>${data.csapat}</td>
                                                            <td>${data.gyozelemekSzama}</td>
                                                            <td>${data.dontetlenekSzama}</td>
                                                            <td>${data.veresegekSzama}</td>
                                                            <td>${data.lottGolokSzama}</td>
                                                            <td>${data.kapottGolokSzama}</td>
                                                            <td>${data.golkulonbseg}</td>
                                                            <td>${data.pontszam}</td>
                                                            <td>${data.ellenfelekHelyezesenekAtlaga}</td>
                                                            <td>${data.forma1} ${data.forma2} ${data.forma3} ${data.forma4} ${data.forma5}</td>
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
            <script src="<c:url value="/assets/js/admin/Tabella.js"/>"></script>
        </div>
    </body>
</html>
