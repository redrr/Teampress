<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/JSTL.jsp" %>
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
        <%@include file="include/Header.jsp" %>
        <div class="pcoded-main-container">
            <div class="pcoded-wrapper">
                <%@include file="include/Sidebar.jsp" %>
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
