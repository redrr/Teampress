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
                                        <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Csoport felvétele</h5>
                                                </div>
                                                <div class="card-block">
                                                    <form id="form" name='f' class="form-wp1">
                                                        <div class="form-group row" style="display: none">
                                                            <div class="col-sm-8 label-static">
                                                                <input type="text" class="form-control" id="id"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="name" class="col-sm-4 col-form-label">Név</label>
                                                            <div class="col-sm-8 label-static">
                                                                <input type="text" required="" class="form-control" id="name"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <label for="description" class="col-sm-4 col-form-label">Leírás</label>
                                                            <div class="col-sm-8 label-static">
                                                                <input type="text" class="form-control" id="description"/>
                                                            </div>
                                                        </div>
                                                        <div class="form-group row">
                                                            <div class="col-12">
                                                                <button type="button" class="btn btn-primary btn-soft" onclick="createGroup();"><i class="ti-save"></i> Mentés</button>
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
                                                    <h5>Csoportok</h5>
                                                </div>
                                                <div class="card-block">
                                                    <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                        <thead>
                                                        <tr>
                                                            <th>Név</th>
                                                            <th>Leírás</th>
                                                            <th>Műveletek</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="data" items="${table}">
                                                            <tr>
                                                                <td>${data.name}</td>
                                                                <td>${data.description}</td>
                                                                <td>
                                                                    <button type="button" class="btn btn-primary btn-soft" onclick="modifyGroup(${data.id}, '${data.name}', '${data.description}')"><i class="ti-pencil-alt"></i> Módosítás</button>
                                                                    <button type="button" class="btn btn-danger btn-soft" onclick="deleteGroup(${data.id})"><i class="ti-trash"></i> Törlés</button>
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
    <%@include file="../../assets/js/play/FinancialGroup.js" %>
</script>
</body>
</html>