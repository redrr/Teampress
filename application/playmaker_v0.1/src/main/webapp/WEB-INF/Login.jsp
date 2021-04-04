<%--
  Created by IntelliJ IDEA.
  User: Matyi
  Date: 2020. 07. 23.
  Time: 18:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/JSTL.jsp" %>
<html>
<head>
    <title>Teampress | Bejelentkezés</title>
    <%@include file="include/Css.jsp" %>
</head>
<body class="fix-menu">
    <section class="login p-fixed d-flex text-center bg-primary common-img-bg">
        <!-- Container-fluid starts -->
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <!-- Authentication card start -->
                    <div class="login-card card-block auth-body animated fadeInDownBig">
                        <f:form cssClass="md-float-material" name='f' htmlEscape="true" action='/login' method='POST' modelAttribute="login">
                            <div class="auth-box">
                                <div class="row m-b-20">
                                    <div class="col-md-12">
                                        <h3 class="text-left txt-primary">Bejelentkezés</h3>
                                    </div>
                                </div>
                                <div class="input-group">
                                    <f:input id="username" type='text' path='mail' cssClass="form-control" placeholder="E-mail cím"/>
                                    <span class="md-line"></span>
                                </div>
                                <div class="input-group">
                                    <f:input id="password" type='password' path='password' cssClass="form-control" placeholder="Jelszó"/>
                                    <span class="md-line"></span>
                                </div>
                                <div class="row m-t-30">
                                    <div class="col-12">
                                        <a class="btn link-primary" data-toggle="modal" data-target="#add-exercise-modal">Új jelszó kérése</a>
                                    </div>
                                    <div class="col-md-12">
                                        <button id="submit" type="submit" class="btn btn-primary btn-md btn-block waves-effect text-center m-b-20 btn-soft">Bejelentkezés</button>
                                    </div>
                                </div>
                            </div>
                        </f:form>
                        <!-- end of form -->
                    </div>
                    <!-- Authentication card end -->
                </div>
                <!-- end of col-sm-12 -->
            </div>
            <!-- end of row -->
        </div>
        <!-- end of container-fluid -->
    </section>
    <div class="modal fade" id="add-exercise-modal" tabindex="-1">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Új jelszó</h4>
                    <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                </div>
                <div class="modal-body">
                    <div class="form-group row">
                        <label for="fusername" class="col-3 col-lg-2 col-form-label">Email cím</label>
                        <div class="col-9 col-lg-10">
                            <div class="input-group bmd-form-group">
                                <input type="text" class="form-control" id="fusername"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary btn-soft" onclick="window.location='/forgetpassword/'+$('#fusername').val()">Küldés</button>
                    <button type="button" id="close" class="btn btn-default btn-soft" data-dismiss="modal">Mégse</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Warning Section Starts -->
    <!-- Older IE warning message -->
    <!--[if lt IE 9]>
    <div class="ie-warning">
        <h1>Warning!!</h1>
        <p>You are using an outdated version of Internet Explorer, please upgrade <br/>to any of the following web browsers to access this website.</p>
        <div class="iew-container">
            <ul class="iew-download">
                <li>
                    <a href="http://www.google.com/chrome/">
                        <img src="../assets/vendor/assets/images/browser/chrome.png" alt="Chrome">
                        <div>Chrome</div>
                    </a>
                </li>
                <li>
                    <a href="https://www.mozilla.org/en-US/firefox/new/">
                        <img src="../assets/vendor/assets/images/browser/firefox.png" alt="Firefox">
                        <div>Firefox</div>
                    </a>
                </li>
                <li>
                    <a href="http://www.opera.com">
                        <img src="../assets/vendor/assets/images/browser/opera.png" alt="Opera">
                        <div>Opera</div>
                    </a>
                </li>
                <li>
                    <a href="https://www.apple.com/safari/">
                        <img src="../assets/vendor/assets/images/browser/safari.png" alt="Safari">
                        <div>Safari</div>
                    </a>
                </li>
                <li>
                    <a href="http://windows.microsoft.com/en-us/internet-explorer/download-ie">
                        <img src="../assets/vendor/assets/images/browser/ie.png" alt="">
                        <div>IE (9 & above)</div>
                    </a>
                </li>
            </ul>
        </div>
        <p>Sorry for the inconvenience!</p>
    </div>
    <![endif]-->
    <!-- Warning Section Ends -->
    <!-- Required Jquery -->
    <script type="text/javascript" src="../assets/vendor/bower_components/jquery/js/jquery.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/jquery-ui/js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/popper.js/js/popper.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/bootstrap/js/bootstrap.min.js"></script>
    <!-- jquery slimscroll js -->
    <script type="text/javascript" src="../assets/vendor/bower_components/jquery-slimscroll/js/jquery.slimscroll.js"></script>
    <!-- modernizr js -->
    <script type="text/javascript" src="../assets/vendor/bower_components/modernizr/js/modernizr.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/modernizr/js/css-scrollbars.js"></script>
    <!-- i18next.min.js -->
    <script type="text/javascript" src="../assets/vendor/bower_components/i18next/js/i18next.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/i18next-xhr-backend/js/i18nextXHRBackend.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/i18next-browser-languagedetector/js/i18nextBrowserLanguageDetector.min.js"></script>
    <script type="text/javascript" src="../assets/vendor/bower_components/jquery-i18next/js/jquery-i18next.min.js"></script>
    <!-- Custom js -->
    <!--<script type="text/javascript" src="assets/js/script.js"></script>-->
    <!---- color js --->
    <script type="text/javascript" src="../assets/vendor/assets/js/common-pages.js"></script>
</body>
</html>
