package model;

import java.sql.Timestamp;


public class Class {
    private int classId, teacherId;
    private Semester semester;
    private Subject subject;
    private String classCode;
    private Timestamp dateCreate;
    private byte isActive;
    
    public Class() {
    }

    public Class(int classId, int teacherId, Subject subject,Semester semester ,String classCode, Timestamp dateCreate, byte isActive) {
        this.classId = classId;
        this.teacherId = teacherId;
        this.subject = subject;
        this.classCode = classCode;
        this.dateCreate = dateCreate;
        this.isActive = isActive;
        this.semester = semester;
    }
    
    public Class(int classId, Semester semester, Subject subject, String classCode, byte isActive) {
        this.classId = classId;
        this.semester = semester;
        this.subject = subject;
        this.classCode = classCode;
        this.isActive = isActive;
    }
    
    

    public Semester getSemester() {
        return semester;
    }
    
    public int getClassId() {
        return classId;
    }

    public int getTeacherId() {
        return teacherId;
    }

    public Subject getSubject() {
        return subject;
    }

    public String getClassCode() {
        return classCode;
    }

    public Timestamp getDateCreate() {
        return dateCreate;
    }

    public byte getIsActive() {
        return isActive;
    }
    
    
    
   
}
