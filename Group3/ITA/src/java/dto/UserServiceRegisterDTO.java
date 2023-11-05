
package dto;

public class UserServiceRegisterDTO {
    private String mobile,email,accountName, oauthId,image, fullName; 
    private int roleId;
    private String password;

    public UserServiceRegisterDTO() {
    }

    public UserServiceRegisterDTO(String mobile, String email,String accountName, int roleId, String password) {
        this.mobile = mobile;
        this.accountName = accountName;
        this.roleId = roleId;
        this.password = password;
    }

    public UserServiceRegisterDTO(String email, String accountName, String oauthId, String image, String fullName, int roleId, String password) {
        this.email = email;
        this.accountName = accountName;
        this.oauthId = oauthId;
        this.image = image;
        this.fullName = fullName;
        this.roleId = roleId;
        this.password = password;
    }

    public String getOauthId() {
        return oauthId;
    }

    public String getImage() {
        return image;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
    
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "UserServiceRegisterDTO{" + "mobile=" + mobile + ", email=" + email + ", accountName=" + accountName + ", oauthId=" + oauthId + ", image=" + image + ", fullName=" + fullName + ", roleId=" + roleId + ", password=" + password + '}';
    }

    

    
    
    
    
    
}
