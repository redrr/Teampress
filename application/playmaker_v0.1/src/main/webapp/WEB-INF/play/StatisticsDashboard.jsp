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
    <title>Teampress | Statisztika</title>
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
                                    <c:if test="${sessionHandler.userHasPermission('PLAYERS_STAT')}">
                                        <div class="row">
                                            <div class="col-4">
                                                <div class="card">
                                                    <div class="card-header py-2">
                                                        <h3>Szerzett pontok</h3>
                                                    </div>
                                                    <div class="card-body">
                                                        <canvas id="1"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <div class="card">
                                                    <div class="card-header py-2">
                                                        <h3>Gólok aránya</h3>
                                                    </div>
                                                    <div class="card-body">
                                                        <canvas id="2"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <div class="card">
                                                    <div class="card-header py-2">
                                                        <h3>Mérkőzések megoszlása</h3>
                                                    </div>
                                                    <div class="card-body">
                                                        <canvas id="3"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="card">
                                                    <div class="card-header py-2">
                                                        <h3>Forma mutató</h3>
                                                    </div>
                                                    <div class="card-body">
                                                        <canvas id="4"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="card">
                                                    <div class="card-header py-2">
                                                        <h3>Bajnoki tabella</h3>
                                                    </div>
                                                    <div class="card-body">
                                                        <canvas id="5"></canvas>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
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
<script src="../../assets/js/play/Dashboard.js"></script>
</body>
</html>
