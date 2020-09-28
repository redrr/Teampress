<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<title>Playmaker</title>
    <!--favicon-->
<link rel="icon" href="/resources/image/playmaker_fav.png" type="image/x-icon">
    <!-- core ui CSS-->
<link rel="stylesheet" href="<c:url value="/assets/vendor/core-ui/css/core-ui.min.css"/>">
<link rel="stylesheet" href="https://unpkg.com/@coreui/icons/css/all.min.css">
    <!-- Calendar CSS -->
<link rel="stylesheet" href="<c:url value="/assets/vendor/fullcalendar/fullcalendar.min.css"/>" type="text/css"/>
<link rel="stylesheet" href="<c:url value="/assets/vendor/fullcalendar/packages/daygrid/main.css"/>" type="text/css"/>
    <!-- DataTables CSS -->
<link rel="stylesheet" href="<c:url value="/assets/vendor/datatables/css/dataTables.bootstrap4.min.css"/>" type="text/css">
<link rel="stylesheet" href="<c:url value="/assets/vendor/jconfirm/css/jquery-confirm.css"/>" type="text/css">
    <!-- skins CSS-->
<!-- <link href="/resources/new/lobibox.min.css" rel="stylesheet"> -->
<link rel="stylesheet" href="<c:url value="/assets/vendor/fontawesome-free/css/all.css"/>" type="text/css"/>

<!-- Quill Theme included stylesheets -->
<!--<link href="<c:url value="/assets/vendor/quill-text-editor/css/quill.core.css"/>" rel="stylesheet">-->
<link href="<c:url value="/assets/vendor/quill-text-editor/css/quill.snow.css"/>" rel="stylesheet">
<!--<link href="<c:url value="/assets/vendor/quill-text-editor/css/quill.bubble.css"/>" rel="stylesheet">-->

<link href="<c:url value="/assets/css/header.css"/>" rel="stylesheet">
<link rel="stylesheet" href="<c:url value="/assets/vendor/bootstrap-notify/bootstrap-notify.css"/>" type="text/css">
<link rel="stylesheet" href="<c:url value="/assets/vendor/animate/animate.min.css"/>" type="text/css">
<link rel="stylesheet" href="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css"/>" type="text/css">
<script src="<c:url value="/assets/vendor/jQuery/jquery-3.4.1.js"/>"></script>
  <script>
    <c:if test="${not empty tableData}">
    var tableData = ${tableData};
    </c:if>
    <c:if test="${not empty tableData2}">
    var tableData2 = ${tableData2};
    </c:if>
</script>
<c:if test="${not empty tableData}">
    <style>
    .form-control {
        background-size: 100% !important;
    }
    </style>
</c:if>

