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
                                    <div class="row animated fadeInUpBig">
                                        <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Bevétel-kiadás csoportosítás</h5>
                                                </div>
                                                <div class="card-block">
                                                    <form id="form" name='f' class="form-wp1">
                                                        <div class="form-group row" style="display: none">
                                                            <div class="col-sm-8 label-static">
                                                                <input type="text" class="form-control" id="id"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row bmd-form-group">
                                                            <label for="group" class="col-sm-4 col-form-label">Csoport</label>
                                                            <div class="col-sm-8 label-static">
                                                                <select required="" id="group">
                                                                    <c:forEach var="data" items="${groups}">
                                                                        <option value="${data.id}">${data.name}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row bmd-form-group">
                                                            <label for="type" class="col-sm-4 col-form-label">Kiadás-bevétel</label>
                                                            <div class="col-sm-8 label-static">
                                                                <select required="" id="type">
                                                                    <c:forEach var="data" items="${incomes}">
                                                                        <option value="${data.id}">${data.name}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-12">
                                                                <button type="button" class="btn btn-primary btn-soft" onclick="createGroup()"><i class="ti-save"></i> Mentés</button>
                                                                <button type="button" class="btn btn-light btn-soft" onclick=""><i class="ti-close"></i> Mégse</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Csoportosított bevételek-kiadások</h5>
                                                </div>
                                                <div class="card-block">
                                                    <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                        <thead>
                                                        <tr>
                                                            <th>Csoport</th>
                                                            <th>Bevétel-kiadás</th>
                                                            <th>Műveletek</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="data" items="${table}">
                                                            <tr>
                                                                <td>${data.group.name}</td>
                                                                <td>${data.income.name}</td>
                                                                <td>
                                                                    <button type="button" class="btn btn-primary btn-soft" onclick="modifyGroup(${data.id}, ${data.group.id}, ${data.income.id})"><i class="ti-pencil-alt"></i> Módosítás</button>
                                                                    <button type="button" class="btn btn-danger btn-soft" onclick="deleteEntry(${data.id}, '/financial/grouping')"><i class="ti-trash"></i> Törlés</button>
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
<script src="../../assets/js/play/FinancialGrouping.js"></script>
</body>
</html>
