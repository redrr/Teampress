<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/JSTL.jsp" %>
<html>
<head>
    <title>Teampress | Videóelemző</title>
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
                                    <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS')}">
                                        <div id="analyzer" class="row" style="display: none">
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h5>Videó elemző</h5>
                                                    </div>
                                                    <div class="card-body">
                                                        <div id="analyticTools" class="row analytictools highlight-sidebar-hidden">
                                                            <div class="col-4 mx-auto">
                                                                <div class="btn-group " role="group">
                                                                    <button type="button" onclick="pos = [];mode = 'line';$('#analyticTools').addClass('highlight-sidebar-hidden');$('#analyticConfirm').removeClass('highlight-sidebar-hidden')" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="Select"><i class="icofont icofont-simple-down"></i></button>
                                                                    <button type="button" onclick="pos = [];mode = 'line';$('#analyticTools').addClass('highlight-sidebar-hidden');$('#analyticConfirm').removeClass('highlight-sidebar-hidden')" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="Area"><i class="icofont icofont-angle"></i></button>
                                                                    <button type="button" onclick="pos = [];mode = 'line';$('#analyticTools').addClass('highlight-sidebar-hidden');$('#analyticConfirm').removeClass('highlight-sidebar-hidden')" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="Arrow"><i class="icofont icofont-long-arrow-right"></i></button>
                                                                    <div class="dropdown-primary dropdown open" data-toggle="tooltip" data-placement="top" title="Color">
                                                                        <button class="btn btn-dark btn-sm dropdown-toggle" type="button" id="dropdown-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">C</button>
                                                                        <div class="dropdown-menu" aria-labelledby="dropdown-2" data-dropdown-in="fadeIn" data-dropdown-out="fadeOut">
                                                                            <button class="dropdown-item" onclick="color = '#f3f3f3'">W</button>
                                                                            <button class="dropdown-item" onclick="color = '#CC0034'">G</button>
                                                                            <button class="dropdown-item" onclick="color = '#75FFB0'">R</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div id="analyticConfirm" class="row analytictools highlight-sidebar-hidden">
                                                            <div class="col-4 mx-auto">
                                                                <div class="btn-group " role="group">
                                                                    <button type="button" onclick="pos = [];$('#analyticTools').removeClass('highlight-sidebar-hidden')" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="yes"><i class="icofont icofont-ui-check"></i></button>
                                                                    <button type="button" onclick="pos = [];drawer();$('#analyticTools').removeClass('highlight-sidebar-hidden')" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="no"><i class="icofont icofont-ui-close"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div style="display: none" class="row">
                                                            <div class="col-4">
                                                                <div class="form-group row" style="margin: 0">
                                                                    <label class="col-4 col-form-label" for="mode">Mode</label>
                                                                    <select class="col-8 form-control" id="mode">
                                                                        <option value=""></option>
                                                                        <option value="line">Line</option>
                                                                        <option value="arrow">Arrow</option>
                                                                        <option value="select">Select</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-4">
                                                                <div class="form-group row" style="margin: 0">
                                                                    <label class="col-4 col-form-label" for="color">Szín</label>
                                                                    <select class="col-8 form-control" id="color">
                                                                        <option value="#f3f3f3">Fehér</option>
                                                                        <option value="#CC0034">Piros</option>
                                                                        <option value="#75FFB0">Zöld</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col-2">
                                                                <button style="float: right" id="clear" class="btn btn-danger btn-soft"><i class="ti-trash"></i></button>
                                                            </div>
                                                            <div class="col-2">
                                                                <button class="btn btn-icon" type="button" onclick="$('#analyzer').hide()"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                            </div>
                                                        </div>
                                                        <div class="row">
                                                            <div class="col-9">
                                                                <div class="mx-auto" style="min-height: 550px">
                                                                    <div id="videoHolder" style="position: absolute;">
                                                                        <video id="video" height="540" controls>
                                                                            <source id="source" src="" type="video/mp4">
                                                                            Your browser does not support the video tag.
                                                                        </video>
                                                                    </div>
                                                                    <div id="container" style="height: 500px; position: relative; z-index: 10; width: max-content;"></div>
                                                                </div>
                                                            </div>
                                                            <div class="col-3">
                                                                <div id="actionsSidebar" class="row highlight-sidebar">
                                                                    <div class="col-12">
                                                                        <button id="edit" class="btn btn-primary btn-soft w-100">New highlight</button>
                                                                        <hr>
                                                                    </div>
                                                                    <div id="actionsHolder" class="col-12">
                                                                        35:55
                                                                    </div>
                                                                </div>
                                                                <div id="recordActionSidebar" class="row highlight-sidebar highlight-sidebar-hidden">
                                                                    <div class="col-12">
                                                                        <button id="saveAction" class="btn btn-primary btn-soft w-100">Save</button>
                                                                        <hr>
                                                                    </div>
                                                                    <div class="col-12">

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h4>Videók</h4>
                                                        <span>Feltöltött videók</span>
                                                    </div>
                                                    <div class="card-body">
                                                        <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Dátum</th>
                                                                <th>Ellenfél</th>
                                                                <th>Helyszín</th>
                                                                <th></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="d" items="${data}">
                                                                <c:if test="${d.ligaGame!=null}">
                                                                    <tr>
                                                                        <td>${d.ligaGame.getDateAs(false)}</td>
                                                                        <td>${d.ligaGame.hazai} - ${d.ligaGame.vendeg}</td>
                                                                        <td>${d.ligaGame.hely}</td>
                                                                        <td>
                                                                            <button class="btn btn-primary btn-soft" onclick="setupVideo(${d.video.id},'${d.video.name}')"><i class="ti-image"></i> Elemzés</button>
                                                                        </td>
                                                                    </tr>
                                                                </c:if>
                                                                <c:if test="${d.customGame!=null}">
                                                                    <tr>
                                                                        <td>${d.customGame.getDateAs(false)}</td>
                                                                        <td>${d.customGame.enemy}</td>
                                                                        <td>${d.customGame.place}</td>
                                                                        <td>
                                                                            <button class="btn btn-primary btn-soft" onclick="setupVideo(${d.video.id},'${d.video.name}')"><i class="ti-image"></i> Elemzés</button>
                                                                        </td>
                                                                    </tr>
                                                                </c:if>
                                                            </c:forEach>
                                                            </tbody>
                                                            <tfoot>
                                                            </tfoot>
                                                        </table>
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
    <script src="<c:url value="/assets/js/play/VideoAnalytics.js"/>"></script>
    <script src="<c:url value="/assets/vendor/konva/konva.js"/>"></script>
</body>
</html>
