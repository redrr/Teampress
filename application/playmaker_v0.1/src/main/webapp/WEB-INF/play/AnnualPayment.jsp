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
    <title>Teampress | Megújuló online befizetések</title>
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
                                        <div class="row animated fadeInUpBig">
                                            <div class="col-xl-6 col-lg-8 col-md-12 col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Befizetés létrehozás</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/financial/annual' method='POST' modelAttribute="modifyAnnual">
                                                            <div class="form-group row">
                                                                <label for="name" class="col-sm-4 col-form-label">Tétel neve</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input type="text" required="" autocomplete="off" path="name" cssErrorClass="form-control" cssClass="form-control" id="name"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row bmd-form-group">
                                                                <label for="type" class="col-sm-4 col-form-label">Csapat</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:select path="typeId" required="true" id="type" cssClass="selectpicker show-tick" data-size="5" data-live-search="true">
                                                                        <c:forEach items="${types}" var="type">
                                                                            <option value="${type.getId()}">
                                                                                    ${type.getCode()}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row bmd-form-group">
                                                                <label for="type" class="col-sm-4 col-form-label">Csoport</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:select path="groupId" required="true" id="group" cssClass="selectpicker show-tick" data-size="5" data-live-search="true">
                                                                        <c:forEach items="${group}" var="type">
                                                                            <option value="${type.getId()}">
                                                                                    ${type.getName()}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="name" class="col-sm-4 col-form-label">Tétel értéke (Ft)</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input type="number" min="0" required="" autocomplete="off" path="amount" cssErrorClass="form-control" cssClass="form-control" id="amount"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label for="name" class="col-sm-4 col-form-label">Megújulás napja</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:input type="number" min="1" max="20" required="" autocomplete="off" path="day" cssErrorClass="form-control" cssClass="form-control" id="day"/>
                                                                </div>
                                                            </div>
                                                            <f:hidden path="version" id="version"/>
                                                            <f:hidden path="id" id="id"/>
                                                            <div class="form-group row bmd-form-group">
                                                                <div class="col-12">
                                                                    <button class="btn btn-primary btn-soft" type="submit"><i class="ti-save"></i> Mentés</button>
                                                                    <button type="button" id="clear" class="btn btn-secondary btn-soft" onclick="window.location='/financial/annual'"><i class="ti-close"></i> Mégse</button>
                                                                </div>
                                                            </div>
                                                        </f:form>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Befizetések</h5>
                                                    </div>
                                                    <div class="card-block">
                                                        <table id="paymentTable" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Név</th>
                                                                <th>Csapat</th>
                                                                <th>Csoport</th>
                                                                <th>Érték</th>
                                                                <th>Nap</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="data" items="${datas}">
                                                                <tr>
                                                                    <td>${data.name}</td>
                                                                    <td>${data.team.code}</td>
                                                                    <td>${data.group.name}</td>
                                                                    <td>${data.amount}</td>
                                                                    <td>${data.day}</td>
                                                                    <td>
                                                                        <button type="button" class="btn btn-primary btn-soft" onclick="showLanguage(${data.id}, ${data.team.id}, '${data.name}', ${data.amount}, ${data.day}, ${data.group.id})"><i class="ti-pencil-alt"></i> Módosítás</button>
                                                                        <button type="button" class="btn btn-danger btn-soft" onclick="delLanguage(${data.id})"><i class="ti-trash"></i> Törlés</button>
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
    <script src="../../assets/js/play/AnnualPayment.js"></script>
</body>
</html>
