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
    <title>Teampress | Mappák</title>
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
                                        <div class="row  animated fadeInUpBig">
                                            <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Mappa létrehozás</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <f:form id="form" cssClass="" name='f' htmlEscape="true" action='/folder' method='POST' modelAttribute="modifyFolder" enctype="multipart/form-data">
                                                            <div class="form-group row">
                                                                <label for="name" class="col-sm-4 col-form-label">Mappa neve</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input type="text" required="true" path="name" cssClass="form-control" id="name"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="name" class="col-sm-4 col-form-label">Leírás</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input type="text" path="desc" cssClass="form-control" id="desc"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label class="col-md-4 col-form-label" for="file-input">Háttérkép feltöltése</label>
                                                                <div class="col-md-8 col-form-label">
                                                                    <f:input id="file-input" type="file" path="bgImg" name="file-input"/>
                                                                </div>
                                                            </div>
                                                            <f:hidden path="id" value=""/>
                                                            <div class="form-group row">
                                                                <div class="col-12">
                                                                    <button class="btn btn-primary btn-soft" onclick="$('#submit').click()"><i class="ti-save"></i> Mentés</button>
                                                                    <input id="submit" style="display: none" name="save" type="submit" value="Mentés"/>
                                                                    <button type="button" id="clear" class="btn btn-secondary btn-soft" onclick="window.location='/folder'"><i class="ti-close"></i> Mégse</button>
                                                                </div>
                                                            </div>
                                                        </f:form>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Mappák</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Név</th>
                                                                <th>Leírás</th>
                                                                <th>Létrehozó</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="d" items="${folders}">
                                                                <tr>
                                                                    <td>${d.name}</td>
                                                                    <td>${d.description}</td>
                                                                    <td>${d.createdBy}</td>
                                                                    <td>
                                                                        <button class="btn btn-primary btn-soft" onclick="show(${d.id}, '${d.description}', '${d.name}')"><i class="ti-pencil-alt"></i> Módosítás</button>
                                                                        <button class="btn btn-danger btn-soft" onclick="del(${d.id})"><i class="ti-trash"></i> Törlés</button>
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
        <%@include file="../../assets/js/play/Folder.js" %>
    </script>
</body>
</html>