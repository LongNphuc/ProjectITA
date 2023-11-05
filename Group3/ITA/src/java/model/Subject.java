
package model;

import java.sql.Timestamp;


public class Subject {
    private int subjectId;
    private String subjectName, subjectCode;
    private Timestamp creatDate;
    private byte isActive;

    public Subject(int subjectId, String subjectName, String subjectCode) {
        this.subjectId = subjectId;
        this.subjectName = subjectName;
        this.subjectCode = subjectCode;
    }

    public Subject(int subjectId, String subjectName, String subjectCode, Timestamp creatDate, byte isActive) {
        this.subjectId = subjectId;
        this.subjectName = subjectName;
        this.subjectCode = subjectCode;
        this.creatDate = creatDate;
        this.isActive = isActive;
    }

    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getSubjectCode() {
        return subjectCode;
    }

    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
    }

    public Timestamp getCreatDate() {
        return creatDate;
    }

    public void setCreatDate(Timestamp creatDate) {
        this.creatDate = creatDate;
    }

    public byte getIsActive() {
        return isActive;
    }

    public void setIsActive(byte isActive) {
        this.isActive = isActive;
    }
    
    
}
