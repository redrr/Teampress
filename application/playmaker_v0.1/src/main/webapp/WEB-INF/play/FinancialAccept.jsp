<%--
  Created by IntelliJ IDEA.
  User: Matyi
  Date: 2020. 07. 24.
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/JSTL.jsp" %>
<html>
<head>
    <title>Teampress | Gyakorlatok</title>
    <%@include file="../include/Css.jsp" %>
</head>
<body>
<!-- Pre-loader start -->
<div class="theme-loader">
    <div class="ball-scale">
        <div></div>
    </div>
</div>
<!-- Pre-loader end -->
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
                                    <div class="row">
                                        <div id="alert" class="col-12"></div>
                                    </div>
                                    <div class="row animated fadeInUpBig">
                                        <div class="col-xl-6 col-lg-12 col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Bevétel-kiadás kérések</h5>
                                                </div>
                                                <div class="card-block">
                                                    <table id="requestTable" class="table table-striped table-bordered" style="width:100%">
                                                        <thead>
                                                        <tr>
                                                            <th>Név</th>
                                                            <th>Típus</th>
                                                            <th>Összeg</th>
                                                            <th>Elfogad</th>
                                                            <th>Elutasít</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="data" items="${table1}">
                                                            <tr>
                                                                <td>${data.name}</td>
                                                                <td>
                                                                    <c:if test="${data.income}">Bevétel</c:if>
                                                                    <c:if test="${!data.income}">Kiadás</c:if>
                                                                </td>
                                                                <td>${data.prize} Ft</td>
                                                                <td>
                                                                    <button type="button" class="btn btn-primary btn-soft" onclick="confirm(${data.id})"><i class="ti-check"></i></button>
                                                                </td>
                                                                <td>
                                                                    <button type="button" class="btn btn-danger btn-soft" onclick="ignore(${data.id})"><i class="ti-na"></i></button>
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
                                        <div class="col-xl-6 col-lg-12 col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Elfogadott bevételek-kiadások</h5>
                                                </div>
                                                <div class="card-block">
                                                    <table id="stateTable" class="table table-striped table-bordered" style="width:100%">
                                                        <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Megnevezés</th>
                                                            <th>Típus</th>
                                                            <th>Összeg</th>
                                                            <th>Műveletek</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="data" items="${table2}">
                                                            <tr>
                                                                <td>${data.id}</td>
                                                                <td>${data.name}</td>
                                                                <td>
                                                                    <c:if test="${data.income}">Bevétel</c:if>
                                                                    <c:if test="${!data.income}">Kiadás</c:if>
                                                                </td>
                                                                <td>${data.prize} Ft</td>
                                                                <td>
                                                                    <button type="button" class="btn btn-danger btn-soft" onclick="fullIgnore(${data.id})"><i class="ti-trash"></i> Törlés</button>
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
<script>
    <%@include file="../../assets/js/play/FinancialAccept.js" %>
</script>
</body>
</html>