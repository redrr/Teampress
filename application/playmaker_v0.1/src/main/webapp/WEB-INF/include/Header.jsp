<!-- Header file that gets rendered on every page.-->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="c-header c-header-light c-header-fixed">
    <button class="c-header-toggler c-class-toggler d-lg-none mfe-auto" type="button" data-target="#sidebar" data-class="c-sidebar-show">
        <i class="c-icon c-icon-lg cil-menu"></i>
    </button>
    <button class="c-header-toggler c-class-toggler mfs-3 d-md-down-none" type="button" data-target="#sidebar" data-class="c-sidebar-lg-show" responsive="true">
        <i class="c-icon c-icon-lg cil-menu"></i>
    </button>
    <ul class="c-header-nav ml-auto mr-4">
        <c:if test="${not empty sessionHandler.getUsernameFromCurrentSession()}">
            <li class="c-header-nav-item dropdown d-md-down-none mx-2 show">
                <a class="c-header-nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="true">
                    <i class="c-icon c-icon-lg cil-bell"></i>
                    <span id="notiCounter" class="badge badge-pill badge-danger"></span>
                </a>
                <div class="dropdown-menu dropdown-menu-right dropdown-menu-lg pt-0" style="min-width:400px">
                    <div class="dropdown-header bg-light">
                        <strong>Értesítések</strong>
                    </div>
                    <div id="notiList">

                    </div>
                </div>
            </li>
            <li class="c-header-nav-item dropdown">
                <a class="c-header-nav-link" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
                    <div class="c-avatar">
                        <img src="" class="c-avatar-img" alt="user avatar" id="useravatar" style="width: 35px;height: 35px;">
                    </div>
                </a>
                <div class="dropdown-menu dropdown-menu-right pt-0">
                    <div class="dropdown-header bg-light py-2">
                        <strong>Fiók</strong>
                    </div>
                    <a class="dropdown-item" href="/profile">
                        <i class="c-icon mr-2 cil-cog"></i>
                        <span>Profil</span>
                    </a>
                    <a class="dropdown-item" href="<c:url value="/logout"/>" data-toggle="modal" data-target="#logoutModal">
                        <i class="c-icon mr-2 cil-power-standby"></i>
                        <span>Kijelentkezés</span>
                    </a>
                </div>
            </li>
        </c:if>
    </ul>
</header>
<%@include file="TrainerRating.jsp" %>
<%@include file="Logout.jsp" %>
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