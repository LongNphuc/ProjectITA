package model;

import java.sql.Timestamp;

public class User {

    private int userId;
    private String username, password, oauthId, email,mobile;
    private Role role;
    private String fullName, image;
    private Semester semester;
    private Timestamp dateCreated;
    private byte isDeleted, isActive;
    
    public User() {
    }
    //teacher
    public User(int userId, String username,String mobile ,String password, String oauthId, String email, Role role, String fullName,String image,byte isActived, Timestamp dateCreated) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.oauthId = oauthId;
        this.email = email;
        this.role = role;
        this.mobile = mobile;
        this.fullName = fullName;
        this.image = image;
        this.dateCreated = dateCreated;
        this.isActive = isActived;
    }
    //student
    public User(int userId, String username, String mobile,String password, String oauthId, String email, Role role, String fullName,Semester semester ,String image,byte isActived, Timestamp dateCreated) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.oauthId = oauthId;
        this.email = email;
        this.mobile = mobile;
        this.semester = semester;
        this.role = role;
        this.fullName = fullName;
        this.image = image;
        this.dateCreated = dateCreated;
        this.isActive = isActived;
    }

    public String getMobile() {
        try{
            return (!mobile.equals("null") ? this.mobile = mobile : "");
        }catch(Exception e) {
            return "";
        }
    }

    public Semester getSemester() {
        return semester;
    }
    
    public int getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getOauthId() {
        return oauthId;
    }

    public String getEmail() {
        try{
            return (!email.equals("null") ? this.email = email : "");
        }catch(Exception e) {
            return "";
        }
    }

    public Role getRole() {
        return role;
    }
  
    public String getFullName() {
        return fullName;
    }

    public String getImage() {
        return image;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public byte getIsDeleted() {
        return isDeleted;
    }

    public String getIsDeletedString() {
        return (isDeleted == 0) ? "False" : "True";
    }

    public byte getIsActive() {
        return isActive;
    }
    
    public String getIsActiveString() {
        return (isActive == 0) ? "False" : "True";
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", username=" + username + ", password=" + password + ", oauthId=" + oauthId + ", email=" + email + ", mobile=" + mobile + ", role=" + role + ", fullName=" + fullName + ", image=" + image + ", semester=" + semester + ", dateCreated=" + dateCreated + ", isDeleted=" + isDeleted + ", isActive=" + isActive + '}';
    }
    
    
}
