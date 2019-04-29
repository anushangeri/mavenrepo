<%-- 
    Document   : index
    Created on : Apr 29, 2018, 6:33:59 PM
    Author     : jayan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="loginCSS.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>

        <div class="card">
            <a href="employeeparticulars.jsp">
                <div class="eachCard crop">
                    <img class="center-block" src="employeeparticulars.png" alt="employeeparticulars.jpg">
                    <h4 class="fontheader"><b>EMPLOYEE PARTICULARS worksS</b></h4> 
                </div>
            </a>
        </div>

        <div class="card">
            <a href="todhod.jsp">
                <div class="eachCard crop">
                    <img class="center-block" src="todhod.png" alt="todhod.jpg">
                    <h4 class="fontheader"><b>TOD/HOD DETAILS</b></h4> 
                </div>
            </a>
        </div>

        <div class="card">
            <a href="payslip.jsp">
                <div class="eachCard crop">
                    <img class="center-block" src="payslip.png" alt="todhod.jpg">
                    <h4 class="fontheader"><b>GENERATE PAYSLIP</b></h4> 
                </div>
            </a>
        </div>
	<div id='body' align='center'>
                <div id="generatepayslip">
                    <form action="hello" method="post">
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
                <%
		        String responseObj = (String) request.getAttribute("responseObj");
		        if (responseObj == null) {
		            %>
		            <label class="heading">ERROR IN GENERATING PAYSLIP</label>
		            <%
		        }
		        else{
		        	%>
		        	<td colspan="4"><b><%=responseObj%></td>
		        	<%
		        }
            	%>
            </div>    
    </body>
</html>
