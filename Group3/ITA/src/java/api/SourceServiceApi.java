package api;

import com.google.gson.Gson;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.User;
import utils.Helper;
import utils.Mail;

@WebServlet(name = "SourceServiceApi", urlPatterns = {"/sourceServiceApi"})
public class SourceServiceApi extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try ( PrintWriter out = response.getWriter()) {
            switch (request.getParameter("source")) {
                case "listMobile":
                    ArrayList<String> mobileList = new ArrayList<>();
                    for (User user : new UserDAO().getUserList(false)) {
                        mobileList.add(user.getMobile());
                    }
                    String mobileJson = new Gson().toJson(mobileList);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    out.print(mobileJson);
                    out.flush();
                case "removeSession" :
                    request.getSession().removeAttribute(request.getParameter("name"));
                    break;
                case "sendOTPByEmail" :
                    String email = request.getParameter("email");
                    String otp = Helper.getRandomNumberString();
                    Mail.send(email,"Confirm OTP", "OTP: "+otp);
                    String otpJson = new Gson().toJson(otp);
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    out.print(otpJson);
                    out.flush();
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
