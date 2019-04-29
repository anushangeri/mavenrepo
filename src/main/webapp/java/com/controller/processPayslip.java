package com.controller;

import com.google.gdata.client.spreadsheet.SpreadsheetService;
import com.google.gdata.data.spreadsheet.CustomElementCollection;
import com.google.gdata.data.spreadsheet.ListEntry;
import com.google.gdata.data.spreadsheet.ListFeed;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import static java.util.Calendar.YEAR;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.stream.StreamSupport;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import to.TimeInTimeOut;
import to.TodHodDetails;


public class processPayslip extends HttpServlet {

    /**
     * generate payslip
     *
     * <p>
     * display days of month - check if officer work that month if not RD
     * <p>
     * calculate details put in arraylist
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nricfin = request.getParameter("nricfin");
        String payslipmonth = request.getParameter("payslipmonth");
        String avdpay = request.getParameter("avdpayment");
        int advpayment = 0;
        if(!avdpay.isEmpty()){
            advpayment = Integer.parseInt(avdpay);
        }
        String acctnumber = request.getParameter("acctnumber");
        
        nricfin = nricfin.trim();
        payslipmonth = payslipmonth.trim();

        DecimalFormat dff = new DecimalFormat("###.##");
        int numberDaysWorked = 0;
        int numberPHWorked = 0;
        int numberRDWorked = 0;
        int numberULWorked = 0;
        
        HashMap<String, Object> responseObj = new HashMap<String, Object>();
        SpreadsheetService service = new SpreadsheetService("Form Responses 1");
        try {
            //from tod/hod details
            //S2061907D
            String sheetUrl
                    = //1TwURCxMStzOp_jFMisNFF01PswassfcM-J4Ma90o23A (test)
                    //1i_3_wI3ClPXE_nX4biN3oNrqxMgyswPuzklAx8mwivY  (real)
                    //1nuQlSMmThaj3YxBktjn771wvzZflDwmS746STcsUcJI (real v2)
                    "https://spreadsheets.google.com/feeds/list/1nuQlSMmThaj3YxBktjn771wvzZflDwmS746STcsUcJI/1/public/values";

            // Use this String as url
            URL url = new URL(sheetUrl);

            // Get Feed of Spreadsheet url
            ListFeed lf = service.getFeed(url, ListFeed.class);

            //from key employment terms
            String sheetUrlPayslip
                    //1c3tzhHMGUZz1laAiHEuxoGtHnnY_KseEUbDOE38f-NI (test)
                    // 1JlJZAhOUrcBoQ-e1lbZsIBIDvcsrU2-tfB2dUQFrMP4 (real)
                    = "https://spreadsheets.google.com/feeds/list/1hrKUqHMoGR1rvdZ4ZquvjS14t9-5VBpf4RF2cepdj-Y/1/public/values";

            // Use this String as url
            URL urlPayslip = new URL(sheetUrlPayslip);

            // Get Feed of Spreadsheet url
            ListFeed lfPayslip = service.getFeed(urlPayslip, ListFeed.class);
            String name = "";
            double employeeCPFRate = 0;
            double employerCPFRate = 0;
            int basicsalarymonth = 0;
            double OTRate = 0;
            String breakHr = "0 hour";
            double shiftOTHr = 0;
            String dob = "";
            int annualLeavetaken = 0;
            int annualLeaveBal = 0;
            int compasionateleave = 0;
            int medicalLeavetaken = 0;
            int medicalLeaveBal = 0;

            //get payslip details
            for (ListEntry le : lfPayslip.getEntries()) {
                CustomElementCollection cec = le.getCustomElements();
                String enternricfin = cec.getValue("employeenricfin");
                if(enternricfin != null){
                    if(enternricfin.toUpperCase().equals(nricfin.toUpperCase())){
                        name = cec.getValue("employeename");
                        employeeCPFRate = Double.parseDouble(cec.getValue("cpfemployee")) / 100;
                        employerCPFRate = Double.parseDouble(cec.getValue("cpfemployer")) / 100;
                        basicsalarymonth = Integer.parseInt(cec.getValue("basicsalary"));
                        OTRate = 1.5; //Double.parseDouble(cec.getValue("otrate"));
                        String fixedovertime = cec.getValue("fixedovertime");
                        if(fixedovertime != null && !fixedovertime.isEmpty() && !fixedovertime.equals("NA")){
                            shiftOTHr = Double.parseDouble(cec.getValue("fixedovertime"));
                        }
                        String dateofbirth = cec.getValue("dateofbirth");
                        if(dateofbirth != null && !dateofbirth.isEmpty()){
                            dob = cec.getValue("dateofbirth");
                        }
                        String unpaidresthours = cec.getValue("unpaidresthours");
                        if(!unpaidresthours.isEmpty() && unpaidresthours != null){
                            breakHr = cec.getValue("unpaidresthours");
                        }
                        String annualleavetaken = cec.getValue("annualleavetaken");
                        if(annualleavetaken != null && !annualleavetaken.isEmpty()){
                            annualLeavetaken = Integer.parseInt(cec.getValue("annualleavetaken"));
                        }
                        String annualleavebal = cec.getValue("annualleavebal");
                        if( annualleavebal != null && !annualleavebal.isEmpty()){
                            annualLeaveBal = Integer.parseInt(cec.getValue("annualleavebal"));
                        }
                        String compassionateleave = cec.getValue("compassionateleave");
                        if(compassionateleave != null && !compassionateleave.isEmpty()){
                            compasionateleave = Integer.parseInt(cec.getValue("compassionateleave"));
                        }
                        String mctaken = cec.getValue("mctaken");
                        if(mctaken != null  && !mctaken.isEmpty()){
                            medicalLeavetaken = Integer.parseInt(cec.getValue("mctaken"));
                        }
                        medicalLeaveBal = 14 - medicalLeavetaken;
                        
                    }
                }
            }
            //Iterate over feed to get cell value
            ArrayList<TodHodDetails> todNRIC = new ArrayList<TodHodDetails>();
            ArrayList<TodHodDetails> hodNRIC = new ArrayList<TodHodDetails>();
            ArrayList<TimeInTimeOut> timeInTimeOutPairs = new ArrayList<TimeInTimeOut>();
            ArrayList<TimeInTimeOut> timeInTimeOutPayslipDisplay = new ArrayList<TimeInTimeOut>();
            
            for (ListEntry le : lf.getEntries()) {
                CustomElementCollection cec = le.getCustomElements();

                String enternricfin = cec.getValue("enternricfin");
                String shift = cec.getValue("shift");
                String timestamp = cec.getValue("timestamp");;
                String securityofficername = cec.getValue("securityofficername");
                String date = cec.getValue("date");
                String time = cec.getValue("time");
                String areyoutodhod = cec.getValue("areyoutodorhod");
                String dutysite = cec.getValue("dutysite");
                String standbyremark = cec.getValue("standbyremark");
                
                if(dutysite != null && !dutysite.isEmpty() ){
                    if (areyoutodhod.toUpperCase().contains("TOD") && enternricfin.toUpperCase().equals(nricfin.toUpperCase())) {
                        TodHodDetails todDetails = new TodHodDetails(enternricfin, shift, timestamp,
                                securityofficername, date, time, areyoutodhod,
                                dutysite, standbyremark);
                        //G8183765T
                        todDetails.setTimestamp(timestamp);
                        todNRIC.add(todDetails);
                    }
                    if (areyoutodhod.toUpperCase().contains("HOD") && enternricfin.toUpperCase().equals(nricfin.toUpperCase())) {
                        TodHodDetails hodDetails = new TodHodDetails(enternricfin, shift, timestamp,
                                securityofficername, date, time, areyoutodhod,
                                dutysite, standbyremark);
                        //G8183765T
                        hodDetails.setTimestamp(timestamp);
                        hodNRIC.add(hodDetails);
                    }
                }
                   
                
            }
            Iterator<TodHodDetails> todNRICToCompare = todNRIC.iterator(); 
            ArrayList<TodHodDetails> todNRIC2 = (ArrayList<TodHodDetails>) todNRIC.clone();
            ArrayList<TodHodDetails> todNRICFinal = new ArrayList<TodHodDetails>();
            int wentIn = 0;
            Date lastestDate = null;

            for (TodHodDetails todDetails: todNRIC2) {
                String checkForDuplicateRecords = todDetails.getTimestampAsStr();
                SimpleDateFormat sf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
                Date date = sf.parse(checkForDuplicateRecords);
                wentIn = 0;
                TodHodDetails todNRICToAddToFinal  = null;
                if (todNRICToCompare.hasNext() == false) {
                    todNRICToCompare = todNRIC.listIterator();
                }
                while (todNRICToCompare.hasNext()) {
                    TodHodDetails todNRICCompared = todNRICToCompare.next();
                    if(todNRICCompared.getDateAsStr().equals(todDetails.getDateAsStr())){
                            if(wentIn == 0 && lastestDate == null){
                                todNRICToAddToFinal = todDetails;
                                lastestDate = date;
                            }
                            if(wentIn == 0 && date.after(lastestDate)){
                                todNRICToAddToFinal = todDetails;
                                lastestDate = date;
                            }
                            todNRICToCompare.remove();
                            wentIn++;
                    }
                }
                lastestDate = null;
                if(todNRICToAddToFinal != null){
                    todNRICFinal.add(todNRICToAddToFinal);
                }
                
            }
            //tod hod pair
            if (!todNRICFinal.isEmpty()) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
                SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss aa");
                for (TodHodDetails eachTodDetail : todNRICFinal) {
                    String enternricfin = eachTodDetail.getEnternricfin();
                    String todShift = eachTodDetail.getShift();
                    String todDateAsStr = eachTodDetail.getDateAsStr();
                    String todTimeAsStr = eachTodDetail.getTimeAsStr();
                    String dutysite = eachTodDetail.getDutysite();

                    String hodDateAsStr = "";
                    String hodTimeAsStr = "";

                    //getting date from timestamp for TOD
                    Date todDateFromTS = eachTodDetail.getDate();
                    String todDateFromTSAsStr = dateFormat.format(todDateFromTS);
                    Date todDateFromTSAsDate = dateFormat.parse(todDateFromTSAsStr);
                    
                    //for each TOD find the HOD
                    TimeInTimeOut timeInTimeOutPair = new TimeInTimeOut();
                    timeInTimeOutPair.setTimeInDateAsStr(todDateAsStr);
                    timeInTimeOutPair.setTimeInTimeAsStr(todTimeAsStr);
                    timeInTimeOutPair.setDutySite(dutysite);
                    //to display tod and hod as a pair
                    if (hodNRIC.size() > 0) {
                        //find HOD pair
                        Calendar cal = Calendar.getInstance();
                        cal.setTime(todDateFromTS);
                        cal.add(Calendar.DATE, 1); //minus number would decrement the days
                        //Long milisecondsOneDay = Long.valueOf(1 * 24 * 60 * 60 * 1000);
                        //Timestamp timestampTheDayAfter = new Timestamp(timestamp.getTime() + milisecondsOneDay);
                        Date theDayAfter = cal.getTime();

                        String theDayAfterAsStr = dateFormat.format(theDayAfter);
                        Date theDayAfterAsDate = dateFormat.parse(theDayAfterAsStr);

                        for (Iterator<TodHodDetails> iterator = hodNRIC.iterator(); iterator.hasNext();) {
                            TodHodDetails eachHodDetail = iterator.next();
                            //getting the date from timestamp
                            Date hodDateFromTS = eachHodDetail.getDate();
                            String hodDateFromTSAsStr = dateFormat.format(hodDateFromTS);
                            Date hodDateFromTSAsDate = dateFormat.parse(hodDateFromTSAsStr);
                            if (enternricfin.equalsIgnoreCase(eachHodDetail.getEnternricfin())
                                    && todShift.equals(eachHodDetail.getShift())
                                    && dutysite.equals(eachHodDetail.getDutysite())
                                    && (hodDateFromTSAsDate.compareTo(theDayAfterAsDate) == 0
                                    || hodDateFromTSAsDate.compareTo(todDateFromTSAsDate) == 0)) {
                                
                                Date st = timeFormat.parse(eachHodDetail.getTimeAsStr());
                                cal.setTime(st);
                                //if day shift, hod should be PM and date should be on the day off
                                if (cal.get(Calendar.AM_PM) == Calendar.PM && todShift.equals("Day") && hodDateFromTSAsDate.compareTo(todDateFromTSAsDate) == 0) {
                                    hodDateAsStr = eachHodDetail.getDateAsStr();
                                    hodTimeAsStr = eachHodDetail.getTimeAsStr();
                                    timeInTimeOutPair.setTimeOutDateAsStr(hodDateAsStr);
                                    timeInTimeOutPair.setTimeOutTimeAsStr(hodTimeAsStr);
                                    iterator.remove();
                                }
                                //if night shift, hod should be AM and date should be the day after
                                if (cal.get(Calendar.AM_PM) == Calendar.AM && todShift.equals("Night") && (hodDateFromTSAsDate.compareTo(theDayAfterAsDate) == 0)) {
                                    hodDateAsStr = eachHodDetail.getDateAsStr();
                                    hodTimeAsStr = eachHodDetail.getTimeAsStr();
                                    timeInTimeOutPair.setTimeOutDateAsStr(hodDateAsStr);
                                    timeInTimeOutPair.setTimeOutTimeAsStr(hodTimeAsStr);
                                    iterator.remove();
                                }
                            }
                        }
                    }
                    timeInTimeOutPairs.add(timeInTimeOutPair);
                }
            }
                int month = Integer.parseInt(payslipmonth.substring(5, 7)) - 1;
                Calendar cal = Calendar.getInstance();
                cal.set(Calendar.MONTH, month);
                cal.set(Calendar.DAY_OF_MONTH, 1);
                int maxDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
                SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
                String paylipMonth = new SimpleDateFormat("MMM").format(cal.getTime());
                for (int i = 1; i <= maxDay; i++) {
                    //check if officer work on particular day
                    //getting date from eachTodDetail for TOD
                    //System.out.print(", " + df.format(cal.getTime()));
                    for (TodHodDetails eachTodDetail : todNRICFinal) {
                        Date todDateFromTS = eachTodDetail.getDate();
                        String todDateFromTSAsStr = df.format(todDateFromTS);
                        Date todDateFromTSAsDate = df.parse(todDateFromTSAsStr);
                        String compareToAsStr = df.format(cal.getTime());
                        Date compareToAsDate = df.parse(compareToAsStr);
                        String dutysite = eachTodDetail.getDutysite();
                        if (todDateFromTSAsDate.compareTo(compareToAsDate) == 0 && !dutysite.toUpperCase().contains("OC") && !dutysite.toUpperCase().contains("AL")
                                                        && !dutysite.toUpperCase().contains("MC") && !dutysite.toUpperCase().contains("HC")
                                                        && !dutysite.toUpperCase().contains("RD") && !dutysite.toUpperCase().contains("REST DAY")  && !dutysite.toUpperCase().contains("PH")
                                                        && !dutysite.toUpperCase().contains("UL")) {
                            numberDaysWorked++;
                        }
                        //for PH
                        if (todDateFromTSAsDate.compareTo(compareToAsDate) == 0 && dutysite.toUpperCase().contains("PH") ) {
                            numberPHWorked++;
                        }
                        //for UL
                        if (dutysite.toUpperCase().contains("UL") ) {
                            numberULWorked++;
                        }
                    }
                    String compareToAsStrr = df.format(cal.getTime());
                    //prepare the time in time out display
                    boolean ifLoop = false;
                    for (TimeInTimeOut eachTOTI : timeInTimeOutPairs) {
                        String todDateFromTSAsStr = eachTOTI.getTimeInDateAsStr();
                        Date todDateFromTSAsDate = df.parse(todDateFromTSAsStr);
                        String compareToAsStr = df.format(cal.getTime());
                        Date compareToAsDate = df.parse(compareToAsStr);
                        String dutysite = eachTOTI.getDutySite();
                        //has record - put in timeInTimeOutPayslipDisplay
                        if (todDateFromTSAsDate.compareTo(compareToAsDate) == 0) {
                            timeInTimeOutPayslipDisplay.add(eachTOTI);
                            ifLoop = true;
                        }
                    }
                    if(!ifLoop){
                        TimeInTimeOut timeInTimeOutPair = new TimeInTimeOut();
                        timeInTimeOutPair.setTimeInDateAsStr(compareToAsStrr);
                        timeInTimeOutPair.setTimeInTimeAsStr("8:00:00 AM");
                        timeInTimeOutPair.setDutySite("NA");
                        timeInTimeOutPayslipDisplay.add(timeInTimeOutPair);
                    }
                    cal.set(Calendar.DAY_OF_MONTH, i + 1);
                }
            //for age
            Date dobAsDate = df.parse(dob);
            Calendar caldob = Calendar.getInstance();
            caldob.setTime(dobAsDate);
            int age = cal.get(YEAR) - caldob.get(YEAR);
            responseObj.put("name", name);  
            responseObj.put("nric", nricfin);
            responseObj.put("age", age);
            responseObj.put("annualLeavetaken", annualLeavetaken);            
            responseObj.put("annualLeaveBal", annualLeaveBal);            
            responseObj.put("compasionateleave", compasionateleave);
            responseObj.put("medicalLeavetaken", medicalLeavetaken);            
            responseObj.put("medicalLeaveBal", medicalLeaveBal);  
            responseObj.put("breakHr", breakHr);  
            responseObj.put("avdpayment", advpayment);
            responseObj.put("acctnumber", acctnumber);
            responseObj.put("paylipMonth", paylipMonth);
            
            responseObj.put("numberDaysWorked", numberDaysWorked);
            responseObj.put("numberPHWorked", numberPHWorked);
            responseObj.put("numberULWorked", numberULWorked);
            responseObj.put("timeInTimeOutPayslipDisplay", timeInTimeOutPayslipDisplay);
            
                
            double basicsalaryhour = (basicsalarymonth * 12.00)/(44.00000*52.00);
            double basicsalaryday = ((basicsalarymonth * 12.000000)/(44.000*52.00000)) * 7.00000;
            
            responseObj.put("basicsalarymonth", dff.format(basicsalarymonth));
            responseObj.put("basicsalaryday", dff.format(basicsalaryday));
            responseObj.put("basicsalaryhour", dff.format(basicsalaryhour));
            
            double OTRateFinal = OTRate * basicsalaryhour;
            responseObj.put("OTRateFinal", dff.format(OTRateFinal));
            
            double shiftOvertime = OTRateFinal * shiftOTHr * numberDaysWorked;
            responseObj.put("shiftOvertime", dff.format(shiftOvertime));
            
            double lessUnworkedDays = numberULWorked * basicsalaryday;
            responseObj.put("lessUnworkedDays", lessUnworkedDays);
            
            double publicHolidays = basicsalaryday * numberPHWorked;
            responseObj.put("publicHolidays", publicHolidays);
            
            double grossPay = basicsalarymonth + shiftOvertime - lessUnworkedDays + publicHolidays;
            responseObj.put("grossPay", dff.format(grossPay));
            
            double employeeCPF = employeeCPFRate * grossPay;
            responseObj.put("employeeCPF", dff.format(employeeCPF));
            
            double employerCPF = employerCPFRate * grossPay;
            responseObj.put("employerCPF", dff.format(employerCPF));
            
            double totalCPF = employerCPF + employeeCPF;
            responseObj.put("totalCPF", dff.format(totalCPF));
            
            double costK11 = grossPay + employerCPF;
            responseObj.put("costK11", dff.format(costK11));
            
            double takeHomePay = grossPay - employeeCPF;
            responseObj.put("takeHomePay", dff.format(takeHomePay));
            
            double balSal = takeHomePay - advpayment;
            responseObj.put("balSal", dff.format(balSal));
            
            double balSalFinal = balSal + advpayment;
            responseObj.put("balSalFinal", dff.format(balSalFinal));
            
            request.setAttribute("responseObj", responseObj);
            RequestDispatcher rd = request.getRequestDispatcher("displayPayslip.jsp");
            rd.forward(request, response);
            
            }catch (Exception e) {
                e.printStackTrace();
            }
        
        
//        if (username.equals("admin")) {
//            if (password.equals("blackyellow")) {
//                HttpSession session = request.getSession();
//                session.setAttribute("authenticatedUser", username);
//                response.sendRedirect("admin");
//            } else {
//                request.setAttribute("msg", "Invalid Username/Password");
//                RequestDispatcher rd = request.getRequestDispatcher("LoginUI.jsp");
//                rd.forward(request, response);
//            }
//        }
            }
        }
