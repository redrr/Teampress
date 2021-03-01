<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/JSTL.jsp" %>
<html>
<head>
    <title>Teampress | Fizetés</title>
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
                                    <!-- Payments for users -->
                                    <c:if test="${!info.equals('')}">
                                        <div class="errors">
                                            <div class="row">
                                                <div class="col-12">
                                                    <c:if test="${info.equals('success')}">
                                                        <div class="alert alert-success">Sikeres fizetés!</div>
                                                    </c:if>
                                                    <c:if test="${info.equals('cancel')}">
                                                        <div class="alert alert-danger">Sikertelen fizetés!</div>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <div class="row animated fadeInUpBig">
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Számlák</h5>
                                                </div>
                                                <div class="card-block">
                                                    <table id="paymentTable" class="table table-striped table-bordered" style="width:100%; font-size: 14px">
                                                        <thead>
                                                        <tr>
                                                            <th data-priority="1">Név</th>
                                                            <th>Érték</th>
                                                            <th data-priority="2">Művelet</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="data" items="${records}">
                                                            <tr>
                                                                <td>${data.name}</td>
                                                                <td>${data.amount} Ft</td>
                                                                <td>
                                                                    <c:if test="${data.completed}">
                                                                        <span class="badge badge-success badge-lg">Fizetve</span>
                                                                    </c:if>
                                                                    <c:if test="${!data.completed}">
                                                                        <button type="button" class="btn btn-soft btn-primary btn-sm" onclick="makePayment(${data.id})">Fizetés</button>
                                                                    </c:if>
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
<script src="https://js.stripe.com/v3/"></script>
<script>
    const stripeKey = '${stripePublicKey}';
</script>
<script src="../../assets/js/play/Payments.js" ></script>
</body>
</html>
