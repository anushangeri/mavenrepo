
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="loginCSS.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.URL"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css"></style>
        <script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#escalation').DataTable();
            });
        </script>
</head>
<body>
    <div class="container body-content">
        <div class="page-header">
            <label class="heading">Generate Payslip</label>
            <br>
            <b>How to use:</b> Enter NRIC/FIN of employee and select dates to generate payslip.
            <br>
            <br>
            <div id='body' align='center'>
                <div id="generatepayslip">
                    <form action="/ProcessPayslipServlet" method="get">
                        <br/>
                        <input type="text" name="nricfin" class="form-control" placeholder="Enter NRIC/FIN (e.g. S1234567D)" required autofocus>
                        <br/>
                        <input id="paslip-month" class="form-control" type="month" name="payslipmonth" value="2017-06" required autofocus>
                        <br/>
                        <input type="text" name="avdpayment" class="form-control" placeholder="Enter advance (e.g. 300)" autofocus>
                        <br/>
                        <input type="text" name="acctnumber" class="form-control" placeholder="Enter Account Number (e.g. 123456789)" required autofocus>
                        <div class="payslipbtnstyle">
                            <button class="btn payslipbtn" type="submit">Generate Payslip</button>
                        </div>

                    </form>
                </div>
            </div>    
        </div>
    </div> 

</body>

</html>
