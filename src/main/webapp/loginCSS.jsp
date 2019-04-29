<%-- 
    Document   : loginCSS
    Created on : Sep 19, 2014, 5:58:46 PM
    Author     : Wei Fa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/png" sizes="96x96" href="favicon-96x96.png">
        <!--Method #1 of Initializing Bootstrap--> 
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- Optional theme -->
        <link rel="stylesheet" href="css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="css/styles.css">
        <link href=' http://fonts.googleapis.com/css?family=Inconsolata|Droid+Sans' rel='stylesheet' type='text/css'>
        <style>
            .navbar-default {
                background-color: #9b59b6;
                border-color: #8e44ad;
            }
            .navbar-default .navbar-brand {
                color: #ff6600;
            }
            .navbar-default .navbar-brand:hover, .navbar-default .navbar-brand:focus {
                color: #ecdbff;
            }
            .navbar-default .navbar-text {
                color: #ff6600;
            }
            .navbar-default .navbar-nav > li > a {
                color: #ff6600;
            }
            .navbar-default .navbar-nav > li > a:hover, .navbar-default .navbar-nav > li > a:focus {
                color: #ecdbff;
            }
            .navbar-default .navbar-nav > .active > a, .navbar-default .navbar-nav > .active > a:hover, .navbar-default .navbar-nav > .active > a:focus {
                color: #ecdbff;
                background-color: #8e44ad;
            }
            .navbar-default .navbar-nav > .open > a, .navbar-default .navbar-nav > .open > a:hover, .navbar-default .navbar-nav > .open > a:focus {
                color: #ecdbff;
                background-color: #8e44ad;
            }
            .navbar-default .navbar-toggle {
                border-color: #8e44ad;
            }
            .navbar-default .navbar-toggle:hover, .navbar-default .navbar-toggle:focus {
                background-color: #8e44ad;
            }
            .navbar-default .navbar-toggle .icon-bar {
                background-color: #ecf0f1;
            }
            .navbar-default .navbar-collapse,
            .navbar-default .navbar-form {
                border-color: #ecf0f1;
            }
            .navbar-default .navbar-link {
                color: #ff6600;
            }
            .navbar-default .navbar-link:hover {
                color: #ecdbff;
            }
            body{

                background-color: #A9A9A9;
            }
            @media (max-width: 767px) {
                .navbar-default .navbar-nav .open .dropdown-menu > li > a {
                    color: #ff6600;
                }
                .navbar-default .navbar-nav .open .dropdown-menu > li > a:hover, .navbar-default .navbar-nav .open .dropdown-menu > li > a:focus {
                    color: #ecdbff;
                }
                .navbar-default .navbar-nav .open .dropdown-menu > .active > a, .navbar-default .navbar-nav .open .dropdown-menu > .active > a:hover, .navbar-default .navbar-nav .open .dropdown-menu > .active > a:focus {
                    color: #ecdbff;
                    background-color: #8e44ad;
                }
            }
        </style>
    <nav class="navbar navbar-inverse" role="navigation">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp">K11 HOME</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="employeeparticulars.jsp">Employee Particulars</a></li>
                    <li><a href="todhod.jsp">TOD/HOD Details</a></li>
                    <li><a href="payslip.jsp">Generate Payslip</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    <title>K11 eSERVICE</title>
</head>
<body>
    <h1 id="k11title">K11 SECURITY ENGINEERING eSERVICE</h1>
</body>


</html>
