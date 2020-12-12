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
                                    <div class="row  animated fadeInUpBig">
                                        <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Bevétel-kiadás felvétel</h5>
                                                </div>
                                                <div class="card-block">
                                                    <form class="form-wp1" id="form" name='f'>
                                                        <div class="form-group row" style="display: none">
                                                            <div class="col-sm-8 label-static">
                                                                <input type="text" required="" class="form-control" id="id"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="name" class="col-sm-4 col-form-label">Megnevezés</label>
                                                            <div class="col-sm-8 label-static">
                                                                <input type="text" required="" class="form-control" id="name"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row bmd-form-group">
                                                            <label for="type" class="col-sm-4 col-form-label">Típus</label>
                                                            <div class="col-sm-8 label-static">
                                                                <select required="" id="type">
                                                                    <option value="0">Kiadás</option>
                                                                    <option value="1">Bevétel</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="cost" class="col-sm-4 col-form-label">Érték</label>
                                                            <div class="col-sm-8 label-static">
                                                                <input type="number" min="0" required="" class="form-control" id="cost"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row bmd-form-group">
                                                            <div class="col-12">
                                                                <button type="button" class="btn btn-primary btn-soft" onclick="createIncome();"><i class="ti-save"></i> Mentés</button>
                                                                <button type="button" id="clear-form-" class="btn btn-light btn-soft" onclick=""><i class="ti-close"></i> Mégse</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Bevételek-kiadások</h5>
                                                </div>
                                                <div class="card-block">
                                                    <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                        <thead>
                                                        <tr>
                                                            <th>Megnevezés</th>
                                                            <th>Típus</th>
                                                            <th>Összeg</th>
                                                            <th>Műveletek</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="data" items="${table}">
                                                            <tr>
                                                                <td>${data.name}</td>
                                                                <td>
                                                                    <c:if test="${data.income}">Bevétel</c:if>
                                                                    <c:if test="${!data.income}">Kiadás</c:if>
                                                                </td>
                                                                <td>${data.prize} Ft</td>
                                                                <td>
                                                                    <button type="button" class="btn btn-primary btn-soft" onclick="modifyIncome(${data.id}, '${data.name}', '${data.income}', ${data.prize})"><i class="ti-pencil-alt"></i> Módosítás</button>
                                                                    <button type="button" class="btn btn-danger btn-soft" onclick="deleteIncome(${data.id})"><i class="ti-trash"></i> Törlés</button>
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
    <%@include file="../../assets/js/play/FinancialCreate.js" %>
</script>
</body>
</html>