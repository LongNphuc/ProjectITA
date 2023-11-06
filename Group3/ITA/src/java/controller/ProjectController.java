

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.ProjectService;
import model.Project;

@WebServlet(name="project", urlPatterns={"/project"})
public class ProjectController extends HttpServlet {
 

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
        int classId=0;
        if(req.getParameter("classId")!= null){
        classId = Integer.parseInt(req.getParameter("classId"));
        }
        req.setAttribute("classId",classId);
        req.setAttribute("projectList", new ProjectService().getProjectList(classId));
        req.getRequestDispatcher("projectList.jsp").forward(req, resp);
    } 

   
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
       int classId = Integer.parseInt(req.getParameter("classId"));
       if(req.getParameter("action")!=null){
           System.out.println(req.getParameter("projectId"));
           switch (req.getParameter("action")) {
               case "create" :
                    classId = Integer.parseInt(req.getParameter("classId"));
                   new ProjectService().createProject(req.getParameter("projectName"),classId);
                   break;
               case "update" :
                   int projectId = Integer.parseInt(req.getParameter("projectId"));
                   new ProjectService().updateProject(projectId,req.getParameter("projectName"));
                   break;
               case "delete" :
                   projectId = Integer.parseInt(req.getParameter("projectId"));
                   new ProjectService().deleteProject(projectId);
                   break;    
               default:
                   throw new AssertionError();
           }
       }
       resp.sendRedirect("./project?classId="+classId);
    }

   
}
