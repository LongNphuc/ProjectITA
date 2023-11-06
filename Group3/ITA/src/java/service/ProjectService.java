
package service;
import dao.ProjectDAO;
import java.sql.Timestamp;
import java.util.ArrayList;
import model.Project;
public class ProjectService {
    
   public ArrayList<Project> getProjectList(int classId){
       ArrayList<Project> projectList = new ProjectDAO().getProjectList(classId);
       return projectList;
   }
   
    public Project getProject(int projectId){
       Project project = new ProjectDAO().getProjectByProjectId(projectId);
       return project;
   }

    public void createProject(String projectName,int classId) {
        new ProjectDAO().insertProject(projectName,classId);
    }

    public void deleteProject(int projectId) {
        new ProjectDAO().deleteProject(projectId);
    }

    public void updateProject(int projectId, String projectName) {
        new ProjectDAO().updateProject(projectId,projectName);
    }
}
