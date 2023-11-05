package service;

import dao.UserDAO;
import java.util.HashMap;
import java.util.Map;
import model.User;
import utils.Helper;

public class UserService {

    private UserDAO userDao = new UserDAO();

    public HashMap<User, String> checkUserLogin(String account, String password) {
        try {
            password = Helper.encryptPassword(password);
        } catch (Exception e) {
            e.printStackTrace();
        }

        HashMap<User, String> map = new HashMap<>();
        for (User user : userDao.getUserList(false)) {
            String caseLogin = (account.contains("@") ? user.getEmail() : user.getMobile());
            if (caseLogin.equals(account.trim()) && user.getPassword().equals(password)) {
                map.put(user, null);
                return map;
            }
        }
        map.put(null, (account.contains("@") ? "Email " : "Mobile ") + "not existed or password not correct!");
        return map;
    }

    public HashMap<User, String> checkLoginWithGgle(String email, String oauthId) {
        HashMap<User, String> map = new HashMap<>();
        for (User user : userDao.getUserList(false)) {
            if (email.equals(user.getEmail()) && user.getOauthId().equals(oauthId)) {
                map.put(user, null);
                return map;
            }
        }
        map.put(null, "Email not been registered!");
        return map;
    }
    
    public User getUser(int userId){
        for (User userDB : userDao.getUserList(false)) {
            if (userDB.getUserId() == userId) {
                return userDB;
            }
        }return null;
    }

}
