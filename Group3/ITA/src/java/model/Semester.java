
package model;


public class Semester {
    public static int SEMESTER_FALL2023 = 1;
    
    private int semesterId;
    private String semesterName;

    public Semester() {
    }

    public Semester(int semesterId, String semesterName) {
        this.semesterId = semesterId;
        this.semesterName = semesterName;
    }

    public int getSemesterId() {
        return semesterId;
    }

    public void setSemesterId(int semesterId) {
        this.semesterId = semesterId;
    }

    public String getSemesterName() {
        return semesterName;
    }

    public void setSemesterName(String semesterName) {
        this.semesterName = semesterName;
    }
    
    
}
