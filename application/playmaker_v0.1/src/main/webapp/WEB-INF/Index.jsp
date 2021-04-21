<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="include/JSTL.jsp" %>
<html>
    <head>
        <title>Teampress | Kezdőlap</title>
        <%@include file="include/Css.jsp" %>
        <link rel="stylesheet" type="text/css" href="../assets/vendor/assets/icon/SVG-animated/svg-weather.css">
    </head>
    <body>
        <%@include file="include/Loader.jsp" %>
        <div id="pcoded" class="pcoded">
            <div class="pcoded-overlay-box"></div>
            <div class="pcoded-container navbar-wrapper">
                <%@include file="include/Header.jsp" %>
                <div class="pcoded-main-container">
                    <div class="pcoded-wrapper">
                        <%@include file="include/Sidebar.jsp" %>
                        <div class="pcoded-content" style="overflow-y: scroll; top:4em">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">
                                        <div class="page-body">
                                            <div class="row animated fadeInUpBig">
                                                <!-- Normal layout-->
                                                <c:if test="${!sessionHandler.userHasPermission('ADMIN')}">
                                                    <div class="col-12 col-xl-9">
                                                        <div class="row">
                                                                <div class="col-12">
                                                                    <div class="card bg-white">
                                                                        <f:form id="form" cssClass="form-wp1" name='f' htmlEscape="true" action='/dopost' method='POST' modelAttribute="createPost" enctype="multipart/form-data">
                                                                            <div class="post-new-contain row card-block">
                                                                                <div class="col-md-1 col-2 post-profile">
                                                                                    <img id="post-avatar" src="../assets/vendor/assets/images/social/pro_icon.jpg" class="img-circle" alt="" style="width: 50px;height: 50px;">
                                                                                </div>
                                                                                <div class="col-md-10 col-8">
                                                                                    <div class="">
                                                                                        <f:input type="text" required="" path="postText" placeholder="Ossz meg valamit....." cssErrorClass="form-control" cssClass="form-control post-input" id="post-message" style="margin-top: 5px;background-color: #4b556614;padding: 10px;"/>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-1 col-2">
                                                                                    <div class="btn btn-inverse btn-icon image-upload" style="padding: 0;padding-top: 5px; margin-top: 4px;padding-left: 3px">
                                                                                        <label class="cr-pointer mt-1" for="file-input" style="margin: 0">
                                                                                            <i style="font-size: 25px; margin: 0" class="icofont icofont-image"></i>
                                                                                        </label>
                                                                                        <f:input id="file-input" type="file" path="file"/>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="post-new-footer b-t-muted p-15">
                                                                                <input id="submit" class="btn btn-primary btn-soft" name="save" type="submit" value="Mentés"/>
                                                                            </div>
                                                                        </f:form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        <div class="row">
                                                            <div class="col-12 mb-5">
                                                                <div id="posts"></div>
                                                                <div class="text-center">
                                                                    <button class="btn btn-soft btn-primary" onclick="nextFivePost()">Több</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-3 d-flex">
                                                        <c:if test="${sessionHandler.userHasPermission('HOME_HEADER_BUTTONS') || sessionHandler.userHasPermission('HOME_WEATHER')}">
                                                            <div class="row d-none d-xl-block" style="position: fixed;width: auto;">
                                                                <c:if test="${sessionHandler.userHasPermission('HOME_HEADER_BUTTONS')}">
                                                                    <div class="col-12">
                                                                        <a href="/calendar" class="card overflow-hidden" style="max-width: 90%;border:none;background-color: #3B5998">
                                                                            <div class="card-body">
                                                                                <h1 style="color: #fff;font-size: 65px;font-weight: 600;margin-left: 16px;margin-top: 0;margin-bottom: 16px">${nextTraining.trainingPlan.formattedTrainingDate.split("-")[1].trim()}</h1>
                                                                                <img style="width: 100%" src="/content/baseImages/training_icon.png">
                                                                                <c:if test="${nextTraining != null}">
                                                                                    <h3 style="color: #fff;margin-top: -130px;margin-bottom: 100px;margin-left: 16px">${nextTrainingDay}</h3>
                                                                                    <h3 style="color: #fff;margin-top: -100px;margin-bottom: 100px;margin-left: 16px">${nextTraining.trainingPlan.formattedTrainingDate.split("-")[0].trim()}</h3>
                                                                                </c:if>
                                                                                <c:if test="${nextTraining == null}">
                                                                                    <h4 style="color: #fff;margin-left: 16px">Nincs edzés a közeljövőben.</h4>
                                                                                </c:if>
                                                                            </div>
                                                                        </a>
                                                                    </div>
                                                                </c:if>
                                                                <c:if test="${sessionHandler.userHasPermission('HOME_WEATHER')}">
                                                                    <div class="col-12">
                                                                        <div class="card overflow-hidden" style="max-width: 90%;min-width: 300px;border:none;background-color: #3B5998">
                                                                            <div class="card-body text-center">
                                                                                <h1 style="color: #fff">${city}</h1>
                                                                                <h1 style="color: #fff;font-size: 50px;font-weight: 600;">${temp}°</h1>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </c:if>
                                                <!-- Admin layout-->
                                                <c:if test="${sessionHandler.userHasPermission('ADMIN')}">
                                                    <c:if test="${!error.equals('')}">
                                                        <div class="errors">
                                                            <div class="row">
                                                                <div class="col-12">
                                                                    <div class="alert alert-danger">${error}</div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                    <div class="col-lg-12 col-xl-6 mx-auto">
                                                        <div class="card">
                                                            <div class="card-body">
                                                                <!-- Nav tabs -->
                                                                <ul class="nav nav-tabs md-tabs" role="tablist">
                                                                    <li class="nav-item w-50">
                                                                        <a class="nav-link active" data-toggle="tab" href="#club" role="tab">Egyesületi adatok</a>
                                                                        <div class="slide w-50"></div>
                                                                    </li>
                                                                    <li class="nav-item w-50">
                                                                        <a class="nav-link" data-toggle="tab" href="#user" role="tab">Felhasználó importálás</a>
                                                                        <div class="slide w-50"></div>
                                                                    </li>
                                                                </ul>
                                                                <!-- Tab panes -->
                                                                <div class="tab-content card-block">
                                                                    <div class="tab-pane active" id="club" role="tabpanel">
                                                                        <div class="form-horizontal">
                                                                            <div class="row">
                                                                                <div class="col-12">
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="teamType">Sportág</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <select id="teamType" class="form-control">
                                                                                                <option value="football">Labdarugás</option>
                                                                                            </select>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="shortName">Rövid név</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <input id="shortName" type="text" class="form-control"/>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="longName">Teljes név</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <input id="longName" type="text" class="form-control"/>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="country">Ország</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <input id="country" type="text" class="form-control"/>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="city">Város</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <input id="city" type="text" class="form-control"/>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="postCode">Irányító szám</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <input id="postCode" type="text" class="form-control"/>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="street1">Utca 1</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <input id="street1" type="text" class="form-control"/>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="street2">Utca 2</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <input id="street2" type="text" class="form-control"/>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="currency">Pénznem</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <select id="currency" class="form-control">
                                                                                                <c:forEach var="cur" items="${currencies}">
                                                                                                    <option value="${cur}">${cur}</option>
                                                                                                </c:forEach>
                                                                                            </select>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="publicKey">Stripe publikus kulcs</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <input id="publicKey" type="text" class="form-control"/>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="form-group row">
                                                                                        <label class="col-12 col-md-4 col-form-label" for="privateKey">Stripe privát kulcs</label>
                                                                                        <div class="col-12 col-md-8 col-form-label">
                                                                                            <input id="privateKey" type="text" class="form-control"/>
                                                                                        </div>
                                                                                    </div>
                                                                                    <button class="btn btn-primary btn-soft" onclick="saveClub()" >Mentés</button>
                                                                                    <a class="btn btn-secondary btn-soft" href="/">Mégse</a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="tab-pane" id="user" role="tabpanel">
                                                                        <f:form id="form" class="form-horizontal" name='f' htmlEscape="true" action='/import/team' method='POST' modelAttribute="data" enctype="multipart/form-data">
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label" for="org-input">Egyesület</label>
                                                                                <div class="col-md-8 col-form-label">
                                                                                    <f:select id="org-input" type="text" path="organizationId" name="team-input" cssClass="selectpicker show-tick" data-size="5" data-live-search="true">
                                                                                        <c:forEach var="org" items="${organizations}">
                                                                                            <f:option value="${org.id}">${org.name}</f:option>
                                                                                        </c:forEach>
                                                                                    </f:select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label" for="team-input">Csapat</label>
                                                                                <div class="col-md-8 col-form-label">
                                                                                    <f:select id="team-input" type="text" path="teamId" name="team-input" cssClass="selectpicker show-tick" data-size="5" data-live-search="true">
                                                                                        <c:forEach var="team" items="${teams}">
                                                                                            <f:option value="${team.id}">${team.code}</f:option>
                                                                                        </c:forEach>
                                                                                    </f:select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label" for="team-input">Felhasználók típusa</label>
                                                                                <div class="col-md-8 col-form-label">
                                                                                    <f:select id="team-input" type="text" path="role" name="team-input" cssClass="selectpicker show-tick" data-size="5" data-live-search="true">
                                                                                        <c:forEach var="role" items="${roles}">
                                                                                            <f:option value="${role.name()}">${role.name()}</f:option>
                                                                                        </c:forEach>
                                                                                    </f:select>
                                                                                </div>
                                                                            </div>
                                                                            <div class="form-group row">
                                                                                <label class="col-md-4 col-form-label" for="file-input">Excel feltöltése</label>
                                                                                <div class="col-md-8 col-form-label">
                                                                                    <f:input id="file-input" type="file" path="data" name="file-input"/>
                                                                                </div>
                                                                            </div>
                                                                            <button class="btn btn-primary btn-soft" type="submit" >Mentés</button>
                                                                            <a class="btn btn-secondary btn-soft" href="/">Mégse</a>
                                                                        </f:form>
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
        </div>
        <%@include file="include/IE.jsp" %>
        <%@include file="include/JavaScript.jsp" %>
        <script>
            function saveClub() {
                let teamType = $('#teamType').val();
                let shortName = $('#shortName').val();
                let longName = $('#longName').val();
                let country = $('#country').val();
                let city = $('#city').val();
                let postCode = $('#postCode').val();
                let street1 = $('#street1').val();
                let street2 = $('#street2').val();
                let publicKey = $('#publicKey').val();
                let privateKey = $('#privateKey').val();
                let currency = $('#currency').val();
                $.post("/import/club",
                    {
                        teamType        :   teamType,
                        shortName       :   shortName,
                        longName        :   longName,
                        country         :   country,
                        city            :   city,
                        postCode        :   postCode,
                        street1         :   street1,
                        street2         :   street2,
                        publicKey       :   publicKey,
                        privateKey      :   privateKey,
                        currency        :   currency
                    },function (resp) {
                        window.location = '/';
                    }
                )
            }
        </script>
    </body>
</html>
