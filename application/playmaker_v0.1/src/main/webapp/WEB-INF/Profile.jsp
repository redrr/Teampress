<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/JSTL.jsp" %>
<c:if test="${!sessionHandler.userHasPermission('ADMIN')}">
    <html>
    <head>
        <title>Teampress | Profil</title>
        <%@include file="include/Css.jsp" %>
    </head>
    <body>
    <%@include file="include/Loader.jsp" %>
    <div id="pcoded" class="pcoded">
        <div class="pcoded-overlay-box"></div>
        <div class="pcoded-container navbar-wrapper">
            <%@include file="include/Header2.jsp" %>
            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <%@include file="include/Sidebar2.jsp" %>
                    <div class="pcoded-content" style="overflow-y: scroll; top:4em">
                        <div class="pcoded-inner-content">
                            <div class="main-body">
                                <div class="page-wrapper">
                                    <div class="page-body">
                                        <div class="row">
                                            <div class="col-12 col-lg-6 mx-auto">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Profil</h5>
                                                        <span>Felhasználói adatok szerkesztése</span>
                                                    </div>
                                                    <div class="card-block">
                                                        <%@include file="ProfileForm.jsp" %>
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
    <%@include file="include/IE.jsp" %>
    <%@include file="include/JavaScript.jsp" %>
    </body>
    </html>
</c:if>
<c:if test="${sessionHandler.userHasPermission('ADMIN')}">
    <html>
    <head>
        <%@include file="include/Head.jsp" %>
    </head>
    <body class="c-app" id="page-top">
    <%@include file="include/Sidebar.jsp" %>
    <div class="c-wrapper c-fixed-components">
        <%@include file="include/Header.jsp" %>
        <div class="c-body">
            <main class="c-main">
                <div class="container-fluid">
                    <div class="ui-view">
                        <div class="fade-in">
                            <c:if test="${sessionHandler.userHasPermission('LOGGED_IN')}">
                                <div class="row animated fadeInUpBig">
                                    <div class="col-12 col-lg-6 mx-auto">
                                        <div class="card">
                                            <div class="card-header">
                                                <h3>Profil</h3>
                                            </div>
                                            <div class="card-body">
                                                <%@include file="ProfileForm.jsp" %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <%@include file="include/Footer.jsp" %>
        <%@include file="include/Logout.jsp" %>
        <%@include file="include/Js.jsp" %>
    </div>
    </body>
    </html>
</c:if>
