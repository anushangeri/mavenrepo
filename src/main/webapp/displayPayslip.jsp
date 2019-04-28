<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="loginCSS.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.URL"%>

<%@page import="com.google.gdata.client.spreadsheet.SpreadsheetService"%>
<%@page import="com.google.gdata.data.spreadsheet.CustomElementCollection"%>
<%@page import="com.google.gdata.data.spreadsheet.ListEntry"%>
<%@page import="com.google.gdata.data.spreadsheet.ListFeed"%>
<%@page import="com.google.gdata.util.ServiceException"%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css"></style>
        <script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#escalation').DataTable();
            });
        </script>
</head>
<body>
    <%
        HashMap<String, Object> responseObj = (HashMap<String, Object>) request.getAttribute("responseObj");
        if (responseObj == null) {
            %>
            <label class="heading">ERROR IN GENERATING PAYSLIP</label>
            <%
        }
    else{
            String name = ((String) responseObj.get("name")).toUpperCase();   
            String nric = (String) responseObj.get("nric"); 
            int age = Integer.parseInt (responseObj.get("age").toString()) ;  
            int annualLeavetaken = Integer.parseInt (responseObj.get("annualLeavetaken").toString());            
            int annualLeaveBal = Integer.parseInt (responseObj.get("annualLeaveBal").toString());         
            int compasionateleave = Integer.parseInt (responseObj.get("compasionateleave").toString());
            int medicalLeavetaken = Integer.parseInt (responseObj.get("medicalLeavetaken").toString());           
            int medicalLeaveBal = Integer.parseInt (responseObj.get("medicalLeaveBal").toString());  
            String breakHr = responseObj.get("breakHr").toString();
            double advpayment = Double.parseDouble(responseObj.get("avdpayment").toString());
            String acctnumber = (String) responseObj.get("acctnumber");
            String payslipMonth = (String) responseObj.get("paylipMonth");
//            
            int numberDaysWorked = Integer.parseInt(responseObj.get("numberDaysWorked").toString());
            int numberPHWorked = Integer.parseInt(responseObj.get("numberPHWorked").toString());
            int numberULWorked = Integer.parseInt(responseObj.get("numberULWorked").toString());
            ArrayList<TimeInTimeOut> timeInTimeOutPayslipDisplay = (ArrayList<TimeInTimeOut>) responseObj.get("timeInTimeOutPayslipDisplay");
//            
            double basicsalarymonth = Double.parseDouble(responseObj.get("basicsalarymonth").toString());
            double basicsalaryday = Double.parseDouble(responseObj.get("basicsalaryday").toString());
            double basicsalaryhour = Double.parseDouble(responseObj.get("basicsalaryhour").toString());
//
//             
            double OTRateFinal = Double.parseDouble(responseObj.get("OTRateFinal").toString());
//            
            double shiftOvertime = Double.parseDouble(responseObj.get("shiftOvertime").toString());
//            
            double lessUnworkedDays = Double.parseDouble(responseObj.get("lessUnworkedDays").toString());
//            
            double publicHolidays = Double.parseDouble(responseObj.get("publicHolidays").toString());
//            
            double grossPay = Double.parseDouble(responseObj.get("grossPay").toString());
//            
            double employeeCPF = Double.parseDouble(responseObj.get("employeeCPF").toString());
//            
            double employerCPF = Double.parseDouble(responseObj.get("employerCPF").toString());
//            
            double totalCPF = Double.parseDouble(responseObj.get("totalCPF").toString());
//            
            double costK11 = Double.parseDouble(responseObj.get("costK11").toString());
//            
            double takeHomePay = Double.parseDouble(responseObj.get("takeHomePay").toString());
//            
            double balSal = Double.parseDouble(responseObj.get("balSal").toString());
//            
            double balSalFinal = Double.parseDouble(responseObj.get("balSalFinal").toString());
    %>
    <div class="container body-content">
        <div class="page-header">
        <label class="heading">Payslip for <%=name%></label>
        <table width="100%" border="2" bgcolor="#ffffff">
            <tbody>
                <tr>
                    <td colspan=20><center>K11 Security Engineering Pte Ltd</center></td>
                </tr>
                <tr>
                    <td colspan=20><center>Payslip Month: <%=((payslipMonth.isEmpty()) ? "N/A" : payslipMonth.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <td colspan="5"><b>Employee Name: </td>
                    <td colspan="4"><b><%=name%></td>
                    <td colspan="2">Age: </td>
                    <td colspan="3"><%=age%></td>
                    <td colspan="3"><b>NRIC/FIN: </td>
                    <td colspan="3"><b><%=nric%></td>
                </tr>
                <tr>
                    <td colspan="5">Basic Salary: </td>
                    <td colspan="2">$<%=basicsalaryhour%></td>
                    <td colspan="3">per hour </td>
                    <td colspan="2">$<%=basicsalarymonth%></td>
                    <td colspan="3">per month </td>
                    <td colspan="2">$<%=basicsalaryday%></td>
                    <td colspan="3">per day </td>
                </tr>
                <tr>
                    <td colspan="4">OT Rate X 1.5: </td>
                    <td colspan="3">$<%=OTRateFinal%></td>
                    <td colspan="3">Account Number: </td>
                    <td colspan="4"><%=acctnumber%></td>
                    <td colspan="3">No of Working Days: </td>
                    <td colspan="3"><%=numberDaysWorked%></td>
                </tr>
                <tr>
                    <td colspan="4">Item: </td>
                    <td colspan="4">Amount: </td>
                    <td colspan="5">Days/Hrs: </td>
                    <td colspan="3">OFFICE USE: </td>
                    <td colspan="1"></td>
                    <td colspan="2">ADV PYT: </td>
                    <td colspan="1">AMT: </td>
                </tr>
                <tr>
                    <td colspan="4">Basic Salary: </td>
                    <td colspan="4">$<%=basicsalarymonth%></td>
                    <td colspan="5"></td>
                    <td colspan="3"></td>
                    <td colspan="1"></td>
                    <td colspan="2">ADV PYT: </td>
                    <td colspan="1">$<%=advpayment%></td>
                </tr>
                <tr>
                    <td colspan="4">Shift Overtime X1.5: </td>
                    <td colspan="4">$<%=shiftOvertime%></td>
                    <td colspan="5"></td>
                    <td colspan="3"></td>
                    <td colspan="1"></td>
                    <td colspan="2">BAL SAL: </td>
                    <td colspan="1">$<%=balSal%></td>
                </tr>
                <tr>
                    <td colspan="4">Add Overtime: </td>
                    <td colspan="4">$0.0</td>
                    <td colspan="5"></td>
                    <td colspan="3">ORDINARY WAGES</td>
                    <td colspan="1">$<%=grossPay%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Less unworked days: </td>
                    <td colspan="4">$<%=lessUnworkedDays%></td>
                    <td colspan="5"><%=numberULWorked%></td>
                    <td colspan="3">EMPLOYEE'S CPF</td>
                    <td colspan="1">$<%=employeeCPF%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Less Undertime: </td>
                    <td colspan="4">$0.0</td>
                    <td colspan="5"></td>
                    <td colspan="3">EMPLOYER'S CPF</td>
                    <td colspan="1">$<%=employerCPF%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Public Holidays X2: </td>
                    <td colspan="4">$<%=publicHolidays%></td>
                    <td colspan="5"><%=numberPHWorked%></td>
                    <td colspan="3">Total CPF</td>
                    <td colspan="1">$<%=totalCPF%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Rest Days X2: </td>
                    <td colspan="4">$0.0</td>
                    <td colspan="5">0</td>
                    <td colspan="3">Cost to K11: </td>
                    <td colspan="1">$<%=costK11%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Full Attendance Allowance: </td>
                    <td colspan="4">$0.0</td>
                    <td colspan="5"></td>
                    <td colspan="3">Annual Leave taken: </td>
                    <td colspan="1"><%=annualLeavetaken%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Site  Allowance: </td>
                    <td colspan="4">$0.0</td>
                    <td colspan="5"></td>
                    <td colspan="3">Annual Leave Bal: </td>
                    <td colspan="1"><%=annualLeaveBal%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Site Sup allowance: </td>
                    <td colspan="4">$0.0</td>
                    <td colspan="5"></td>
                    <td colspan="3">Compasionate leave: </td>
                    <td colspan="1"><%=compasionateleave%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Gross Pay: </td>
                    <td colspan="4">$<%=grossPay%></td>
                    <td colspan="5"></td>
                    <td colspan="3">Medical Leave taken: </td>
                    <td colspan="1"><%=medicalLeavetaken%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Less Employee's CPF: </td>
                    <td colspan="4">$<%=employeeCPF%></td>
                    <td colspan="5"></td>
                    <td colspan="3">Medical Leave Bal: </td>
                    <td colspan="1"><%=medicalLeaveBal%></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Less Advances/Loan: </td>
                    <td colspan="4">$0.0</td>
                    <td colspan="5"></td>
                    <td colspan="3"></td>
                    <td colspan="1"></td>
                    <td colspan="2"></td>
                    <td colspan="1"></td>
                </tr>
                <tr>
                    <td colspan="4">Take Home Pay: </td>
                    <td colspan="4"><b>$<%=takeHomePay%></td>
                    <td colspan="5"></td>
                    <td colspan="3"></td>
                    <td colspan="1"></td>
                    <td colspan="2"></td>
                    <td colspan="1">$<%=balSalFinal%></td>
                </tr>
            </tbody>
        </table>
        Note: * Rest Day/ PH worked on own request.
        <br>
        <br>
        <br>
        <table width="100%" border="2" bgcolor="#ffffff">
            <thead>
                <tr>
                    <th><center><b>Date IN</b></center></th>
                    <th><center><b>Time In</b></center></th>
                    <th><center><b>Date OUT</b></center></th>
                    <th><center><b>Time Out</b></center></th>
                    <th><center><b>Break Hrs (Hr)</b></center></th>
                    <th><center><b>Remarks</b></center></th>
                </tr>
            </thead>
            <tbody>
                <%
                    for(TimeInTimeOut eachTITO: timeInTimeOutPayslipDisplay){
                        String timeInDateAsStr = eachTITO.getTimeInDateAsStr();
                        String timeInTimeAsStr = eachTITO.getTimeInTimeAsStr();
                        String timeOutDateAsStr = eachTITO.getTimeOutDateAsStr();
                        String timeOutTimeAsStr = eachTITO.getTimeOutTimeAsStr();
                        String dutySite = eachTITO.getDutySite(); 
                        %>
                        <tr>
                            <td><center><%=timeInDateAsStr%></center></td>
                            <td><center><%=timeInTimeAsStr%></center></td>
                            <td><center><%=((timeOutDateAsStr == null) ? "N/A" : timeOutDateAsStr)%></center></td>
                            <td><center><%=((timeOutTimeAsStr == null) ? "N/A" : timeOutTimeAsStr)%></center></td>
                            <td><center><%=breakHr%></center></td>
                            <td><center><%=dutySite%></center></td>
                        </tr>
                        <%
                    }
                
                %>
            </tbody>
        </table>
        </div>
    </div>
    <%
     }
    %>
</body>

</html>
