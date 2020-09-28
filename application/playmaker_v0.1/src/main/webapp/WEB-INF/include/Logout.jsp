<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Kijelentkezés</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">Biztosan kiszeretnél jelentkezni? </div>
            <div class="modal-footer">
                <button class="btn btn-secondary btn-soft" type="button" data-dismiss="modal">Mégse</button>
                <a class="btn btn-success btn-soft" href="<c:url value="/logout"/>">Kijelentkezés</a>
            </div>
        </div>
    </div>
</div>
