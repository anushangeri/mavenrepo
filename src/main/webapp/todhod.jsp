
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="to.TodHodDetails"%>
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

    <script>
        $(document).ready(function () {
            $('#escalation').DataTable();
        });
    </script>
</head>
<body>

    <%
        SpreadsheetService service = new SpreadsheetService("Form Responses 1");
        SpreadsheetService service2 = new SpreadsheetService("Sheet1");
        try {
            String sheetUrl
                    = //1TwURCxMStzOp_jFMisNFF01PswassfcM-J4Ma90o23A (test)
                    //1i_3_wI3ClPXE_nX4biN3oNrqxMgyswPuzklAx8mwivY  (real)
                    //1nuQlSMmThaj3YxBktjn771wvzZflDwmS746STcsUcJI (real v2)
                    "https://spreadsheets.google.com/feeds/list/1nuQlSMmThaj3YxBktjn771wvzZflDwmS746STcsUcJI/1/public/values";

            // Use this String as url
            URL url = new URL(sheetUrl);

            // Get Feed of Spreadsheet url
            ListFeed lf = service.getFeed(url, ListFeed.class);

            //for PLRD filter out work permit holders for day shift only
            String sheetUrl2
                    = "https://spreadsheets.google.com/feeds/list/1nWxKl4gPu2ycrQ3OTbONOYyrerpxsUfs-WBcieRukcw/1/public/values";

            // Use this String as url
            URL url2 = new URL(sheetUrl2);

            // Get Feed of Spreadsheet url
            ListFeed lf2 = service2.getFeed(url2, ListFeed.class);
    %>
    <div class="container body-content">
        <div class="page-header">
            <label class="heading">TOD/HOD</label>
            <br>
            <b>How to use:</b> Enter the date (mm/DD/yyyy) in the search box to view TOD/HOD for that date. Sort by shift.
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
                                            <th><center><b>Timestamp (mm/dd/yyyy 24HH:mm:ss)</b></center></th>
                                    <th><center><b>Security Officer Name</b></center></th>
                                    <th><center><b>NRIC/FIN</b></center></th>
                                    <th colspan="3"><center><b>TOD</b></center></th>
                                    <th colspan="3"><center><b>HOD</b></center></th>
                                    <th><center><b>Duty Site</b></center></th>
                                    <th><center><b>Stand by Remark</b></center></th>
                                    <th><center><b>Working Hours</b></center></th>
                                    </tr>
                                    <tr>
                                        <th colspan="3"></th>
                                        <th><center><b>Date (mm/dd/yyyy)</b></center></th>
                                    <th><center><b>Time</b></center></th>
                                    <th><center><b>Shift</b></center></th>
                                    <th><center><b>Date (mm/dd/yyyy)</b></center></th>
                                    <th><center><b>Time</b></center></th>
                                    <th><center><b>Shift</b></center></th>
                                    <th colspan="3"></th>
                                    </tr>

                                    </thead>
                                    <tbody>

                                        <%
                                            ArrayList<String> plrd2018Names = new ArrayList<String>();
                                            for (ListEntry le2 : lf2.getEntries()) {
                                                CustomElementCollection cec2 = le2.getCustomElements();

                                                String checkFIN = cec2.getValue("fin");
                                                plrd2018Names.add(checkFIN);
                                            }
                                            //Iterate over feed to get cell value
                                            ArrayList<TodHodDetails> allTodDetails = new ArrayList<TodHodDetails>();
                                            ArrayList<TodHodDetails> allHodDetails = new ArrayList<TodHodDetails>();
                                            for (ListEntry le : lf.getEntries()) {
                                                CustomElementCollection cec = le.getCustomElements();

                                                String enternricfin = cec.getValue("enternricfin").trim();
                                                String shift = cec.getValue("shift");
                                                String timestamp = cec.getValue("timestamp");;
                                                String securityofficername = cec.getValue("securityofficername");
                                                String date = cec.getValue("date");
                                                String time = cec.getValue("time");
                                                String areyoutodhod = cec.getValue("areyoutodorhod");
                                                String dutysite = cec.getValue("dutysite");
                                                String standbyremark = cec.getValue("standbyremark");
                                                
                                                
                                                //OC - On Course, MC - Medical Leave, AL - Annual Leave, HC - Hospital Leave
                                                if(dutysite != null && !dutysite.isEmpty() && !dutysite.toUpperCase().contains("OC") && !dutysite.toUpperCase().contains("AL")
                                                        && !dutysite.toUpperCase().contains("MC") && !dutysite.toUpperCase().contains("HC")
                                                        && !dutysite.toUpperCase().contains("RD") && !dutysite.toUpperCase().contains("PH")
                                                        && !dutysite.toUpperCase().contains("UL")){
                                                    
                                                    if (areyoutodhod.toUpperCase().contains("TOD")) {
                                                    TodHodDetails todDetails = new TodHodDetails(enternricfin, shift, timestamp,
                                                            securityofficername, date, time, areyoutodhod,
                                                            dutysite, standbyremark);
                                                    todDetails.setTimestamp(timestamp);
                                                    allTodDetails.add(todDetails);
                                                    }

                                                    if (areyoutodhod.toUpperCase().contains("HOD")) {
                                                        TodHodDetails hodDetails = new TodHodDetails(enternricfin, shift, timestamp,
                                                                securityofficername, date, time, areyoutodhod,
                                                                dutysite, standbyremark);
                                                        hodDetails.setTimestamp(timestamp);
                                                        allHodDetails.add(hodDetails);
                                                    }
                                                }
                                                

                                            }
                                            System.out.println("size of tod: " + allTodDetails.size());
                                            System.out.println("size of hod: " + allHodDetails.size());
                                            //loop through each allTodDetails
                                            //find the HOD pair using nric, site, shift and entry day must be on the day off or the next day
                                            if (!allTodDetails.isEmpty()) {
                                                SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
                                                SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss aa");
                                                for (TodHodDetails eachTodDetail : allTodDetails) {
//                                                    if(eachTodDetail.getAreyoutodhod() ==null
//                                                                    || eachTodDetail.getDateAsStr() == null
//                                                                    || eachTodDetail.getDutysite() == null
//                                                                    || eachTodDetail.getEnternricfin() == null
//                                                                    || eachTodDetail.getSecurityofficername()== null
//                                                                    || eachTodDetail.getShift() == null
//                                                                    || eachTodDetail.getTimeAsStr()== null
//                                                                    || eachTodDetail.getTimestamp() == null
//                                                                    || eachTodDetail.getTimestampAsStr() == null){
//                                                                System.out.println("THIS THE CAUSE tOD: " + eachTodDetail.toString());
//                                                            }
                                                    String enternricfin = eachTodDetail.getEnternricfin().trim();
                                                    String todShift = eachTodDetail.getShift();
                                                    String timestampAsStr = eachTodDetail.getTimestampAsStr();
                                                    Timestamp timestamp = eachTodDetail.getTimestamp();
                                                    String securityofficername = eachTodDetail.getSecurityofficername();
                                                    String todDateAsStr = eachTodDetail.getDateAsStr();
                                                    String todTimeAsStr = eachTodDetail.getTimeAsStr();
                                                    String areyoutodhod = eachTodDetail.getAreyoutodhod();
                                                    String dutysite = eachTodDetail.getDutysite();
                                                    
                                                    //doing 12 hour check
                                                    boolean isMoreThan12Hr = false;
                                                    Long workingHours = 0L;
                                                    
                                                    String hodDateAsStr = "";
                                                    String hodTimeAsStr = "";
                                                    String hodShift = "";
                                                    String standbyremark = "";

                                                    //getting date from timestamp for TOD
                                                    Date todDateFromTS = eachTodDetail.getDate();
                                                    String todDateFromTSAsStr = dateFormat.format(todDateFromTS);
                                                    Date todDateFromTSAsDate = dateFormat.parse(todDateFromTSAsStr);
                                                   
                                                    
                                                    //getting TOD time to check if HOD time is within 12 hours
                                                    Date todTimeFromTSAsDate = timeFormat.parse(eachTodDetail.getTimeAsStr());
                                                    
                                                    //to display tod and hod as a pair
                                                    if (allHodDetails.size() > 0) {
                                                        //find HOD pair
                                                        Calendar cal = Calendar.getInstance();
                                                        cal.setTime(todDateFromTS);
                                                        cal.add(Calendar.DATE, 1); //minus number would decrement the days
                                                        //Long milisecondsOneDay = Long.valueOf(1 * 24 * 60 * 60 * 1000);
                                                        //Timestamp timestampTheDayAfter = new Timestamp(timestamp.getTime() + milisecondsOneDay);
                                                        Date theDayAfter = cal.getTime();

                                                        String theDayAfterAsStr = dateFormat.format(theDayAfter);
                                                        Date theDayAfterAsDate = dateFormat.parse(theDayAfterAsStr);

                                                        for (Iterator<TodHodDetails> iterator = allHodDetails.iterator(); iterator.hasNext();) {
                                                            TodHodDetails eachHodDetail = iterator.next();
                                                            //getting the date from timestamp
                                                            Date hodDateFromTS = eachHodDetail.getDate();
                                                            String hodDateFromTSAsStr = dateFormat.format(hodDateFromTS);
                                                            Date hodDateFromTSAsDate = dateFormat.parse(hodDateFromTSAsStr);
                                                            //System.out.println(todDateFromTSAsDate + " " + hodDateFromTSAsDate + " " + theDayAfterAsDate);
//                                                            if(eachHodDetail.getAreyoutodhod() ==null
//                                                                    || eachHodDetail.getDateAsStr() == null
//                                                                    || eachHodDetail.getDutysite() == null
//                                                                    || eachHodDetail.getEnternricfin() == null
//                                                                    || eachHodDetail.getSecurityofficername()== null
//                                                                    || eachHodDetail.getShift() == null
//                                                                    || eachHodDetail.getTimeAsStr()== null
//                                                                    || eachHodDetail.getTimestamp() == null
//                                                                    || eachHodDetail.getTimestampAsStr() == null){
//                                                                System.out.println("THIS THE CAUSE HOD: " + eachHodDetail.toString());

                                                            if (enternricfin.equalsIgnoreCase(eachHodDetail.getEnternricfin())
                                                                    && todShift.equals(eachHodDetail.getShift())
                                                                    && dutysite.equals(eachHodDetail.getDutysite())
                                                                    && (hodDateFromTSAsDate.compareTo(theDayAfterAsDate) == 0
                                                                    || hodDateFromTSAsDate.compareTo(todDateFromTSAsDate) == 0)) {

                                                                Date st = timeFormat.parse(eachHodDetail.getTimeAsStr());
                                                                cal.setTime(st);
                                                                
                                                                //getting HOD time to check if HOD time is within 12 hours from TOD
                                                                Date hodTimeFromTSAsDate = timeFormat.parse(eachHodDetail.getTimeAsStr());
                                                                //if day shift, hod should be PM and date should be on the day off
                                                                if (cal.get(Calendar.AM_PM) == Calendar.PM && todShift.equals("Day") && hodDateFromTSAsDate.compareTo(todDateFromTSAsDate) == 0) {
                                                                    //System.out.println(hodDateFromTSAsDate + " Day " + todDateFromTSAsDate);
                                                                    hodDateAsStr = eachHodDetail.getDateAsStr();
                                                                    hodTimeAsStr = eachHodDetail.getTimeAsStr();
                                                                    hodShift = eachHodDetail.getShift();
                                                                    standbyremark = eachHodDetail.getStandbyremark();
                                                                    
                                                                    Long diff = hodTimeFromTSAsDate.getTime() - todTimeFromTSAsDate.getTime() - 5400000;
                                                                    workingHours = diff / (60 * 60 * 1000) % 24;
                                                                    if(workingHours > 12){
                                                                       isMoreThan12Hr = true; 
                                                                    }
                                                                    iterator.remove();
                                                                }
                                                                //if night shift, hod should be AM and date should be the day after
                                                                if (cal.get(Calendar.AM_PM) == Calendar.AM && todShift.equals("Night") && (hodDateFromTSAsDate.compareTo(theDayAfterAsDate) == 0)) {
                                                                    //System.out.println(hodDateFromTSAsDate + " Night " + todDateFromTSAsDate);
                                                                    hodDateAsStr = eachHodDetail.getDateAsStr();
                                                                    hodTimeAsStr = eachHodDetail.getTimeAsStr();
                                                                    hodShift = eachHodDetail.getShift();
                                                                    standbyremark = eachHodDetail.getStandbyremark();
                                                                    Long hr = (long) 24 * 60 * 60 * 1000;
                                                                    Long diff = (hr - todTimeFromTSAsDate.getTime()) + (hr + hodTimeFromTSAsDate.getTime())  - 5400000;
                                                                    workingHours = diff / (60 * 60 * 1000) % 24;
                                                                    
                                                                    if(workingHours > 12){
                                                                       isMoreThan12Hr = true; 
                                                                    }
                                                                    iterator.remove();
                                                                }
                                                            }
                                                        }
                                                    }
                                        %>
                                        <tr>
                                            <td><center><%=timestampAsStr%></center></td>
                                            <td><center><%=securityofficername.toUpperCase()%></center></td>
                                            <td><center><%=enternricfin%></center></td>
                                            <td><center><%=todDateAsStr%></center></td>
                                            <td><center><%=todTimeAsStr%></center></td>
                                            <td><center><%=todShift%></center></td>
                                            <td><center><%=((hodDateAsStr.isEmpty()) ? "Invalid Data" : hodDateAsStr)%></center></td>
                                            <td><center><%=((hodTimeAsStr.isEmpty()) ? "Invalid Data" : hodTimeAsStr)%></center></td>
                                            <td><center><%=((hodShift.isEmpty()) ? "Invalid Data" : hodShift)%></center></td>
                                            <td><center><%=dutysite%></center></td>
                                            <td><center><%=((standbyremark == null) ? "N/A" : standbyremark)%></center></td>
                                            <%
                                                if(isMoreThan12Hr){ %>
                                                    <td id="isMoreThan12Hr"><center><%=((workingHours == 0L) ? "0" : workingHours)%></center></td>
                                            <%        
                                                }
                                            %>
                                            <%
                                                if(!isMoreThan12Hr){ %>
                                                    <td id="isNotMoreThan12Hr"><center><%=((workingHours == 0L) ? "0" : workingHours)%></center></td>
                                            <%        
                                                }
                                            %>
                                        </tr>
                                    <%
                                            }
                                        }

//                                                    //if NRIC is in plrd2018Names only allow to display the day shift
//                                                    if(plrd2018Names.contains(enternricfin) && shift.equals("Day")){
//                                                          timestamp = cec.getValue("timestamp");
//                                                          securityofficername = cec.getValue("securityofficername");
//
//                                                          date = cec.getValue("date");
//                                                          time = cec.getValue("time");
//                                                          areyoutodhod = cec.getValue("areyoutodorhod");
//
//                                                          dutysite = cec.getValue("dutysite");
//                                                          standbyremark = cec.getValue("standbyremark");
//                                                    }
//                                                    //if NRIC is not in plrd2018Names then show only night shifts
//                                                    if(!plrd2018Names.contains(enternricfin) && shift.equals("Night")){
//                                                          timestamp = cec.getValue("timestamp");
//                                                          securityofficername = cec.getValue("securityofficername");
//
//                                                          date = cec.getValue("date");
//                                                          time = cec.getValue("time");
//                                                          areyoutodhod = cec.getValue("areyoutodorhod");
//
//                                                          dutysite = cec.getValue("dutysite");
//                                                          standbyremark = cec.getValue("standbyremark");
//                                                    }
//                                                     //if singaporean, just print
//                                                    if(Character.toString(enternricfin.charAt(0)).equals("S")){
//                                                        //Pass column name to access it's cell values
//                                                        timestamp = cec.getValue("timestamp");
//                                                        securityofficername = cec.getValue("securityofficername");
//
//                                                        date = cec.getValue("date");
//                                                        time = cec.getValue("time");
//                                                        areyoutodhod = cec.getValue("areyoutodorhod");
//
//                                                        dutysite = cec.getValue("dutysite");
//                                                        standbyremark = cec.getValue("standbyremark");
//                                                    }
                                        //TODHOD t = new TODHOD(val, val2, val3);

                                    %>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>            <!--END OF FORM ^^-->
                </fieldset>
            </div>
            <hr />
        </div>
    </div>

    <%            } catch (Exception e) {
            e.printStackTrace();
        }
    %>


</body>
</html>
