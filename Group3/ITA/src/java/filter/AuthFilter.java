package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/sign-up", "/LoginController", "/logout"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        System.out.println(request.getRequestURI());

        HttpSession session = request.getSession();
        if (session.getAttribute("user") != null) {
            if (request.getRequestURI().endsWith("/logout")) {
                chain.doFilter(req, res);
            } else {
                response.sendRedirect(request.getContextPath());
                return;
            }
        } else {
            if (request.getRequestURI().endsWith("/logout")) {
                response.sendRedirect("./error");
                return;
            } else if (request.getRequestURI().endsWith("/LoginController")) {
                System.out.println("haha");
                System.out.println(request.getQueryString());
                if (request.getQueryString() == null) {
                    response.sendRedirect("./error");
                    return;
                } else if (request.getQueryString().equals("signin=true") || request.getQueryString().startsWith("code=") || request.getQueryString().startsWith("account=")) {
                    chain.doFilter(req, res);
                } else {
                    response.sendRedirect("./error");
                    return;
                }
            } else {
                chain.doFilter(req, res);
            }
        }
    }

}
