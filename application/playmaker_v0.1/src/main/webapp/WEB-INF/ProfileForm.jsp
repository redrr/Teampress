<%--
  Created by IntelliJ IDEA.
  User: Matyi
  Date: 2020. 08. 09.
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<f:form id="profil_form" class="form-horizontal" name='f' htmlEscape="true" action='/profile' method='POST' modelAttribute="modifyProfile" enctype="multipart/form-data">
    <div class="form-group row">
        <label class="col-md-3 col-form-label" for="disabled-input">Felhasználónév</label>
        <div class="col-md-9 col-form-label">
            <input class="form-control" id="disabled-input" type="text" name="disabled-input" placeholder="${user.username}" disabled=""/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3 col-form-label" for="text-input">Teljes név</label>
        <div class="col-md-9 col-form-label">
            <f:input class="form-control" id="text-input" path="name" type="text" name="text-input" placeholder="Név..." value="${user.name}"/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3 col-form-label" for="password-input">Jelszó</label>
        <div class="col-md-9 col-form-label">
            <f:input class="form-control" id="password-input" path="password" type="password" name="password-input" placeholder="Jelszó..." value=""/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3 col-form-label" for="password-input">Jelszó újra</label>
        <div class="col-md-9 col-form-label">
            <f:input class="form-control" id="re-password-input" path="repassword" type="password" name="password-input" placeholder="Jelszó újra..." value=""/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3 col-form-label" for="email-input">Email cím</label>
        <div class="col-md-9 col-form-label">
            <f:input class="form-control" id="email-input" path="email" type="email" name="email-input" placeholder="Email..." value="${(user.email.equals('') ? 'példa@email.com' : user.email)}"/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-3 col-form-label" for="email-input">Telefon szám</label>
        <div class="col-md-9 col-form-label">
            <f:input class="form-control" id="phone-input" path="phone" name="phone-input" placeholder="Telefon..." value="${user.phoneNumber}"/>
        </div>
    </div>
    <div class="form-group row">
        <label class="col-md-4 col-form-label" for="file-input">Profilkép feltöltése</label>
        <div class="col-md-8 col-form-label">
            <f:input id="file-input" type="file" path="profileImg" name="file-input"/>
        </div>
    </div>
    <f:hidden path="id" value="${user.id}"/>
    <input id="submit" class="btn btn-primary btn-soft" name="save" type="submit" value="Mentés"/>
    <button type="button" id="clear" class="btn btn-light btn-soft" onclick="window.location='/profile'">Mégse</button>
</f:form>
