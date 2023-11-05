package controller;

import com.google.gson.Gson;
import dao.UserDAO;
import dto.UserServiceRegisterDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import model.User;
import service.UserService;
import utils.Helper;

@WebServlet(name = "SignUpController", urlPatterns = {"/sign-up"})
public class SignUpController extends HttpServlet {

    UserService uService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("sign-up.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BufferedReader reader = request.getReader();
        StringBuilder requestBody = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            requestBody.append(line);
        }
        UserServiceRegisterDTO user = new Gson().fromJson(requestBody.toString(), UserServiceRegisterDTO.class);
        try {
            user.setPassword(Helper.encryptPassword(user.getPassword()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        int addUser = -1;
        if (user.getMobile() != null) {
            addUser = new UserDAO().createUser(user);
        } else {
            addUser = new UserDAO().addUserGoogle(user);
        }
        request.getSession().setAttribute("user", uService.getUser(addUser));
        
    }
    
}
