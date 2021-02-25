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
                                    <div class="row animated fadeInUpBig">
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h5>Liga meccsek</h5>
                                                </div>
                                                <div class="card-block">
                                                    <table id="sorsolasTable" class="table table-striped table-bordered" style="width:100%; font-size: 14px">
                                                        <thead>
                                                        <tr>
                                                            <th data-priority="1">Név</th>
                                                            <th data-priority="2">Művelet</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="data" items="${records}">
                                                            <tr>
                                                                <td>${data.name}</td>
                                                                <td>
                                                                    <f:form id="form_${data.id}" name='f' cssClass="form-wp1" htmlEscape="true" action='/payment/' method='POST' autocomplete="off">
                                                                        <input type='hidden' value='${amount}' name='amount' />
                                                                        <script
                                                                                src='https://checkout.stripe.com/checkout.js'
                                                                                class='stripe-button'
                                                                                data-key='${stripePublicKey}'
                                                                                data-amount='${amount}'
                                                                                data-currency='${currency}'
                                                                                data-name='Teampress'
                                                                                data-description='Spring course checkout'
                                                                                data-image='http://www.baeldung.com/wp-content/themes/baeldung/favicon/android-chrome-192x192.png'
                                                                                data-locale='auto'
                                                                                data-zip-code='false'>
                                                                        </script>
                                                                    </f:form>
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
<script src="../../assets/js/play/GamePlan.js" ></script>
</body>
</html>
