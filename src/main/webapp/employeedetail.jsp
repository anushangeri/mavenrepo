
<%@page import="java.text.SimpleDateFormat"%>
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
        <link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css"></style>
    <script type="text/javascript" src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>

</head>
<body>

    <%
        SpreadsheetService service = new SpreadsheetService("Employment Particulars ");
        try {
//            //getting the sheet number:
//            String sheetNameUrl
//                    = "https://spreadsheets.google.com/feeds/list/1Fcv9alOBh-SHR7Yxl_yiQMK05lbjJaDX7ba5AkTrK90/1/public/values";
//
//            // Use this String as url
//            URL urlName = new URL(sheetNameUrl);
//
//            // Get Feed of Spreadsheet url
//            ListFeed lfName = service.getFeed(urlName, ListFeed.class);
//            String sheetNumber = "1";
//            //Iterate over feed to get cell value
//            for (ListEntry le : lfName.getEntries()) {
//                CustomElementCollection cec = le.getCustomElements();
//                //Pass column name to access it's cell values
//                if (cec.getValue("sheetname").equals("Employment Particulars")) {
//                    sheetNumber = cec.getValue("sheetnumber");
//                }
//            }
            String sheetUrl
                    = "https://spreadsheets.google.com/feeds/list/1aGjQLWkAWP2Oa9H5vzTZaddduVoHLTbJn0J7XgUH_1I/1/public/values";

            // Use this String as url
            URL url = new URL(sheetUrl);

            // Get Feed of Spreadsheet url
            ListFeed lf = service.getFeed(url, ListFeed.class);
    %>
    <div class="container body-content">
        <div class="page-header">
            <label class="heading">Employee Details of <%=request.getParameter("name").toUpperCase()%></label>

            <table class="table" cellspacing="0" width="100%">
                <tbody>

                    <%
                        //Iterate over feed to get cell value
                        String name = "";
                        String nricfin = "";
                        String workpermitnumber = "";
                        String passportnumber = "";
                        String contactnumber = "";
                        String permanentaddress = "";
                        String postaladdress = "";
                        String dateofbirth = "";
                        String race = "";
                        String emergencycontact = "";
                        String emergencycontactnumber = "";
                        String fathername = "";
                        String mothername = "";
                        String nricmalaysianonly = "";
                        String highestqualification = "";
                        String securitylicensegrade = "";
                        String securitycoursesattended = "";
                        String datejoined = "";
                        String fulltimeorparttime = "";
                        Date lastestDate = null;
                        for (ListEntry le : lf.getEntries()) {
                            CustomElementCollection cec = le.getCustomElements();
                            //Pass column name to access it's cell values

                            nricfin = cec.getValue("nricfin").trim();
                            String checkForDuplicateRecords = cec.getValue("timestamp");
                            SimpleDateFormat sf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
                            Date date = sf.parse(checkForDuplicateRecords);

                            //check if the current timestamp is equal to OR after the lastest date => to get the lastest record
                            if (nricfin.equals(request.getParameter("nricfin").trim())) {
                                //first record
                                if (lastestDate == null) {
                                    name = cec.getValue("name");
                                    workpermitnumber = cec.getValue("workpermitnumber");
                                    passportnumber = cec.getValue("passportnumber");
                                    contactnumber = cec.getValue("contactnumber");
                                    permanentaddress = cec.getValue("permanentaddress");
                                    postaladdress = cec.getValue("postaladdress");
                                    dateofbirth = cec.getValue("dateofbirth");
                                    race = cec.getValue("race");
                                    emergencycontact = cec.getValue("emergencycontact");
                                    emergencycontactnumber = cec.getValue("emergencycontactnumber");
                                    fathername = cec.getValue("fathername");
                                    mothername = cec.getValue("mothername");
                                    nricmalaysianonly = cec.getValue("nricmalaysianonly");
                                    highestqualification = cec.getValue("highestqualification");
                                    securitylicensegrade = cec.getValue("securitylicensegrade");
                                    securitycoursesattended = cec.getValue("securitycoursesattended");
                                    datejoined = cec.getValue("datejoined");
                                    fulltimeorparttime = cec.getValue("fulltimeorparttime");
                                    lastestDate = date;
                                } else {
                                    if (date.after(lastestDate)) {
                                        name = cec.getValue("name");
                                        workpermitnumber = cec.getValue("workpermitnumber");
                                        passportnumber = cec.getValue("passportnumber");
                                        contactnumber = cec.getValue("contactnumber");
                                        permanentaddress = cec.getValue("permanentaddress");
                                        postaladdress = cec.getValue("postaladdress");
                                        dateofbirth = cec.getValue("dateofbirth");
                                        race = cec.getValue("race");
                                        emergencycontact = cec.getValue("emergencycontact");
                                        emergencycontactnumber = cec.getValue("emergencycontactnumber");
                                        fathername = cec.getValue("fathersname");
                                        mothername = cec.getValue("mothersname");
                                        nricmalaysianonly = cec.getValue("nricmalaysianonly");
                                        highestqualification = cec.getValue("highestqualification");
                                        securitylicensegrade = cec.getValue("securitylicensegrade");
                                        securitycoursesattended = cec.getValue("securitycoursesattended");
                                        datejoined = cec.getValue("datejoined");
                                        fulltimeorparttime = cec.getValue("fulltimeorparttime");
                                        lastestDate = date;
                                    }
                                }

                    %>
                    <%                                        }
                        //to ensure it dont take the NRIC of the another record
                        nricfin = request.getParameter("nricfin");
                        //TODHOD t = new TODHOD(val, val2, val3);
                    %>


                    <%
                        }
                    %>

                    <tr>
                        <th><center>Name:</center></th>
                <td><center><%=((name == null) ? "N/A" : name.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center>NRIC/FIN:</center></th>
                <td><center><%=((nricfin == null) ? "N/A" : nricfin.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center>Work Permit Number:</center></th>
                <td><center><%=((workpermitnumber == null) ? "N/A" : workpermitnumber.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center>Passport Number:</center></th>
                <td><center><%=((passportnumber == null) ? "N/A" : passportnumber.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center>Contact Number:</center></th>
                <td><center><%=((contactnumber == null) ? "N/A" : contactnumber.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Permanent Address</b></center></th>
                <td class="address"><center><%=((permanentaddress == null) ? "N/A" : permanentaddress.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Postal Address</b></center></th>
                <td class="address"><center><%=((postaladdress == null) ? "N/A" : postaladdress.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Date of Birth</b></center></th>
                <td class="address"><center><%=((dateofbirth == null) ? "N/A" : dateofbirth.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Race</b></center></th>
                <td class="address"><center><%=((race == null) ? "N/A" : race.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Emergency Contact</b></center></th>
                <td class="address"><center><%=((emergencycontact == null) ? "N/A" : emergencycontact.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Emergency Contact Number</b></center></th>
                <td class="address"><center><%=((emergencycontactnumber == null) ? "N/A" : emergencycontactnumber.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Father's Name</b></center></th>
                <td class="address"><center><%=((fathername == null) ? "N/A" : fathername.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Mother's Name</b></center></th>
                <td class="address"><center><%=((mothername == null) ? "N/A" : mothername.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>NRIC (Malaysian Only)</b></center></th>
                <td class="address"><center><%=((nricmalaysianonly == null) ? "N/A" : nricmalaysianonly.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Highest Qualification</b></center></th>
                <td class="address"><center><%=((highestqualification == null) ? "N/A" : highestqualification.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Security License Grade</b></center></th>
                <td class="address"><center><%=((securitylicensegrade == null) ? "N/A" : securitylicensegrade.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Security Courses Attended</b></center></th>
                <td class="address"><center><%=((securitycoursesattended == null) ? "N/A" : securitycoursesattended.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Date Joined</b></center></th>
                <td class="address"><center><%=((datejoined == null) ? "N/A" : datejoined.toUpperCase())%></center></td>
                </tr>
                <tr>
                    <th><center><b>Full Time or Part Time</b></center></th>
                <td class="address"><center><%=((fulltimeorparttime == null) ? "N/A" : fulltimeorparttime.toUpperCase())%></center></td>
                </tr>
                </tbody>
            </table>

        </div>
    </div>

    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <div class="backbuttonstyle">
        <a href="employeeparticulars.jsp" class="btn backbutton" role="button">Back</a>
    </div>
</body>
</html>
