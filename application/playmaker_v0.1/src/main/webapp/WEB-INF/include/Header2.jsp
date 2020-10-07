<!-- Header file that gets rendered on every page.-->
<nav class="navbar header-navbar pcoded-header" header-theme="theme4" style="position: fixed;top: 0;z-index: 800">
    <div class="navbar-wrapper">
        <div class="navbar-logo">
            <a class="mobile-menu" id="mobile-collapse" href="#!">
                <i class="ti-menu"></i>
            </a>
            <a class="mobile-search morphsearch-search" href="#">
                <i class="ti-search"></i>
            </a>
            <a href="/" style="height: 100%">
                <img style="height: 100%" class="img-fluid" src="../../assets/vendor/assets/images/logo.png" alt="Theme-Logo" />
            </a>
            <a class="mobile-options">
                <i class="ti-more"></i>
            </a>
        </div>
        <div class="navbar-container container-fluid">
            <div>
                <ul class="nav-left">
                    <li>
                        <div class="sidebar_toggle"><a href="javascript:void(0)"><i class="ti-menu"></i></a></div>
                    </li>
                </ul>
                <ul class="nav-right">
                    <li class="header-notification">
                        <a href="">
                            <i class="ti-bell"></i>
                            <b id="notiCounter" class="badge"></b>
                        </a>
                        <ul id="notiList" class="show-notification"></ul>
                    </li>
                    <li class="user-profile header-notification cr-pointer">
                        <a>
                            <img id="useravatar" class="img-circle" src="../assets/vendor/assets/images/user.png" alt="User-Profile-Image">
                            <span id="profile-name">User</span>
                            <i class="ti-angle-down"></i>
                        </a>
                        <ul class="show-notification profile-notification">
                            <li>
                                <a href="/profile">
                                    <i class="ti-user"></i> Profile
                                </a>
                            </li>
                            <li>
                                <a href="/logout">
                                    <i class="ti-layout-sidebar-left"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>
<%@include file="TrainerRating.jsp" %>
<noscript>
    <div id="wrapper">
        <div class="container">
            <div style="margin-top: 5rem; z-index: 99999">
                <div class="card-body">
                    <div class="alert alert-danger">
                        A javascript nincs engedélyezve a böngésződben!
                    </div>
                </div>
            </div>
        </div>
    </div>
</noscript>