<%--
  Created by IntelliJ IDEA.
  User: Matyi
  Date: 2020. 08. 09.
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<button id="ratingButton" style="display: none" data-toggle="modal" data-target="#ratingModal"></button>
<div title="" class="modal fade" id="ratingModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-success modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Edző értékelés</h4>
                <button id="ratingModalout" class="btn btn-icon" type="button" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"><i style="margin: 0" class="ti-close"></i></span></button>
            </div>
            <div class="modal-body">
                <div class="row mb-3">
                    <div class="col-12 text-center">
                        <h5>Értékeld az edződ heti munkáját!</h5>
                    </div>
                    <div class="col-12">
                        <div class="d-flex justify-content-center my-2">
                            <div class="w-75">
                                <input type="range" class="custom-range" value='0' onchange="$('#rangevalue').text($(this).val()+'/10')" id="range" min="0" max="10" step="1"/>
                            </div>
                            <span class="font-weight-bold text-primary ml-2" id='rangevalue'>0/10</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary btn-soft" type="button" onclick="sendRating($('#ratingModal'), $('#range'))">Küldés</button>
                </div>
            </div>
        </div>
    </div>
</div>