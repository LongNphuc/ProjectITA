package model;

import dao.UserDAO;



public class Role { 
    public static int ROLE_STUDENT = UserDAO.getRoleIdByRoleName("Student");
    public static int ROLE_TEACHER = UserDAO.getRoleIdByRoleName("Teacher");
    public static int ROLE_ADMIN = UserDAO.getRoleIdByRoleName("Admin");
    
    private int roleId;
    private String roleName;

    public Role() {
    }

    public Role(int roleId, String roleName) {
        this.roleId = roleId;
        this.roleName = roleName;
    }

    public int getRoleId() {
        return roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    
}
