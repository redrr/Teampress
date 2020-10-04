<%--
  Created by IntelliJ IDEA.
  User: Matyi
  Date: 2020. 07. 29.
  Time: 13:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- HTML5 Shim and Respond.js IE9 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<!-- Meta -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description" content="Phoenixcoded">
<meta name="keywords" content="flat ui, admin , Flat ui, Admin , Responsive, Landing, Bootstrap, App, Template, Mobile, iOS, Android, apple, creative app">
<meta name="author" content="Phoenixcoded">
<!-- Favicon icon -->
<link rel="icon" href="../../assets/vendor/assets/images/favicon.ico" type="image/x-icon">
<!-- Google font-->
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
<!-- Required Fremwork -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-alpha2/css/bootstrap.min.css" integrity="sha384-DhY6onE6f3zzKbjUPRc2hOzGAdEf4/Dz+WJwBvEYL/lkkIsI3ihufq9hk9K4lVoK" crossorigin="anonymous">
<!-- themify-icons line icon -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/icon/themify-icons/themify-icons.css">
<!-- ico font -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/icon/icofont/css/icofont.css">
<!-- simple line icon -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/icon/simple-line-icons/css/simple-line-icons.css">
<!-- typicon icon -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/icon/typicons-icons/css/typicons.min.css">
<!-- flag icon framework css -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/pages/flag-icon/flag-icon.min.css">
<!-- Menu-Search css -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/pages/menu-search/css/component.css">
<!-- hover-effect.css -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/pages/hover-effect/normalize.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/pages/hover-effect/set2.css">
<!-- animation nifty modal window effects css -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/css/component.css">
<!-- Data Table Css -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/datatables.net-bs4/css/dataTables.bootstrap4.min.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/pages/data-table/css/buttons.dataTables.min.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css">
<!-- sweet alert framework -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/sweetalert/css/sweetalert.css">
<!-- Jconfirm -->
<link rel="stylesheet" href="../../assets/vendor/jconfirm/css/jquery-confirm.css" type="text/css">
<!-- datetime-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" type="text/css">
<!-- Style.css -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/css/style.css">
<link rel="stylesheet" type="text/css" href="../../assets/css/elements/rating.css">
<link rel="stylesheet" type="text/css" href="../../assets/css/elements/slider.css">
<!--Custom css-->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/css/linearicons.css" >
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/css/simple-line-icons.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/css/ionicons.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/assets/css/jquery.mCustomScrollbar.css">
<link rel="stylesheet" type="text/css" href="../../assets/css/main.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/animate.css/css/animate.css">
<!-- Rating -->
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/jquery-bar-rating/css/fontawesome-stars.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/jquery-bar-rating/css/bars-1to10.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/jquery-bar-rating/css/bars-horizontal.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/jquery-bar-rating/css/bars-movie.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/jquery-bar-rating/css/bars-pill.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/jquery-bar-rating/css/bars-reversed.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/jquery-bar-rating/css/bars-square.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/jquery-bar-rating/css/css-stars.css">
<link rel="stylesheet" type="text/css" href="../../assets/vendor/bower_components/jquery-bar-rating/css/fontawesome-stars-o.css">
<!-- Required Jquery -->
<script type="text/javascript" src="../../assets/vendor/bower_components/jquery/js/jquery.min.js"></script>
<script type="text/javascript" src="../../assets/vendor/bower_components/jquery-ui/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="../../assets/vendor/bower_components/popper.js/js/popper.min.js"></script>
<script type="text/javascript" src="../../assets/vendor/bower_components/bootstrap/js/bootstrap.min.js"></script>
<!-- jquery slimscroll js -->
<script type="text/javascript" src="../../assets/vendor/bower_components/jquery-slimscroll/js/jquery.slimscroll.js"></script>
<!-- Calender css -->
<link rel="stylesheet" href="../../assets/vendor/fullcalendar/fullcalendar.min.css" type="text/css"/>
<link rel="stylesheet" href="../../assets/vendor/fullcalendar/packages/daygrid/main.css" type="text/css"/>
