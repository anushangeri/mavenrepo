/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package net.javatutorial.to;

/**
 *
 * @author jayan
 */
public class TimeInTimeOut {
    private String timeInDateAsStr;
    private String timeInTimeAsStr;
    private String timeOutDateAsStr;
    private String timeOutTimeAsStr;
    private String dutySite;

    public String getDutySite() {
        return dutySite;
    }

    public void setDutySite(String dutySite) {
        this.dutySite = dutySite;
    }
    
    public String getTimeInDateAsStr() {
        return timeInDateAsStr;
    }

    public void setTimeInDateAsStr(String timeInDateAsStr) {
        this.timeInDateAsStr = timeInDateAsStr;
    }

    public String getTimeInTimeAsStr() {
        return timeInTimeAsStr;
    }

    public void setTimeInTimeAsStr(String timeInTimeAsStr) {
        this.timeInTimeAsStr = timeInTimeAsStr;
    }

    public String getTimeOutDateAsStr() {
        return timeOutDateAsStr;
    }

    public void setTimeOutDateAsStr(String timeOutDateAsStr) {
        this.timeOutDateAsStr = timeOutDateAsStr;
    }

    public String getTimeOutTimeAsStr() {
        return timeOutTimeAsStr;
    }

    public void setTimeOutTimeAsStr(String timeOutTimeAsStr) {
        this.timeOutTimeAsStr = timeOutTimeAsStr;
    }

    @Override
    public String toString() {
        return "TimeInTimeOut{" + "timeInDateAsStr=" + timeInDateAsStr + ", timeInTimeAsStr=" + timeInTimeAsStr + ", timeOutDateAsStr=" + timeOutDateAsStr + ", timeOutTimeAsStr=" + timeOutTimeAsStr + ", dutySite=" + dutySite + '}';
    }

    
}
