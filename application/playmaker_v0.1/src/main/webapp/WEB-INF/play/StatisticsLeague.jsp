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
    <title>Teampress | Karrier</title>
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
                                        <c:if test="${sessionHandler.userHasPermission('CAREER_TABLE')}">
                                            <div class="row animated fadeInUpBig">
                                                <div class="col-12">
                                                    <div class="card">
                                                        <div class="card-header" style="z-index: 700; background-color: #fff">
                                                            <div class="row">
                                                                <div class="col-10">
                                                                    <h5>Liga adatok</h5>
                                                                    <span>Liga adatok az MLSZ adatbankból</span>
                                                                </div>
                                                                <div class="col-2">
                                                                    <select id="ligaSelect">
                                                                        <c:forEach var="liga" items="${ligas}">
                                                                            <option value="${liga.id}">${liga.liga}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="card-block" style="padding-top: 0">
                                                            <div class="row">
                                                                <div class="col-xl-12 col-md-12">
                                                                    <c:forEach var="liga" items="${ligas}">
                                                                        <div class="ligaTab">
                                                                            <ul class="nav nav-tabs md-tabs" role="tablist" style="z-index: 700">
                                                                                <li class="nav-item" style="width: 20%">
                                                                                    <a class="nav-link active" data-toggle="tab" href="#tabl-${liga.id}" role="tab" aria-expanded="true">Tabella</a>
                                                                                    <div class="slide" style="width: 20%"></div>
                                                                                </li>
                                                                                <li class="nav-item" style="width: 20%">
                                                                                    <a class="nav-link" data-toggle="tab" href="#sors-${liga.id}" role="tab" aria-expanded="false">Sorsolás</a>
                                                                                    <div class="slide" style="width: 20%"></div>
                                                                                </li>
                                                                                <li class="nav-item" style="width: 20%">
                                                                                    <a class="nav-link" data-toggle="tab" href="#gol-${liga.id}" role="tab" aria-expanded="false">Gólkirályok</a>
                                                                                    <div class="slide" style="width: 20%"></div>
                                                                                </li>
                                                                                <li class="nav-item" style="width: 20%">
                                                                                    <a class="nav-link" data-toggle="tab" href="#sarga-${liga.id}" role="tab" aria-expanded="false">Sárgalapok</a>
                                                                                    <div class="slide" style="width: 20%"></div>
                                                                                </li>
                                                                                <li class="nav-item" style="width: 20%">
                                                                                    <a class="nav-link" data-toggle="tab" href="#piros-${liga.id}" role="tab" aria-expanded="false">Piroslapok</a>
                                                                                    <div class="slide" style="width: 20%"></div>
                                                                                </li>
                                                                            </ul>
                                                                            <div class="tab-content">
                                                                                <div class="tab-pane  active" id="tabl-${liga.id}" role="tabpanel" aria-expanded="true">
                                                                                    <div class="table-responsive">
                                                                                        <table class="table table-striped table-bordered">
                                                                                            <thead>
                                                                                            <tr>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Helyezés">H.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Csapat">Csapat</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Lejátszott mérkőzések száma">M.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Győzelmek száma">GY.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Döntetlenek száma">D.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Vereségek száma">V.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Lőtt gólok száma">LG.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Kapott gólok száma">KG.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Gólkülönbség">GK.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Pontszám">P.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Eddigi elenfelek helyezésének az átlaga">BR.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Forma">Forma</th>
                                                                                            </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                            <c:forEach var="tabella" items="${tabellas}">
                                                                                                <c:if test="${tabella.key.equals(liga.id)}">
                                                                                                    <c:forEach var="t" items="${tabella.value}">
                                                                                                        <tr class="${t.csapat.equals(org.name) ? "highlighted" : ""}">
                                                                                                            <td scope="row">${t.helyezes}</td>
                                                                                                            <th>${t.csapat}</th>
                                                                                                            <td>${t.mecsekSzama}</td>
                                                                                                            <td>${t.gyozelemekSzama}</td>
                                                                                                            <td>${t.dontetlenekSzama}</td>
                                                                                                            <td>${t.veresegekSzama}</td>
                                                                                                            <td>${t.lottGolokSzama}</td>
                                                                                                            <td>${t.kapottGolokSzama}</td>
                                                                                                            <td>${t.golkulonbseg}</td>
                                                                                                            <td>${t.pontszam}</td>
                                                                                                            <td>${t.ellenfelekHelyezesenekAtlaga}</td>
                                                                                                            <td>
                                                                                                                <c:if test="${t.forma1.equals('GY')}">
                                                                                                                    <c:set var="css1" value="primary"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma1.equals('D')}">
                                                                                                                    <c:set var="css1" value="warning"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma1.equals('V')}">
                                                                                                                    <c:set var="css1" value="danger"/>
                                                                                                                </c:if>
                                                                                                                <span style="font-size: 100%; width: 35px" class="badge badge-${css1}">${t.forma1}</span>
                                                                                                                <c:if test="${t.forma2.equals('GY')}">
                                                                                                                    <c:set var="css2" value="primary"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma2.equals('D')}">
                                                                                                                    <c:set var="css2" value="warning"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma2.equals('V')}">
                                                                                                                    <c:set var="css2" value="danger"/>
                                                                                                                </c:if>
                                                                                                                <span style="font-size: 100%; width: 35px" class="badge badge-${css2}">${t.forma2}</span>
                                                                                                                <c:if test="${t.forma3.equals('GY')}">
                                                                                                                    <c:set var="css3" value="primary"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma3.equals('D')}">
                                                                                                                    <c:set var="css3" value="warning"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma3.equals('V')}">
                                                                                                                    <c:set var="css3" value="danger"/>
                                                                                                                </c:if>
                                                                                                                <span style="font-size: 100%; width: 35px" class="badge badge-${css3}">${t.forma3}</span>
                                                                                                                <c:if test="${t.forma4.equals('GY')}">
                                                                                                                    <c:set var="css4" value="primary"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma4.equals('D')}">
                                                                                                                    <c:set var="css4" value="warning"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma4.equals('V')}">
                                                                                                                    <c:set var="css4" value="danger"/>
                                                                                                                </c:if>
                                                                                                                <span style="font-size: 100%; width: 35px" class="badge badge-${css4}">${t.forma4}</span>
                                                                                                                <c:if test="${t.forma5.equals('GY')}">
                                                                                                                    <c:set var="css5" value="primary"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma5.equals('D')}">
                                                                                                                    <c:set var="css5" value="warning"/>
                                                                                                                </c:if>
                                                                                                                <c:if test="${t.forma5.equals('V')}">
                                                                                                                    <c:set var="css5" value="danger"/>
                                                                                                                </c:if>
                                                                                                                <span style="font-size: 100%; width: 35px" class="badge badge-${css5}">${t.forma5}</span>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </c:forEach>
                                                                                                </c:if>
                                                                                            </c:forEach>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="tab-pane" id="sors-${liga.id}" role="tabpanel" aria-expanded="false">
                                                                                    <div class="table-responsive">
                                                                                        <table class="table table-striped table-bordered">
                                                                                            <thead>
                                                                                            <tr>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Hazai">Hazai</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Eredmény">E.</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Vendég">Vendég</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Dátum">Dátum</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Helyszín">Helyszín</th>
                                                                                            </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                            <c:forEach var="s" items="${sorsolas}">
                                                                                                <c:if test="${s.key.equals(liga.id)}">
                                                                                                    <c:forEach var="data" items="${s.value}">
                                                                                                        <tr>
                                                                                                            <th scope="row">${data.hazai}</th>
                                                                                                            <td><span style="font-size: 100%; width: 48px" class="badge badge-primary">${(data.eredmeny.contains(':') || data.getDateAs(false).equals('')) ? 'n.a.' : data.eredmeny}</span>
                                                                                                            </td>
                                                                                                            <th>${data.vendeg}</th>
                                                                                                            <td>${data.getDateAs(false)}</td>
                                                                                                            <td>${data.hely}</td>
                                                                                                        </tr>
                                                                                                    </c:forEach>
                                                                                                </c:if>
                                                                                            </c:forEach>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="tab-pane" id="gol-${liga.id}" role="tabpanel" aria-expanded="false">
                                                                                    <div class="table-responsive">
                                                                                        <table class="table table-striped table-bordered">
                                                                                            <thead>
                                                                                            <tr>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Helyezés">Helyezés</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Játékos neve">Játékos</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Gólok száma">Gólok</th>
                                                                                            </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                            <c:forEach var="goal" items="${golok}">
                                                                                                <c:if test="${goal.key.equals(liga.id)}">
                                                                                                    <c:forEach var="data" items="${goal.value}">
                                                                                                        <tr class="${data.name.equalsIgnoreCase(user.name) ? "highlighted" : ""}">
                                                                                                            <td scope="row">${data.hely}</td>
                                                                                                            <th>${data.name}</th>
                                                                                                            <td>${data.goal}</td>
                                                                                                        </tr>
                                                                                                    </c:forEach>
                                                                                                </c:if>
                                                                                            </c:forEach>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="tab-pane" id="sarga-${liga.id}" role="tabpanel" aria-expanded="false">
                                                                                    <div class="table-responsive">
                                                                                        <table class="table table-striped table-bordered">
                                                                                            <thead>
                                                                                            <tr>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Helyezés">Helyezés</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Játékos neve">Játékos</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Sárgalapok száma">Sárgalapok</th>
                                                                                            </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                            <c:forEach var="sarga" items="${sargak}">
                                                                                                <c:if test="${sarga.key.equals(liga.id)}">
                                                                                                    <c:forEach var="data" items="${sarga.value}">
                                                                                                        <tr class="${data.name.equalsIgnoreCase(user.name) ? "highlighted" : ""}">
                                                                                                            <td scope="row">${data.hely}</td>
                                                                                                            <th>${data.name}</th>
                                                                                                            <td>${data.card}</td>
                                                                                                        </tr>
                                                                                                    </c:forEach>
                                                                                                </c:if>
                                                                                            </c:forEach>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="tab-pane" id="piros-${liga.id}" role="tabpanel" aria-expanded="false">
                                                                                    <div class="table-responsive">
                                                                                        <table class="table table-striped table-bordered">
                                                                                            <thead>
                                                                                            <tr>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Helyezés">Helyezés</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Játékos neve">Játékos</th>
                                                                                                <th scope="col" data-toggle="tooltip" data-placement="top" title="" data-original-title="Piroslapok száma">Piroslapok</th>
                                                                                            </tr>
                                                                                            </thead>
                                                                                            <tbody>
                                                                                            <c:forEach var="piros" items="${pirosak}">
                                                                                                <c:if test="${piros.key.equals(liga.id)}">
                                                                                                    <c:forEach var="data" items="${piros.value}">
                                                                                                        <tr class="${data.name.equalsIgnoreCase(user.name) ? "highlighted" : ""}">
                                                                                                            <td scope="row">${data.hely}</td>
                                                                                                            <th>${data.name}</th>
                                                                                                            <td>${data.card}</td>
                                                                                                        </tr>
                                                                                                    </c:forEach>
                                                                                                </c:if>
                                                                                            </c:forEach>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </c:forEach>
                                                                </div>
                                                            </div>
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
    <script>
        <%@include file="../../assets/js/play/League.js" %>
    </script>
</body>
</html>