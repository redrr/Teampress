$(document).ready(function () {
    createDataTable('playerTable');
});

function manageUser(id, status) {
    $.post(
        "/dashboard/manageuser",
        {
            username    :   id,
            status      :   status
        }, function () {
            window.location = '/dashboard';
        }
    )
}

function changeTeam(s, id) {
    let teams = s.split(', ');
    let holder = $('#origTeamsChangeTeam');
    $('#entityChangeTeam').val(id);
    holder.html('');
    let body = '';
    for (let i = 0; i < teams.length; i++) {
        body += '<option value="'+teams[i]+'">'+teams[i]+'</option>';
    }
    holder.html(body);
    $('#btnChangeTeam').click();
}

function changeTeamPost() {
    $.post(
        "/dashboard/changeteam",
        {
            username    :   $('#entityChangeTeam').val(),
            oldType      :   $('#origTeamsChangeTeam').val(),
            newType      :   $('#allTeamsChangeTeam').val()
        }, function () {
            window.location = '/dashboard';
        }
    )
}

function removeTeam(s, id) {
    let teams = s.split(', ');
    let holder = $('#origTeamsRemoveTeam');
    $('#entityRemoveTeam').val(id);
    holder.html('');
    let body = '';
    for (let i = 0; i < teams.length; i++) {
        body += '<option value="'+teams[i]+'">'+teams[i]+'</option>';
    }
    holder.html(body);
    $('#btnRemoveTeam').click();
}


function addTeam(id) {
    $('#entityAddTeam').val(id);
    $('#btnAddTeam').click();
}

function modifyTeamPost(id, team, type) {
    $.post(
        "/dashboard/modifyteam",
        {
            username    :   id.val(),
            type      :   team.val(),
            mod      :   type
        }, function () {
            window.location = '/dashboard';
        }
    )
}
