<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="pcoded-navbar" style="position: fixed;top:4em;z-index: 800;box-shadow: 0 12px 12px rgba(0, 0, 0, 0.5)!important;">
    <div class="sidebar_toggle">
        <a href="#"><i class="icon-close icons"></i></a>
    </div>
    <div class="pcoded-inner-navbar main-menu">
        <div class="pcoded-navigatio-lavel" data-i18n="nav.category.app" menu-title-theme="theme5">Menü</div>
        <c:set var="requestURI" value="${requestScope['javax.servlet.forward.request_uri']}"/>
        <ul class="pcoded-item pcoded-left-item">
            <c:if test="${sessionHandler.userHasPermission('LOGGED_IN')}">
                <li class="${requestURI.equals('/home') ? 'active' : ''}">
                    <a href="/home">
                        <span class="pcoded-micon"><i class="ti-home"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.crm-contact.main">Kezdőlap</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${sessionHandler.userHasPermission('TRAIN_TABLE') || sessionHandler.userHasPermission('EXERCISE_TABLE')}">
                <li class="pcoded-hasmenu ${(requestURI.contains('/training')) ? 'active' : ''}">
                    <a href="javascript:void(0)">
                        <span class="pcoded-micon"><i class="ti-pencil-alt"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.social.main">Edzés</span>
                    </a>
                    <ul class="pcoded-submenu">
                        <c:if test="${sessionHandler.userHasPermission('EXERCISE_TABLE')}">
                        <li class="${requestURI.equals('/training/exercise') ? 'active' : ''}">
                            <a href="/training/exercise">
                                <span class="pcoded-micon"><i class="ti-timer"></i></span>
                                <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Gyakorlatok</span>
                            </a>
                        </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('TRAIN_TABLE')}">
                            <li class="${requestURI.equals('/training/plan') ? 'active' : ''}">
                                <a href="/training/plan">
                                    <span class="pcoded-micon"><i class="ti-pencil"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Edzéstervező</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('WORKOUT_CREATE')}">
                            <li class="${requestURI.equals('/training/workout') ? 'active' : ''}">
                                <a href="/training/workout">
                                    <span class="pcoded-micon"><i class="ti-check-box"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Edzésmunka</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </li>
            </c:if>
            <c:if test="${!sessionHandler.userHasPermission('WORKOUT_CREATE') && (sessionHandler.userHasPermission('WORKOUT_ALL_TABLE') || sessionHandler.userHasPermission('WORKOUT_PLAYER_TABLE'))}">
                <li class="${requestURI.equals('/training/workout') ? 'active' : ''}">
                    <a href="/training/workout">
                        <span class="pcoded-micon"><i class="ti-check-box"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.crm-contact.main">Edzésmunka</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${sessionHandler.userHasPermission('PLANS_TABLE')}">
                <li class="${requestURI.equals('/gameplan') ? 'active' : ''}">
                    <a href="/gameplan">
                        <span class="pcoded-micon"><i class="ti-map"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.crm-contact.main">Felállások</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${sessionHandler.userHasPermission('PLANS_CREATE') || sessionHandler.userHasPermission('PLANNER')}">
                <li class="pcoded-hasmenu ${requestURI.contains('/game') ? 'active' : ''}">
                    <a href="javascript:void(0)">
                        <span class="pcoded-micon"><i class="ti-cup"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.social.main">Mérkőzés</span>
                    </a>
                    <ul class="pcoded-submenu">
                        <c:if test="${sessionHandler.userHasPermission('PLANS_CREATE')}">
                            <li class="${requestURI.equals('/game') ? 'active' : ''}">
                                <a href="/game">
                                    <span class="pcoded-micon"><i class="ti-game"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Új mérkőzés</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('PLANNER')}">
                            <li class="${requestURI.equals('/gameplan') ? 'active' : ''}">
                                <a href="/gameplan">
                                    <span class="pcoded-micon"><i class="ti-map"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Felállás tervező</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </li>
            </c:if>
            <c:if test="${sessionHandler.userHasPermission('MLSZ_STATISTICS')}">
                <li class="pcoded-hasmenu ${(requestURI.contains('/statistics')) ? 'active' : ''}">
                    <a href="javascript:void(0)">
                        <span class="pcoded-micon"><i class="ti-stats-up"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.social.main">Statisztika</span>
                    </a>
                    <ul class="pcoded-submenu">
                        <c:if test="${sessionHandler.userHasPermission('MLSZ_STATISTICS')}">
                            <li class="${requestURI.equals('/statistics/dashboard') ? 'active' : ''}">
                                <a href="/statistics/dashboard">
                                    <span class="pcoded-micon"><i class="ti-pulse"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Dashboard</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('CAREER_TABLE')}">
                            <li class="${requestURI.equals('/statistics/league') ? 'active' : ''}">
                                <a href="/statistics/league">
                                    <span class="pcoded-micon"><i class="ti-pulse"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Liga</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('MLSZ_STATISTICS')}">
                            <li class="${requestURI.equals('/statistics/team') ? 'active' : ''}">
                                <a href="/statistics/team">
                                    <span class="pcoded-micon"><i class="ti-pulse"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Csapat</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </li>
            </c:if>
            <c:if test="${sessionHandler.userHasPermission('HOME_HEADER_BUTTONS')}">
                <li class="${requestURI.equals('/payment') ? 'active' : ''}">
                    <a href="/payment">
                        <span class="pcoded-micon"><i class="ti-credit-card"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.crm-contact.main">Számlák</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${sessionHandler.userHasPermission('COST_CREATE') || sessionHandler.userHasPermission('GROUP_COSTS') || sessionHandler.userHasPermission('STATEMENT')}">
                <li class="pcoded-hasmenu ${requestURI.contains('financial') ? 'active' : ''}">
                    <a href="javascript:void(0)">
                        <span class="pcoded-micon"><i class="ti-wallet"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.social.main">Pénzügy</span>
                    </a>
                    <ul class="pcoded-submenu">
                        <c:if test="${sessionHandler.userHasPermission('COST_CREATE')}">
                            <li class="${requestURI.equals('/financial/paymentrequest') ? 'active' : ''}">
                                <a href="/financial/paymentrequest">
                                    <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Számlák</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('ANNUAL_COST_CREATE')}">
                            <li class="${requestURI.equals('/financial/annual') ? 'active' : ''}">
                                <a href="/financial/annual">
                                    <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Megújuló számlák</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('COST_CREATE')}">
                            <li class="${requestURI.equals('/financial/create') ? 'active' : ''}">
                                <a href="/financial/create">
                                    <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Bevételek</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('COST_ACCEPT')}">
                            <li class="${requestURI.equals('/financial/accept') ? 'active' : ''}">
                                <a href="/financial/accept">
                                    <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Bevétel kezelő</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('GROUP_COSTS')}">
                            <li class="${requestURI.equals('/financial/group') ? 'active' : ''}">
                                <a href="/financial/group">
                                    <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Csoportok</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('GROUP_COSTS')}">
                            <li class="${requestURI.equals('/financial/grouping') ? 'active' : ''}">
                                <a href="/financial/grouping">
                                    <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Bevétel csoportosítás</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionHandler.userHasPermission('STATEMENT')}">
                            <li class="${requestURI.equals('/financial/statement') ? 'active' : ''}">
                                <a href="/financial/statement">
                                    <span class="pcoded-micon"><i class="ti-angle-right"></i></span>
                                    <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Kimutatások</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </li>
            </c:if>
            <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS')}">
                <li class="${requestURI.equals('/videoanalytics') ? 'active' : ''}">
                    <a href="/videoanalytics">
                        <span class="pcoded-micon"><i class="ti-video-clapper"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.social.fb-wall">Videóelemző</span>
                    </a>
                </li>
            </c:if>
            <c:if test="${sessionHandler.userHasPermission('LOGGED_IN')}">
                <li class="${requestURI.equals('/calendar') ? 'active' : ''}">
                    <a href="/calendar">
                        <span class="pcoded-micon"><i class="ti-calendar"></i></span>
                        <span class="pcoded-mtext" data-i18n="nav.crm-contact.main">Naptár</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </div>
</nav>
