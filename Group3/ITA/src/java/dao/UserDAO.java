package dao;

import connection._DBContext;
import dto.UserGoogleDTO;
import dto.UserServiceRegisterDTO;
import java.sql.Connection;

import model.User;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import model.Role;
import model.Semester;
import utils.Helper;

public class UserDAO extends _DBContext {

    public static String LOGIN_USERNAME = "accountName", LOGIN_EMAIL = "email";

    public int createUser(UserServiceRegisterDTO user) {
        boolean check = (user.getRoleId() == Role.ROLE_STUDENT);
        String sql = "insert into account (mobile, password, roleId, accountName,"
                + " isActived,createDate " + ((check) ? ", semesterId)"
                + " values (?, ?, ?, ?,1,?,?); " : ") values (?, ?, ?, ?,1,?)");
        try ( Connection con = new _DBContext().getConnection();
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setObject(1, user.getMobile());
            ps.setObject(2, user.getPassword());
            ps.setObject(3, user.getRoleId());
            ps.setObject(4, user.getAccountName());
            ps.setTimestamp(5, Helper.getCurrentTimestamp());
            if (check) {
                ps.setObject(6, Semester.SEMESTER_FALL2023);
            }
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

    public static int getRoleIdByRoleName(String roleName) {
        try {
            String sqlQuery = "select *\n"
                    + "from role\n"
                    + "where roleName = ?";
            PreparedStatement stm = new _DBContext().getConnection().prepareStatement(sqlQuery);
            stm.setString(1, roleName);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public int addUserGoogle(UserServiceRegisterDTO user) {
        boolean check = (user.getRoleId() == Role.ROLE_STUDENT);
        String sql = "insert into account (email,password, oauthId, roleId,"
                + "accountName,fullName, imgPath, isActived, createDate  "
                + ((check) ? ", semesterId) values (?, ?, ?, ?,?,?,?,1,?,?) "
                : ") values (?, ?, ?, ?,?,?,?,1,?)");
        try ( Connection con = new _DBContext().getConnection();  PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setObject(1, user.getEmail());
            ps.setObject(2, user.getPassword());
            ps.setObject(3, user.getOauthId());
            ps.setObject(4, user.getRoleId());
            ps.setObject(5, user.getAccountName());
            ps.setObject(6, user.getFullName());
            ps.setObject(7, user.getImage());
            ps.setObject(8, Helper.getCurrentTimestamp());
            if(check){
                ps.setObject(9, Semester.SEMESTER_FALL2023);
            }
            int num = ps.executeUpdate();
            if (num > 0) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1); 
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }return -1;
    }
    
    public boolean isUserExist(String field, String key, String oauthId) {
        try {
            String sqlQuery = "SELECT * FROM account a \n"
                    + "WHERE a." + field + " = ?\n and a.oauthId = ? and a.isActived =1";
            PreparedStatement stm = connection.prepareStatement(sqlQuery);
            stm.setString(1, key);
            stm.setString(2, oauthId);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public ArrayList<User> getUserList(boolean flag) {//true = student; false = teacher;
        ArrayList<User> listUsers = new ArrayList<>();
        try {
            String strSQL = "SELECT u.*, r.RoleName " + ((flag) ? ",s.semesterName" : " ") + " FROM account u\n"
                    + " join role r on r.RoleId = u.RoleId\n"
                    + ((flag) ? " join semester s on s.semesterId = u.semesterId" : "")
                    + " where u.isActived = 1";
            PreparedStatement stm = connection.prepareStatement(strSQL);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                if (!flag) {//teacher
                    User u = new User(
                            rs.getInt("accountId"),
                            rs.getString("accountName"),
                            rs.getString("mobile"),
                            rs.getString("password"),
                            rs.getString("oauthId"),
                            rs.getString("email"),
                            new Role(rs.getInt("roleId"),
                                    rs.getString("roleName")),
                            rs.getString("fullName"),
                            rs.getString("imgPath"),
                            rs.getByte("isActived"),
                            rs.getTimestamp("createDate")
                    );
                    listUsers.add(u);
                } else {//student
                    User u = new User(
                            rs.getInt("accountId"),
                            rs.getString("accountName"),
                            rs.getString("mobile"),
                            rs.getString("password"),
                            rs.getString("oauthId"),
                            rs.getString("email"),
                            new Role(rs.getInt("roleId"),
                                    rs.getString("roleName")),
                            rs.getString("fullName"),
                            new Semester(rs.getInt("semesterId"), rs.getString("semesterName")),
                            rs.getString("imgPath"),
                            rs.getByte("isActived"),
                            rs.getTimestamp("createDate")
                    );
                    listUsers.add(u);
                }

            }
        } catch (Exception e) {
            System.out.println("getListUser: " + e.getMessage());
        }
        return listUsers;
    }
    public static void main(String[] args) {
        for (User user : new UserDAO().getUserList(false)) {
            System.out.println(user.getEmail());
        }
    }

}
