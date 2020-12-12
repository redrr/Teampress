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
                                        <button id="addVideoModalButton" class="btn btn-success btn-soft btn-outline-success waves-effect md-trigger" type="button" style="display: none" data-modal="addVideoModal"></button>
                                        <div class="md-modal md-effect-9" id="addVideoModal">
                                            <div class="md-content">
                                                <h3>Új Jelenet</h3>
                                                <div>
                                                    <div class="form-group row">
                                                        <div class="col-12 row">
                                                            <label for="sceneName" class="col-3 col-form-label">Jelenet címe</label>
                                                            <div class="col-9">
                                                                <input class="form-control" type="text" placeholder="Jelenet címe" id="sceneName">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-6 row">
                                                            <label for="folder" class="col-sm-4 col-form-label">Mappa</label>
                                                            <div class="col-sm-8 label-static">
                                                                <select class="form-control" id="folder">
                                                                    <option value="1">
                                                                        testGroup
                                                                    </option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-6 row">
                                                            <label for="user" class="col-sm-4 col-form-label">Sportoló</label>
                                                            <div class="col-sm-8 label-static">
                                                                <select class="form-control" id="user">
                                                                    <option value="1">
                                                                        testUser
                                                                    </option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="col-12 row">
                                                            <label for="sceneDesc" class="col-3 col-form-label">Jelenet leírása</label>
                                                            <div class="col-9">
                                                                <textarea class="form-control" id="sceneDesc" rows="3">Testdesc</textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <button class="btn btn-primary btn-soft waves-effect md-close" type="button" onclick="sendVideo()">Mentés</button>
                                                        <button class="btn btn-secondary btn-soft waves-effect md-close" type="button" onclick="$('#closeModal').click()">Mégse</button>
                                                        <button id="closeModal" style="display: none" type="button" onclick="setClose()"></button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="analyzer" class="row" style="display: none">
                                            <div class="col-sm-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <h5>Elemző</h5>
                                                                <span>Jelenet kivágás</span>
                                                            </div>
                                                            <div class="col-6">
                                                                <button onclick="$('#analyzer').hide()" style="float: right" class="btn btn-light btn-icon"><i style="margin: 0" class="ti-close"></i></button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
                                                        <div class="mx-auto row" style="min-height: 550px">
                                                            <div id="videoHolder" class="col-12">
                                                                <video id="video" width="100%" controls>
                                                                    <source id="source" src="" type="video/mp4">
                                                                    Your browser does not support the video tag.
                                                                </video>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row animated fadeInUpBig">
                                            <div class="col-sm-12">
                                                <div class="card">
                                                    <div class="card-header">
                                                        <div class="row">
                                                            <div class="col-6">
                                                                <h5>Videók</h5>
                                                                <span>Feltöltött videók</span>
                                                            </div>
                                                            <div class="col-6">
                                                                <button style="float: right" class="btn btn-primary btn-soft" data-toggle="modal" data-target="#videoModal"><i class="ti-upload"></i> Feltöltés</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="card-block">
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
                                                                            <button class="btn btn-primary btn-soft" onclick="setupVideo(${d.video.id},'${d.video.name}')"><i class="ti-stats-up"></i> Szerkesztés</button>
                                                                        </td>
                                                                    </tr>
                                                                </c:if>
                                                                <c:if test="${d.customGame!=null}">
                                                                    <tr>
                                                                        <td>${d.customGame.getDateAs(false)}</td>
                                                                        <td>${d.customGame.enemy}</td>
                                                                        <td>${d.customGame.place}</td>
                                                                        <td>
                                                                            <button class="btn btn-primary btn-soft" onclick="setupVideo(${d.video.id},'${d.video.name}')"><i class="ti-stats-up"></i> Szerkesztés</button>
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
                                        <div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-success modal-lg" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 id="trainingModalTitle" class="modal-title">Video feltöltés</h4>
                                                        <button class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <f:form id="form" class="form-horizontal" name='f' htmlEscape="true" action='/videoeditor' method='POST' modelAttribute="video" enctype="multipart/form-data">
                                                            <div class="form-group row bmd-form-group">
                                                                <label for="sorsId" class="col-sm-4 col-form-label">Liga meccs</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:select path="sorsId" id="sorsId">
                                                                        <option></option>
                                                                        <c:forEach items="${sors}" var="type">
                                                                            <option value="${type.getId()}">
                                                                                    ${type.getDateAs(false)} - ${type.liga.liga} : ${type.hazai} - ${type.vendeg}
                                                                            </option>
                                                                        </c:forEach>
                                                                    </f:select>
                                                                </div>
                                                            </div>
                                                            <div class="form-group row bmd-form-group">
                                                                <label for="otherId" class="col-sm-4 col-form-label">Egyéb meccs</label>
                                                                <div class="col-sm-8 label-static">
                                                                    <f:select path="customId" id="otherId">
                                                                        <option></option>
                                                                        <c:forEach items="${other}" var="type">
                                                                            <option value="${type.getId()}">
                                                                                    ${type.getDateAs(false)} - ${type.team.code} : Ellenfél - ${type.enemy}
                                                                            </option>
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
    <script src="<c:url value="/assets/js/play/VideoEditor.js"/>"></script>
    <script src="<c:url value="/assets/vendor/konva/konva.js"/>"></script>
</body>
</html>