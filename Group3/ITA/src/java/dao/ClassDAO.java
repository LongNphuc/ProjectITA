package dao;

import connection._DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import model.Subject;
import model.Class;
import model.Semester;
import utils.Helper;

public class ClassDAO extends _DBContext {

    public ArrayList<Subject> getListSbuject() {
        ArrayList<Subject> listSubject = new ArrayList<>();
        try {
            String sql = "SELECT * FROM subject where isActive = 1;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listSubject.add(new Subject(rs.getInt("subjectId"),
                        rs.getString("subjectName"),
                        rs.getString("subjectCode"),
                        rs.getTimestamp("createDate"),
                        rs.getByte("isActive")));
            }
            return listSubject;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Class> getListClass() {
        ArrayList<Class> listClass = new ArrayList<>();
        try {
            String sql = "SELECT * FROM class c\n"
                    + "inner join subject s on s.subjectId = c.subjectId\n"
                    + "inner join semester se on se.semesterId = c.semesterId\n"
                    + " where s.isActive = 1;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listClass.add(new Class(rs.getInt("classId"),
                        rs.getInt("teacherId"),
                        new Subject(rs.getInt("subjectId"), rs.getString("subjectName"), rs.getString("subjectCode")),
                        new Semester(rs.getInt("semesterId"), rs.getString("semesterName")),
                        rs.getString("classCode"),
                        rs.getTimestamp("dateCreate"),
                        rs.getByte("isActive")));
            }
            return listClass;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int createClass(int teacherId, String classCode, int subjectId) {
        String sql = "insert into class (teacherId, classCode,subjectId,dateCreate, isActive,semesterId) values (?,?,?,?,0,?);";
        try ( PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setObject(1, teacherId);
            ps.setObject(2, classCode);
            ps.setObject(3, subjectId);
            ps.setObject(4, Helper.getCurrentTimestamp());
            ps.setObject(5, Semester.SEMESTER_FALL2023);
            int num = ps.executeUpdate();
            if (num > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public ArrayList<Semester> getListSemester() {
        ArrayList<Semester> list = new ArrayList<>();
        String sql = "select * from semester";
        try ( PreparedStatement ps = connection.prepareStatement(sql);) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Semester(rs.getInt("semesterId"), rs.getString("semesterName")));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateClassByClassId(String classId, String classCode, String subjectId, String semesterId, String isActive) {
        String sql = "update class\n"
                + "set classCode = ? , subjectId = ?, semesterId = ?, isActive = ? \n"
                + "where classId = ?";
        try(PreparedStatement ps = connection.prepareStatement(sql);){
            ps.setObject(1, classCode);
            ps.setObject(2, subjectId);
            ps.setObject(3, semesterId);
            ps.setByte(4, Byte.parseByte(isActive));
            ps.setObject(5, classId);
            ps.executeUpdate();
            return true;
        }catch(SQLException e) {
            e.printStackTrace();
        }return false;
    }

}
