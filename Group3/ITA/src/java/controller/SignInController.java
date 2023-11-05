package controller;

//import dao.UserDAO;
import dao.UserDAO;
import dto.UserGoogleDTO;
import java.io.IOException;

//import dto.UserGoogleDTO;
//import utils.Helper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import model.User;
import service.UserService;
import utils.Helper;

@WebServlet(name = "SignInController", urlPatterns = {"/LoginController"})
public class SignInController extends HttpServlet {

    private UserService uService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("signin") != null) {
            request.getRequestDispatcher("sign-in.jsp").forward(request, response);
        } else if (request.getParameter("account") != null) {
            String account = request.getParameter("account");
            String password = request.getParameter("password");
    
            HashMap<User, String> mapLogin = uService.checkUserLogin(account, password);
            if (mapLogin.keySet().iterator().next() != null) {
                request.getSession().setAttribute("user", mapLogin.keySet().iterator().next());
                response.sendRedirect(request.getContextPath());
                return;
            } else {
                request.setAttribute("mess", mapLogin.values().iterator().next());
                request.getRequestDispatcher("sign-in.jsp").forward(request, response);
            }
        } else {
            String code = request.getParameter("code");
            String accessToken = Helper.getToken(code);

            UserGoogleDTO userInfo = Helper.getUserInfo(accessToken);
            if (request.getSession().getAttribute("checkExist") != null) {
                if (new UserDAO().isUserExist(UserDAO.LOGIN_EMAIL, userInfo.getEmail(), userInfo.getId())) {
                    request.getSession().setAttribute("mess", "Email had been register!");
                    response.sendRedirect(request.getContextPath() + "/sign-up?signup=true");
                } else {
                    request.setAttribute("userGoogle", userInfo);
                    request.getRequestDispatcher("userGoogleFillInfo.jsp").forward(request, response);
                }
            } else {
                HashMap<User, String> mapLogin = uService.checkLoginWithGgle(userInfo.getEmail(), userInfo.getId());
                if (mapLogin.keySet().iterator().next() != null) {
                    request.getSession().setAttribute("user", mapLogin.keySet().iterator().next());
                    response.sendRedirect(request.getContextPath());
                } else {
                    request.setAttribute("mess", mapLogin.values().iterator().next());
                    request.getRequestDispatcher("sign-in.jsp").forward(request, response);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
