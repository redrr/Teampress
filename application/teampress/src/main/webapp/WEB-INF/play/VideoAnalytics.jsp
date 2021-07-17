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
            <%@include file="../include/Header.jsp" %>
            <div class="pcoded-main-container">
                <div class="pcoded-wrapper">
                    <%@include file="../include/Sidebar.jsp" %>
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
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <h5>Elemző</h5>
                                                                <span>Video elemzés</span>
                                                            </div>
                                                            <div class="col-6">
                                                                <button class="btn btn-icon f-right" type="button" onclick="$('#analyzer').hide();$('#tableCard').show();"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <div id="analyticTools" class="row analytictools highlight-sidebar-hidden">
                                                            <div class="col-4 mx-auto">
                                                                <div class="btn-group " role="group">
                                                                    <div class="dropdown-primary dropdown open f-left mr-2" data-toggle="tooltip" data-placement="top" title="Color">
                                                                        <button class="btn btn-dark btn-sm dropdown-toggle" type="button" id="dropdown-2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-circle" style="color: #f3f3f3"></i></button>
                                                                        <div class="dropdown-menu bg-dark" style="min-width: 55px" aria-labelledby="dropdown-2" data-dropdown-in="fadeIn" data-dropdown-out="fadeOut">
                                                                            <button class="dropdown-item" onclick="changeColor('#f3f3f3')"><i class="fa fa-circle" style="color: #f3f3f3"></i></button>
                                                                            <button class="dropdown-item" onclick="changeColor('#CC0034')"><i class="fa fa-circle" style="color: #CC0034"></i></button>
                                                                            <button class="dropdown-item" onclick="changeColor('#75FFB0')"><i class="fa fa-circle" style="color: #75FFB0"></i></button>
                                                                        </div>
                                                                    </div>

                                                                    <button type="button" onclick="pos = [];mode = 'select';$('#analyticTools').addClass('highlight-sidebar-hidden');$('#analyticConfirm').removeClass('highlight-sidebar-hidden')" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="Select"><i class="ti-target"></i></button>
                                                                    <button type="button" onclick="pos = [];mode = 'line';$('#analyticTools').addClass('highlight-sidebar-hidden');$('#analyticConfirm').removeClass('highlight-sidebar-hidden')" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="Area"><i class="ti-vector"></i></button>
                                                                    <button type="button" onclick="pos = [];mode = 'arrow';$('#analyticTools').addClass('highlight-sidebar-hidden');$('#analyticConfirm').removeClass('highlight-sidebar-hidden')" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="Arrow"><i class="ti-arrows-corner"></i></button>

                                                                    <button id="clear" type="button" class="btn btn-danger btn-sm ml-2" data-toggle="tooltip" data-placement="top" title="Clear"><i class="ti-trash"></i></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div id="analyticConfirm" class="row analytictools highlight-sidebar-hidden">
                                                            <div class="col-4 mx-auto">
                                                                <div class="btn-group " role="group">
                                                                    <button type="button" onclick="pos = [];$('#analyticTools').removeClass('highlight-sidebar-hidden');$('#analyticConfirm').addClass('highlight-sidebar-hidden');" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="yes"><i class="icofont icofont-ui-check"></i></button>
                                                                    <!-- TODO: Implement history -->
                                                                    <!--<button type="button" onclick="pos = [];drawer();$('#analyticTools').removeClass('highlight-sidebar-hidden');$('#analyticConfirm').addClass('highlight-sidebar-hidden');" class="btn btn-dark btn-sm" data-toggle="tooltip" data-placement="top" title="no"><i class="icofont icofont-ui-close"></i></button>-->
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div id="errorHolder" class="row">

                                                        </div>
                                                        <div class="row">
                                                            <div class="col-9">
                                                                <div id="videoHolder" class="mx-auto">
                                                                    <div style="position: absolute;">
                                                                        <video id="video" controls muted>
                                                                            <source id="source" src="" type="video/mp4">
                                                                            Your browser does not support the video tag.
                                                                        </video>
                                                                    </div>
                                                                    <div id="container" style="height: 500px; position: relative; z-index: 10; width: max-content;"></div>
                                                                </div>
                                                            </div>
                                                            <div class="col-3">
                                                                <div id="actionsSidebar" class="row highlight-sidebar">
                                                                    <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS_EDIT')}">
                                                                        <div class="col-12">
                                                                            <button id="edit" class="btn btn-primary btn-soft w-100"><i class="ti-plus"></i> Új akció</button>
                                                                            <hr>
                                                                        </div>
                                                                    </c:if>
                                                                    <div id="actionsHolder" class="col-12" style="overflow-y: auto;height: inherit"></div>
                                                                </div>
                                                                <div id="recordActionSidebar" class="row highlight-sidebar highlight-sidebar-hidden">
                                                                    <div class="col-12">
                                                                        <div class="row">
                                                                            <div class="col">
                                                                                <button id="saveAction" class="btn btn-primary btn-soft w-100 editInput"><i class="ti-save"></i> Mentés</button>
                                                                            </div>
                                                                            <div class="col">
                                                                                <button id="cancelAction" class="btn btn-secondary btn-soft w-100"><i class="ti-back-right"></i> Vissza</button>
                                                                            </div>
                                                                        </div>
                                                                        <hr>
                                                                    </div>
                                                                    <div class="col-12" style="overflow: hidden;">
                                                                        <input id="actionId" style="display: none"/>
                                                                        <div class="form-group row">
                                                                            <label class="col-12 col-form-label" for="actionName">Név</label>
                                                                            <div class="col-12 col-form-label">
                                                                                <input id="actionName" class="form-control" type="text" name="actionName"/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group row">
                                                                            <label class="col-12 col-form-label" for="actionPlayers">Résztvevők</label>
                                                                            <div class="col-12 col-form-label">
                                                                                <select id="actionPlayers" class="form-control" type="text" name="actionName"></select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group row">
                                                                            <label class="col-12 col-form-label" for="actionComment">Megjegyzés</label>
                                                                            <div class="col-12 col-form-label">
                                                                                <textarea id="actionComment" class="form-control" type="text" name="actionName" rows="5"></textarea>
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
                                        <div id="tableCard" class="row">
                                            <div class="col-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <h5>Videók</h5>
                                                                <span>Feltöltött videók</span>
                                                            </div>
                                                            <div class="col-6">
                                                                <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS_EDIT')}">
                                                                    <button style="float: right" class="btn btn-primary btn-soft" data-toggle="modal" data-target="#videoModal"><i class="ti-upload"></i> Feltöltés</button>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-body">
                                                        <table id="table" class="table table-striped table-bordered" style="width:100%">
                                                            <thead>
                                                            <tr>
                                                                <th>Videó címe</th>
                                                                <th>Feltöltés dátuma</th>
                                                                <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS_EDIT')}">
                                                                    <th>Státusz</th>
                                                                </c:if>
                                                                <th search="disabled"></th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            <c:forEach var="video" items="${data}">
                                                                <tr>
                                                                    <td>${video.name}</td>
                                                                    <td>${video.simpleCreationDateAsString}</td>
                                                                    <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS_EDIT')}">
                                                                        <td>
                                                                            <c:if test="${video.isPublic.equals(true)}">
                                                                                <span class="badge badge-lg badge-success">Közzétéve</span>
                                                                            </c:if>
                                                                            <c:if test="${video.isPublic.equals(false)}">
                                                                                <span class="badge badge-lg badge-info">Szerkesztés alatt</span>
                                                                            </c:if>
                                                                        </td>
                                                                    </c:if>
                                                                    <td>
                                                                        <button class="btn btn-primary btn-soft" onclick="setupVideo(${video.id},'${video.fileName}', ${video.team.id})"><i class="ti-video-clapper"></i> Elemzés</button>
                                                                        <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS_EDIT')}">
                                                                            <c:if test="${video.isPublic.equals(false)}">
                                                                                <button type="button" class="btn btn-info btn-soft" onclick="publishVideo(${video.id})"><i class="ti-trash"></i> Közzététel</button>
                                                                            </c:if>
                                                                            <button type="button" class="btn btn-danger btn-soft" onclick="deleteVideo(${video.id})"><i class="ti-trash"></i> Törlés</button>
                                                                        </c:if>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                            </tbody>
                                                            <tfoot>
                                                            </tfoot>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 id="trainingModalTitle" class="modal-title">Video feltöltés</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <f:form id="form" class="form-horizontal" name='f' htmlEscape="true" action='/videoanalytics' method='POST' modelAttribute="video" enctype="multipart/form-data">
                                                            <div class="form-group row">
                                                                <label class="col-md-4 col-form-label" for="name-input">Név</label>
                                                                <div class="col-md-8 col-form-label">
                                                                    <f:input id="name-input" cssClass="form-control" type="text" path="name" name="name-input"/>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label class="col-md-4 col-form-label" for="team-input">Csapat</label>
                                                                <div class="col-md-8 col-form-label">
                                                                    <f:select id="team-input" type="text" path="teamId" name="team-input" cssClass="selectpicker show-tick" data-size="5" data-live-search="true">
                                                                        <c:forEach var="team" items="${teamTypes}">
                                                                            <f:option value="${team.id}">${team.code}</f:option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row">
                                                                <label class="col-md-4 col-form-label" for="file-input">Video feltöltése</label>
                                                                <div class="col-md-8 col-form-label">
                                                                    <f:input id="file-input" type="file" path="video" name="file-input"/>
                                                                </div>
                                                            </div>
                                                            <button class="btn btn-primary btn-soft" type="submit" >Mentés</button>
                                                            <button class="btn btn-secondary btn-soft" type="button" data-dismiss="modal" aria-label="Close">Mégse</button>
                                                        </f:form>
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
        let isEditMode = false;
    </script>
    <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS_EDIT')}">
        <script>
            isEditMode = true;
        </script>
    </c:if>
    <script src="<c:url value="/assets/js/play/VideoAnalytics.js"/>"></script>
    <script src="<c:url value="/assets/vendor/konva/konva.js"/>"></script>
</body>
</html>
