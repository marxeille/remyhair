<!doctype html>
<html lang="{{ app()->getLocale() }}">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.7 -->
        <link rel="stylesheet" href="{{asset('public/bower_components/bootstrap/dist/css/bootstrap.min.css')}}">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="{{asset('public/bower_components/font-awesome/css/font-awesome.min.css')}}">
        <!-- Ionicons -->
        <link rel="stylesheet" href="{{asset('public/dist/css/AdminLTE.min.css')}}">
        <!-- AdminLTE Skins. Choose a skin from the css/skins
             folder instead of downloading all of them to reduce the load. -->
        <link rel="stylesheet" href="{{asset('public/dist/css/skins/_all-skins.min.css')}}">
        <link rel="stylesheet" href="{{asset('public//plugins/iCheck/square/blue.css')}}">
        <link rel="stylesheet" href="{{asset('public/css/custom.css')}}">
        <!-- Google Font -->
        {{--<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">--}}
    </head>
    <body class="skin-blue sidebar-mini">
       <div id="root" class="wrapper">

       </div>
    </body>

    <script src="{{asset('public/bower_components/jquery/dist/jquery.min.js')}}"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="{{asset('public/bower_components/jquery-ui/jquery-ui.min.js')}}"></script>
    <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
    <!-- Bootstrap 3.3.7 -->
    <script src="{{asset('public/bower_components/bootstrap/dist/js/bootstrap.min.js')}}"></script>
    <!-- Morris.js charts -->
    <script type="text/javascript" src="{{asset('public/js/app.js')}}"></script>
    <script src="{{asset('public/dist/js/app.js')}}"></script>
    <script>
        $(document).ready(function(){
           if(window.location.pathname.indexOf('login')){
               $('body').addClass('login-page hold-transition');
              // $('#root').removeClass('wrapper');
           }
        });
    </script>

    <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
</html>
