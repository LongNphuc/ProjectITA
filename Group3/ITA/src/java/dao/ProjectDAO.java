/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import connection._DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Project;

/**
 *
 * @author PC
 */
public class ProjectDAO extends _DBContext {

   

    public ArrayList<Project> getProjectList(int classId) {
        ArrayList<Project> projectList = new ArrayList<>();
        String queryStr = "SELECT * FROM project where classId = ?";
        try {
            PreparedStatement stm = new _DBContext().getConnection().prepareStatement(queryStr);
            stm.setInt(1, classId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                projectList.add(new Project(
                        rs.getInt(1), rs.getInt(4),
                        rs.getString(2), rs.getTimestamp(3)
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projectList;
    }

    public Project getProjectByProjectId(int projectId) {
        Project project = null;
        String queryStr = "SELECT * FROM project WHERE projectId = ?;";
        try {
            PreparedStatement stm = new _DBContext().getConnection().prepareStatement(queryStr);
            stm.setInt(1, projectId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                project = new Project(
                        rs.getInt(1), rs.getInt(4),
                        rs.getString(2), rs.getTimestamp(3)
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return project;
    }

    public void insertProject(String projectName,int classId) {//INSERT INTO project (projectName) VALUES ('DTA');
        String queryStr = "INSERT INTO project (projectName, classId) VALUES (?, ?);";
        try {
            PreparedStatement stm = new _DBContext().getConnection().prepareStatement(queryStr);
            stm.setString(1, projectName);
            stm.setInt(2, classId);
            stm.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void deleteProject(int projectId) {//INSERT INTO project (projectName) VALUES ('DTA');
        String queryStr = "DELETE FROM project WHERE projectId = ?";
        try {
            PreparedStatement stm = new _DBContext().getConnection().prepareStatement(queryStr);
            stm.setInt(1, projectId);
            stm.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void updateProject(int projectId, String projectName) {
        String queryStr = "UPDATE project\n"
                + "SET projectName = ?\n"
                + "WHERE projectId = ?; ";
        try {
            PreparedStatement stm = new _DBContext().getConnection().prepareStatement(queryStr);
            stm.setString(1, projectName);
            stm.setInt(2, projectId);
            stm.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

}
