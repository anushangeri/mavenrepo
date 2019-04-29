/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package src.main.webapp.java.com.to;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author jayan
 */
public class TodHodDetails {
    private String enternricfin;
    private String shift;
    private String timestampAsStr;
    private Timestamp timestamp;
    private String securityofficername;
    private String dateAsStr;
    private Date date;
    private String timeAsStr;
    private String areyoutodhod;
    private String dutysite;
    private String standbyremark;

    public TodHodDetails(String enternricfin, String shift, String timestampAsStr, String securityofficername, String dateAsStr, String timeAsStr, String areyoutodhod, String dutysite, String standbyremark) {
        this.enternricfin = enternricfin;
        this.shift = shift;
        this.timestampAsStr = timestampAsStr;
        this.securityofficername = securityofficername;
        this.dateAsStr = dateAsStr;
        this.timeAsStr = timeAsStr;
        this.areyoutodhod = areyoutodhod;
        this.dutysite = dutysite;
        this.standbyremark = standbyremark;
    }

    
    public String getEnternricfin() {
        return enternricfin;
    }

    public void setEnternricfin(String enternricfin) {
        this.enternricfin = enternricfin;
    }

    public String getShift() {
        return shift;
    }

    public void setShift(String shift) {
        this.shift = shift;
    }

    public String getTimestampAsStr() {
        return timestampAsStr;
    }

    public void setTimestampAsStr(String timestampAsStr) {
        this.timestampAsStr = timestampAsStr;
    }

    public Timestamp getTimestamp() {
        Timestamp timestamp = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
            Date parsedDate = dateFormat.parse(timestampAsStr);
            timestamp = new java.sql.Timestamp(parsedDate.getTime());
        } catch(Exception e) { //this generic but you can control another types of exception
            System.out.println("SHANGERI TIMESTAMP CONVERSION FAILED IN TO.TODHODDETAILS: " + e);
        }
        return timestamp;
    }

    public void setTimestamp(String timestampAsStr) {
         try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
            Date parsedDate = dateFormat.parse(timestampAsStr);
            Timestamp timestampp = new java.sql.Timestamp(parsedDate.getTime());
            this.timestamp = timestampp;
        } catch(Exception e) { //this generic but you can control another types of exception
            System.out.println("SHANGERI TIMESTAMP CONVERSION FAILED IN TO.TODHODDETAILS: " + e);
        }
    }

    public String getSecurityofficername() {
        return securityofficername;
    }

    public void setSecurityofficername(String securityofficername) {
        this.securityofficername = securityofficername;
    }

    public String getDateAsStr() {
        return dateAsStr;
    }

    public void setDateAsStr(String dateAsStr) {
        this.dateAsStr = dateAsStr;
    }

    public Date getDate() {
        Date date = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            date = dateFormat.parse(dateAsStr);
        } catch(Exception e) { //this generic but you can control another types of exception
            System.out.println("SHANGERI DATE CONVERSION FAILED IN TO.TODHODDETAILS: " + e);
        }
        return date;
    }

    public void setDate(String dateAsStr) {
        Date date = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
            date = dateFormat.parse(dateAsStr);
            this.date = date;
        } catch(Exception e) { //this generic but you can control another types of exception
            System.out.println("SHANGERI DATE CONVERSION FAILED IN TO.TODHODDETAILS: " + e);
        }
        
    }

    public String getTimeAsStr() {
        return timeAsStr;
    }

    public void setTimeAsStr(String timeAsStr) {
        this.timeAsStr = timeAsStr;
    }

    public String getAreyoutodhod() {
        return areyoutodhod;
    }

    public void setAreyoutodhod(String areyoutodhod) {
        this.areyoutodhod = areyoutodhod;
    }

    public String getDutysite() {
        return dutysite;
    }

    public void setDutysite(String dutysite) {
        this.dutysite = dutysite;
    }

    public String getStandbyremark() {
        return standbyremark;
    }

    public void setStandbyremark(String standbyremark) {
        this.standbyremark = standbyremark;
    }

    @Override
    public String toString() {
        return "TodHodDetails{" + "enternricfin=" + enternricfin + ", shift=" + shift + ", timestampAsStr=" + timestampAsStr + ", timestamp=" + timestamp + ", securityofficername=" + securityofficername + ", dateAsStr=" + dateAsStr + ", date=" + date + ", timeAsStr=" + timeAsStr + ", areyoutodhod=" + areyoutodhod + ", dutysite=" + dutysite + ", standbyremark=" + standbyremark + '}';
    }
            
    
}
