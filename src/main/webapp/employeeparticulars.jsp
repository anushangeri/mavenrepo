
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="loginCSS.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.URL"%>
<%@include file="../java/net/javatutorial/to/TimeInTimeOut.java"%>
<%@include file="../java/net/javatutorial/to/TodHodDetails.java"%>
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

    <script>
        $(document).ready(function () {
            $('#escalation').DataTable();
        });
    </script>
</head>
<body>

    <%
        SpreadsheetService service = new SpreadsheetService("Employment Particulars");
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
            <label class="heading">Employee Particulars</label>
            <br>
            <b>How to use:</b> Click on Name for Employee Details.
            <br>
            <br>
            <div class="form-group">
                <fieldset>
                    <form action="" class="form-group" method="post">
                        <div class="table-responsive">
                            <div class="table-responsive">                            

                                <table id="escalation" class="table table-striped table-bordered everytable" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th><center><b>Name</b></center></th>
                                            <th><center><b>NRIC/FIN</b></center></th>
                                            <th><center><b>Work Permit Number</b></center></th>
                                            <th><center><b>Passport Number</b></center></th>
                                            <th><center><b>Contact Number</b></center></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%
                                            //Iterate over feed to get cell value
                                            for (ListEntry le : lf.getEntries()) {
                                                CustomElementCollection cec = le.getCustomElements();
                                                //Pass column name to access it's cell values
                                                String name = cec.getValue("name");
                                                String nricfin = cec.getValue("nricfin");
                                                String workpermitnumber = cec.getValue("workpermitnumber");
                                                String passportnumber = cec.getValue("passportnumber");
                                                String contactnumber = cec.getValue("contactnumber");
                                                        //TODHOD t = new TODHOD(val, val2, val3);
%>
                                        <tr>
                                            <td><a href="employeedetail.jsp?nricfin=<%=nricfin.trim()%>&name=<%=name%>"><center><%=name.toUpperCase()%></center></a></td>
                                            <td><center><%=nricfin%></center></td>
                                            <td><center><%=workpermitnumber%></center></td>
                                            <td><center><%=passportnumber%></center></td>
                                            <td><center><%=contactnumber%></center></td>
                                        </tr>

                                    <%
                                        }
                                    %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>            <!--END OF FORM ^^-->
                </fieldset>
            </div>
        </div>
    </div>

    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
