package controller;

import dao.ClassDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Class;
import model.User;
import service.ClassService;
import utils.Helper;

@WebServlet(name = "ClassController", urlPatterns = {"/class"})
public class ClassController extends HttpServlet {
    
    private ClassService classService = new ClassService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("action") == null) {
            ArrayList<Class> classList = new ArrayList<>();
            User me = (User) request.getSession().getAttribute("user");
            for (Class cl : new ClassDAO().getListClass()) {
                if (cl.getTeacherId() == me.getUserId()) {
                    classList.add(cl);
                }
            }
            request.setAttribute("subjectList", new ClassDAO().getListSbuject());
            request.setAttribute("listClass", classList);
            request.setAttribute("classListSize", classList.size());
            request.getRequestDispatcher("classList.jsp").forward(request, response);
        } else {
            int classId = Integer.parseInt(request.getParameter("classId"));
            User me = (User) request.getSession().getAttribute("user");
            for (Class cl : new ClassDAO().getListClass()) {
                if (cl.getTeacherId() == me.getUserId() && classId == cl.getClassId()) {
                    request.setAttribute("cl", cl);
                }
            }
            request.setAttribute("subjectList", new ClassDAO().getListSbuject());
            request.setAttribute("semesterList", new ClassDAO().getListSemester());
            request.getRequestDispatcher("classMng.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("update") == null) {
            String classCode = request.getParameter("classCode");
            String subjectId = request.getParameter("subjectId");
            User user = (User) request.getSession().getAttribute("user");
            int indexClassNew = new ClassDAO().createClass(user.getUserId(), classCode, Integer.parseInt(subjectId));
            doGet(request, response);
        } else {
            classService.updateClassByClassId(request.getParameter("classId")
                    , request.getParameter("classCode")
                    , request.getParameter("subjectId")
                    ,request.getParameter("semesterId")
                    , request.getParameter("status"));
            doGet(request, response);
        }
    }

}
