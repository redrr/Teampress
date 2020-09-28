<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="c-sidebar c-sidebar-dark c-sidebar-fixed c-sidebar-lg-show" id="sidebar">
    <div class="c-sidebar-brand d-lg-down-none">
        <!--<img src="" class="c-sidebar-brand-full" width="118" height="46" alt="CoreUI Logo">
        <img src="" class="c-sidebar-brand-minimized" width="46" height="46" alt="CoreUI Logo">-->
    </div>
    <ul class="c-sidebar-nav">
        <li class="c-sidebar-nav-title">Menü</li>
        <c:set var="requestURI" value="${requestScope['javax.servlet.forward.request_uri']}"/>

        <!-- Playmaker -->
        <c:if test="${sessionHandler.userHasPermission('LOGGED_IN')}">
            <li class="c-sidebar-nav-item">
                <a class="c-sidebar-nav-link ${requestURI.equals('/home') ? 'c-active' : ''}" href="/home">
                   <i class="c-sidebar-nav-icon cil-home"></i>
                   Kezdőlap
                </a>
            </li>
        </c:if>
        <c:if test="${sessionHandler.userHasPermission('CAREER_TABLE')}">
            <li class="c-sidebar-nav-item">
                <a class="c-sidebar-nav-link ${requestURI.equals('/career') ? 'c-active' : ''}" href="/career">
                   <i class="c-sidebar-nav-icon cil-address-book"></i>
                   Karrier
                </a>
            </li>
        </c:if>
        <c:if test="${sessionHandler.userHasPermission('TRAIN_TABLE') || sessionHandler.userHasPermission('EXERCISE_TABLE')}">
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/trainingplan') ? 'c-active' : ''}">
                   <i class="c-sidebar-nav-icon cil-clipboard"></i>
                   Edzéstervező
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <c:if test="${sessionHandler.userHasPermission('EXERCISE_TABLE')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/exercise">
                                <i class="c-sidebar-nav-icon cil-weightlifitng"></i>
                                Gyakorlat felvétel
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionHandler.userHasPermission('TRAIN_TABLE')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/trainingplan">
                                <i class="c-sidebar-nav-icon cil-pencil"></i>
                                Edzés felvétel
                            </a>
                        </li>
                    </c:if>
                </ul>
            </li>
        </c:if>
        <c:if test="${sessionHandler.userHasPermission('WORKOUT_ALL_TABLE') || sessionHandler.userHasPermission('WORKOUT_PLAYER_TABLE')}">
            <li class="c-sidebar-nav-item c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-link ${requestURI.equals('/workout') ? 'c-active' : ''}" href="/workout">
                   <i class="c-sidebar-nav-icon cil-bolt"></i>
                   Edzésmunka
                </a>
            </li>
        </c:if>
        <c:if test="${sessionHandler.userHasPermission('PLANS_TABLE')}">
            <li class="c-sidebar-nav-item c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-link ${requestURI.equals('/game') ? 'c-active' : ''}" href="/gameplan">
                    <i class="c-sidebar-nav-icon cil-football"></i>
                    Felállások
                </a>
            </li>
        </c:if>
        <c:if test="${sessionHandler.userHasPermission('PLANS_CREATE') || sessionHandler.userHasPermission('PLANNER')}">
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.contains('/game') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-football"></i>
                    Meccstervező
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <c:if test="${sessionHandler.userHasPermission('PLANS_CREATE')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/game">
                                <i class="c-sidebar-nav-icon cil-location-pin"></i>
                                Meccs felvétel
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionHandler.userHasPermission('PLANNER')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/gameplan">
                                <i class="c-sidebar-nav-icon cil-gamepad"></i>
                                Felállás tervező
                            </a>
                        </li>
                    </c:if>
                </ul>
            </li>
        </c:if>
        <c:if test="${sessionHandler.userHasPermission('PLAYERS_STAT') || sessionHandler.userHasPermission('TRAINERS_STAT') || sessionHandler.userHasPermission('TEAMS_STAT')}">
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.contains('stat') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-chart-pie"></i>
                    Statisztikák
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <c:if test="${sessionHandler.userHasPermission('PLAYERS_STAT')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/playerstat">
                                <i class="c-sidebar-nav-icon cil-user"></i>
                                Játékos statisztikák
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionHandler.userHasPermission('TRAINERS_STAT')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/trainerstat">
                                <i class="c-sidebar-nav-icon cil-bullhorn"></i>
                                Edzői statisztikák
                            </a>
                        </li>
                    </c:if>
                </ul>
            </li>
        </c:if>
        <c:if test="${sessionHandler.userHasPermission('COST_CREATE') || sessionHandler.userHasPermission('GROUP_COSTS') || sessionHandler.userHasPermission('STATEMENT')}">
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/financial') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-wallet"></i>
                    Pénzügyek
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <c:if test="${sessionHandler.userHasPermission('COST_CREATE')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/financial/create">
                                <i class="c-sidebar-nav-icon cil-dollar"></i>
                                Új Kiadás/Bevétel
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionHandler.userHasPermission('COST_ACCEPT')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/financial/accept">
                                <i class="c-sidebar-nav-icon cil-credit-card"></i>
                                Kiadás/Bevétel kezelés
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionHandler.userHasPermission('GROUP_COSTS')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/financial/group">
                                <i class="c-sidebar-nav-icon cil-folder"></i>
                                Új csoport
                            </a>
                        </li>
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/financial/grouping">
                                <i class="c-sidebar-nav-icon cil-folder-open"></i>
                                Kiadás/Bevétel csoportosítás
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${sessionHandler.userHasPermission('STATEMENT')}">
                        <li class="c-sidebar-nav-item">
                            <a class="c-sidebar-nav-link" href="/financial/statement">
                                <i class="c-sidebar-nav-icon cil-notes"></i>
                                Kimutatások
                            </a>
                        </li>
                    </c:if>
                </ul>
            </li>
        </c:if>
        <c:if test="${sessionHandler.userHasPermission('LOGGED_IN') && !sessionHandler.userHasPermission('ADMIN')}">
            <li class="c-sidebar-nav-item">
                <a class="c-sidebar-nav-link ${requestURI.equals('/naptar') ? 'c-active' : ''}" href="/calendar">
                   <i class="c-sidebar-nav-icon cil-calendar"></i>
                   Naptár
                </a>
            </li>
        </c:if>
        <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS')}">
            <li class="c-sidebar-nav-item">
                <a class="c-sidebar-nav-link ${requestURI.equals('/videoanalytics') ? 'c-active' : ''}" href="/videoanalytics">
                    <i class="c-sidebar-nav-icon cil-movie"></i>
                    Videó elemző
                    <span class="badge badge-danger">Demo</span>
                </a>
            </li>
        </c:if>

        <!-- Admin -->
        <c:if test="${sessionHandler.userHasPermission('ADMIN')}">
            <!-- Rendszer -->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/sys') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-memory"></i>
                    Rendszer
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/sys/log">
                            <i class="c-sidebar-nav-icon cil-bug"></i>
                            Logok
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/sys/lookup">
                            <i class="c-sidebar-nav-icon cil-puzzle"></i>
                            Elemek
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/sys/param">
                            <i class="c-sidebar-nav-icon cil-code"></i>
                            Paraméterek
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/sys/notification">
                            <i class="c-sidebar-nav-icon cil-bell"></i>
                            Értesítések
                        </a>
                    </li>
                </ul>
            </li>
            <!-- Egyesületek-->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/org') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-running"></i>
                    Egyesület
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/org/organization">
                            <i class="c-sidebar-nav-icon cil-running"></i>
                            Egyesületek
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/org/orgcountry">
                            <i class="c-sidebar-nav-icon cil-notes"></i>
                            Egyesületi adatok
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/org/league">
                            <i class="c-sidebar-nav-icon cil-dollar"></i>
                            Ligák
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/org/userorg">
                            <i class="c-sidebar-nav-icon cil-user-follow"></i>
                            Tagfelvétel
                        </a>
                    </li>
                </ul>
            </li>
            <!-- Jogosultságok -->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/priv') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-shield-alt"></i>
                    Jogosultság
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/priv/role">
                            <i class="c-sidebar-nav-icon cil-tag"></i>
                            Szerepkörök
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/priv/rolepriv">
                            <i class="c-sidebar-nav-icon cil-tags"></i>
                            Szerepkör jogosultságok
                        </a>
                    </li>
                </ul>
            </li>
            <!-- Felhasználók-->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/usr') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-people"></i>
                    Felhasználók
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/usr/user">
                            <i class="c-sidebar-nav-icon cil-user"></i>
                            Felhasználó
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/usr/userrole">
                            <i class="c-sidebar-nav-icon cil-voice-over-record"></i>
                            Felhasználói szerepkörök
                        </a>
                    </li>
                </ul>
            </li>
            <!-- Adatbank -->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/db') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-storage"></i>
                    Adatbank
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/db/playerdata">
                            <i class="c-sidebar-nav-icon cil-short-text"></i>
                            Játékos adatok
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/db/tab">
                            <i class="c-sidebar-nav-icon cil-spreadsheet"></i>
                            Tabella
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/db/sors">
                            <i class="c-sidebar-nav-icon cil-rss"></i>
                            Sorsolás
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/db/goals">
                            <i class="c-sidebar-nav-icon cil-check"></i>
                            Gólok
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/db/yellow">
                            <i class="c-sidebar-nav-icon cil-warning"></i>
                            Sárgalapok
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/db/red">
                            <i class="c-sidebar-nav-icon cil-x-circle"></i>
                            Piroslapok
                        </a>
                    </li>
                </ul>
            </li>
            <!-- Events -->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/game') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-calendar-check"></i>
                    Események
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/event/calendar">
                            <i class="c-sidebar-nav-icon cil-calendar"></i>
                            Naptár
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/event/post">
                            <i class="c-sidebar-nav-icon cil-send"></i>
                            Posztok
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/event/comment">
                            <i class="c-sidebar-nav-icon cil-comment-square"></i>
                            Kommentek
                        </a>
                    </li>
                </ul>
            </li>
            <!-- Edzésterv -->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/train') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-clipboard"></i>
                    Edzéstervezés
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/train/exercise">
                            <i class="c-sidebar-nav-icon cil-weightlifitng"></i>
                            Gyakoraltok
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/train/plans">
                            <i class="c-sidebar-nav-icon cil-pencil"></i>
                            Edzések
                        </a>
                    </li>
                </ul>
            </li>
            <!-- Edzésmunka -->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/wk') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-bolt"></i>
                    Edzésmunka
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/wk/jelen">
                            <i class="c-sidebar-nav-icon cil-check-alt"></i>
                            Jelenlét
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/wk/workout">
                            <i class="c-sidebar-nav-icon cil-bolt"></i>
                            Edzésmunka
                        </a>
                    </li>
                </ul>
            </li>
            <!-- Gameplan -->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/game') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-bus-alt"></i>
                    Meccskezelő
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/game/customgames">
                            <i class="c-sidebar-nav-icon cil-bullhorn"></i>
                            Meccsek
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/game/plans">
                            <i class="c-sidebar-nav-icon cil-football"></i>
                            Felállások
                        </a>
                    </li>
                </ul>
            </li>
            <!-- Pénzügyek -->
            <li class="c-sidebar-nav-dropdown">
                <a class="c-sidebar-nav-dropdown-toggle ${requestURI.equals('/game') ? 'c-active' : ''}">
                    <i class="c-sidebar-nav-icon cil-wallet"></i>
                    Pénzügyek
                </a>
                <ul class="c-sidebar-nav-dropdown-items">
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/fin/income">
                            <i class="c-sidebar-nav-icon cil-dollar"></i>
                            Instrumentumok
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/fin/group">
                            <i class="c-sidebar-nav-icon cil-folder"></i>
                            Csoportok
                        </a>
                    </li>
                    <li class="c-sidebar-nav-item">
                        <a class="c-sidebar-nav-link" href="/fin/groupconn">
                            <i class="c-sidebar-nav-icon cil-folder-open"></i>
                            Csoportosított elemek
                        </a>
                    </li>
                </ul>
            </li>
        </c:if>
    </ul>
    <button class="c-sidebar-minimizer c-class-toggler" type="button" data-target="_parent" data-class="c-sidebar-minimized"></button>
</div>