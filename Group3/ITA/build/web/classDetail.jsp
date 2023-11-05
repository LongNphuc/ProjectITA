<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="tab-pane fade show active" id="list-student" role="tabpanel" aria-labelledby="list-student-tab">
    <h6 class="mb-4">ClassDetail</h6>
    <table class="table table-borderless">
        <div class="d-flex flex-row">
            <button class="btn btn-outline-success ms-3">
                <i class="fa-regular fa-file-export"></i>
                Export CSV
            </button>
        </div>
        <div class="col-sm-12 col-xl-6">
            <div class="bg-light rounded h-100 p-4">
                <form action="class" method="post">
                    <input type="hidden" name="update" value="true">
                    <input type="hidden" name="classId" value="${cl.classId}">
                    <div class="form-group">
                        <label for="classCode">Class Code</label>
                        <input type="text" class="form-control" id="classCode" value="${cl.classCode}" name="classCode" placeholder="Class Code">
                    </div>
                    <div class="form-group">
                        <label for="teacher">Teacher</label>
                        <input type="text" class="form-control" id="teacher" value="${sessionScope.user.username}" name="teacher" placeholder="Teacher Name" readonly>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <select class="form-control" id="subject" name="subjectId">
                            <c:forEach var="s" items="${subjectList}">
                                <option value="${s.subjectId}" <c:if test="${cl.subject.subjectId eq s.subjectId}">selected</c:if>>${s.subjectCode}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="semester">Semester</label>
                        <select class="form-control" id="semester" name="semesterId">
                            <c:forEach var="se" items="${semesterList}">
                                <option value="${se.semesterId}" <c:if test="${cl.semester.semesterId eq se.semesterId}">selected</c:if>>${se.semesterName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Status</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="activeStatus" value="1" <c:if test="${cl.isActive eq 1}"> checked</c:if>>
                                <label class="form-check-label" for="activeStatus">
                                    Active
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="status" id="inactiveStatus" value="0"<c:if test="${cl.isActive eq 0}"> checked</c:if>>
                                <label class="form-check-label" for="inactiveStatus">
                                    Inactive
                                </label>
                            </div>       
                    </div>
                    <button type="submit" class="btn btn-primary">Save</button>
                </form>
            </div>
        </div>

    </table>
</div>