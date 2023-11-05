
package service;

import dao.ClassDAO;

public class ClassService {
    private ClassDAO classDao = new ClassDAO();
    
    public boolean updateClassByClassId(String classId, String classCode, String subjectId, String semesterId, String status){
        return classDao.updateClassByClassId(classId,classCode,subjectId,semesterId,status);
    }
}
