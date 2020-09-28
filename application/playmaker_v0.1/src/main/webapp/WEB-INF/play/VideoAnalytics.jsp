<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../include/JSTL.jsp" %>
<html>
    <head>
        <%@include file="../include/Head.jsp" %>
    </head>
    <body>
        <%@include file="../include/Sidebar.jsp" %>
        <button id="addVideoModalButton" style="display: none" data-toggle="modal" data-target="#addVideoModal"></button>
        <div class="modal fade" id="addVideoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-success modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Új jelenet</h4>
                        <button id="closeModal" class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                    </div>
                    <div class="modal-body">
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
                                    <select id="folder">
                                        <option value="1">
                                            testGroup
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-6 row">
                                <label for="user" class="col-sm-4 col-form-label">Sportoló</label>
                                <div class="col-sm-8 label-static">
                                    <select id="user">
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
                    </div>
                    <div class="modal-footer">
                        <button class="btn btn-success btn-soft" type="button" onclick="sendVideo()">Mentés</button>
                        <button class="btn btn-secondary btn-soft" type="button" onclick="$('#closeModal').click()">Mégse</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="c-wrapper c-fixed-components">
            <%@include file="../include/Header.jsp" %>
            <div class="c-body">
                <main class="c-main">
                    <div class="container-fluid">
                        <div class="ui-view">
                            <div class="fade-in">
                                <c:if test="${sessionHandler.userHasPermission('VIDEO_ANALYTICS')}">
                                    <div id="analyzer" class="row" style="display: none">
                                        <div class="col-12">
                                            <div class="card">
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-2 col-form-label">
                                                            <h4 class="card-title" style="margin: 0">Videó elemző</h4>
                                                        </div>
                                                        <div class="col-2 col-form-label">
                                                            <button id="play" class="btn btn-secondary btn-soft"><i class="cil-media-play"></i></button>
                                                            <button id="mute" class="btn btn-success btn-soft"><i class="cil-volume-high"></i></button>
                                                        </div>
                                                        <div class="col-4 col-form-label">
                                                            <div class="row">
                                                                <label class="col-3 col-form-label" for="color">Vastagság</label>
                                                                <div class="col-9">
                                                                    <div class="d-flex justify-content-center my-2">
                                                                        <div class="w-75">
                                                                            <input id="width" type="range" class="custom-range" onchange="$('#percentvalue').text($(this).val()+' px')" value='1' min="1" max="20"/>
                                                                        </div>
                                                                        <span class="font-weight-bold text-success ml-2" id='percentvalue'>1 px</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-2 col-form-label">
                                                            <div class="form-group row" style="margin: 0">
                                                                <label class="col-4 col-form-label" for="color">Szín</label>
                                                                <select class="col-8 form-control" id="color">
                                                                    <option value="#ffffff">Fehér</option>
                                                                    <option value="#CC0034">Piros</option>
                                                                    <option value="#3E38F2">Kék</option>
                                                                    <option value="#75FFB0">Zöld</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col-1 col-form-label">
                                                            <button style="float: right" id="clear" class="btn btn-lg btn-secondary btn-soft"><i class="cil-trash"></i></button>
                                                        </div>
                                                        <div class="col-1 col-form-label">
                                                            <button class="close" type="button" onclick="$('#analyzer').hide()"><span>×</span></button>
                                                        </div>
                                                    </div>
                                                    <hr>
                                                    <div class="mx-auto" style="min-height: 550px">
                                                        <div id="videoHolder" style="position: absolute;">
                                                            <video id="video" height="540">
                                                                <source id="source" src="" type="video/mp4">
                                                                Your browser does not support the video tag.
                                                            </video>
                                                        </div>
                                                        <div id="container" style="height: 500px; position: relative; z-index: 10; width: max-content;"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="card col-12">
                                            <div class="card-header">
                                                <div class="row">
                                                    <div class="col-11">
                                                        <h4 class="card-title">Meccs felvételek</h4>
                                                    </div>
                                                    <div class="col-1">
                                                        <button class="btn btn-success btn-soft" type="button" data-toggle="modal" data-target="#videoModal"><i class="cil-cloud-upload"></i></button>
                                                    </div>
                                                </div>
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
                                                                    <button class="btn btn-success btn-soft" onclick="setupVideo(${d.video.id},'${d.video.name}')"><i class="cil-tv"></i> Elemzés</button>
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                        <c:if test="${d.customGame!=null}">
                                                            <tr>
                                                                <td>${d.customGame.getDateAs(false)}</td>
                                                                <td>${d.customGame.enemy}</td>
                                                                <td>${d.customGame.place}</td>
                                                                <td>
                                                                    <button class="btn btn-success btn-soft" onclick="setupVideo(${d.video.id},'${d.video.name}')"><i class="cil-tv"></i> Elemzés</button>
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
                                    <div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-success modal-lg" role="document">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 id="trainingModalTitle" class="modal-title">Video feltöltés</h4>
                                                    <button class="close" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
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
                                                        <button class="btn btn-success btn-soft" type="submit" >Mentés</button>
                                                        <button class="btn btn-secondary  btn-soft" type="button" data-dismiss="modal" aria-label="Close">Mégse</button>
                                                    </f:form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <%@include file="../include/Footer.jsp" %>
            <%@include file="../include/Js.jsp" %>
            <script src="<c:url value="/assets/js/play/VideoAnalytics.js"/>"></script>
        </div>
    </body>
</html>
