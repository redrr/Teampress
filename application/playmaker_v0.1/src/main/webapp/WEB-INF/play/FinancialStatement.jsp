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
    <title>Teampress | Kimutatások</title>
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
                                    <div class="row">
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <div class="row">
                                                        <div class="col-10">
                                                            <h5>Bevétel-kiadás havi kimutatás</h5>
                                                            <span></span>
                                                        </div>
                                                        <div class="col-2">
                                                            <button class="btn btn-primary btn-soft float-right" data-toggle="modal" data-target="#queryModal"><i class="ti-download"></i> Export</button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <a class="btn btn-primary btn-icon" href="/financial/statement/${prevMonth}">
                                                                <i class="ti-angle-left"></i>
                                                            </a>
                                                            <a class="btn btn-primary btn-icon" href="/financial/statement/${nextMonth}">
                                                                <i class="ti-angle-right"></i>
                                                            </a>
                                                        </div>
                                                        <div class="col-12 text-center">
                                                            <h3>${year} - ${month}</h3>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="row">
                                                                <div class="col-12 text-center">
                                                                    <b style="font-size: 20px">Bevétel</b>
                                                                </div>
                                                            </div>
                                                            <hr style="margin-top: 8px; margin-bottom: 8px">
                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <b>Csoport</b>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Megnevezés</b>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Érték</b>
                                                                </div>
                                                            </div>
                                                            <hr style="margin-top: 8px">
                                                            <c:forEach var="data" items="${monthIncome}">
                                                                <c:if test="${data.income.income}">
                                                                    <div class="row" style="margin-bottom: 16px;padding: 0 16px;">
                                                                        <div class="col-4">${data.group.name}</div>
                                                                        <div class="col-4">${data.income.name}</div>
                                                                        <div class="col-4 in-amount">${data.income.prize}</div>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="row">
                                                                <div class="col-12 text-center">
                                                                    <b style="font-size: 20px">Kiadás</b>
                                                                </div>
                                                            </div>
                                                            <hr style="margin-top: 8px; margin-bottom: 8px">
                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <b>Csoport</b>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Megnevezés</b>
                                                                </div>
                                                                <div class="col-4">
                                                                    <b>Érték</b>
                                                                </div>
                                                            </div>
                                                            <hr style="margin-top: 8px">
                                                            <c:forEach var="data" items="${monthIncome}">
                                                                <c:if test="${!data.income.income}">
                                                                    <div class="row" style="margin-bottom: 16px;padding: 0 16px;">
                                                                        <div class="col-4">${data.group.name}</div>
                                                                        <div class="col-4">${data.income.name}</div>
                                                                        <div class="col-4 ex-amount">${data.income.prize}</div>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                        <div class="col-6">
                                                            <hr>
                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <b>Összesen:</b>
                                                                </div>
                                                                <div class="col-4"></div>
                                                                <div class="col-4">
                                                                    <b id="sum-in-amount"></b>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <hr>
                                                            <div class="row">
                                                                <div class="col-4">
                                                                    <b>Összesen:</b>
                                                                </div>
                                                                <div class="col-4"></div>
                                                                <div class="col-4">
                                                                    <b id="sum-ex-amount"></b>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Bevétel-kiadás éves statiszika</h5>
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <canvas id="plus" width="800" height="200"></canvas>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- export-->
                                    <div class="modal fade" id="queryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-success modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title">Bevétel-kiadás excel export</h4>
                                                    <button id="close" class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-2">
                                                            <b>Időponttól</b>
                                                        </div>
                                                        <div class="col-10">
                                                            <input id="date1" class="form-control"/>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-2">
                                                        <div class="col-2">
                                                            <b>Időpontig</b>
                                                        </div>
                                                        <div class="col-10">
                                                            <input id="date2" class="form-control"/>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="modal-footer">
                                                    <button class="btn btn-primary btn-soft" type="button" onclick="exportData()"><i class="ti-download"></i> Letöltés</button>
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
<script src="../../assets/js/play/FinancialStatement.js"></script>
</body>
</html>
