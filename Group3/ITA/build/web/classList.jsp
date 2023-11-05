<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>

        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Liên kết Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Liên kết jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- Liên kết Bootstrap JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.min.js"></script>


        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-3">
            <div class="row">
                <div class="col-md-8">
                    <h4>Teacher ${sessionScope.user.fullName}<img src="${sessionScope.user.image}" style="width: 2rem; height: 2rem; border-radius: 50%"></h4>                 
                </div>
                <div class="col-md-8">
                    <h4>List Class (${requestScope.classListSize} class)</h4>
                </div>
                <div class="col-md-4">
                    <button type="button" id="addMember" class="btn btn-outline-primary float-end" data-bs-toggle="modal" data-bs-target="#addStudentModal">Create new class</button>
                </div>
            </div>
            <c:choose>
                <c:when test="${requestScope.classListSize eq 0}">
                    <p>No class own!</p>
                </c:when>
                <c:when test="${requestScope.classListSize ne 0}">
                    <div class="col-12">
                        <div class="bg-light rounded h-100 p-4">
                            <h6 class="mb-4">Class List</h6>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Class Name</th>
                                            <th scope="col">Subject</th>
                                            <th scope="col">Number Of Sstudent</th>
                                            <th scope="col">Date Created</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listClass}" var="c" varStatus="count">
                                            <tr style="cursor: pointer;" onclick="goToClassMng('${c.classId}')" id="classRowId">
                                                <th scope="row">${count.count}</th>
                                                <td>${c.classCode}</td>
                                                <td>${c.subject.subjectCode}</td>
                                                <td>0</td>
                                                <td>${c.dateCreate}</td>
                                                <td><c:if test="${c.isActive eq 0}">InActive</c:if><c:if test="${c.isActive eq 1}">Active</c:if></td>
                                                <td><a href="#">Detail</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:when>
            </c:choose>
        </div>
        <div class="modal fade" id="addStudentModal" tabindex="-1" aria-labelledby="addStudentModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addStudentModalLabel">Add Student into class ${className}</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="class" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="studentInput" class="form-label">Class code</label>
                                <input type="text" placeholder="ClassCode" class="form-control" id="studentInput" name="classCode" required>   
                                <label for="subject" class="form-label">Subject</label>
                                <select name="subjectId" id="subject">
                                    <c:forEach items="${subjectList}" var="s">
                                        <option value="${s.subjectId}">${s.subjectCode}</option>
                                    </c:forEach>
                                </select>   

                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Invite</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="component/footer.jsp" %>
    </body>
    <script>
        function goToClassMng(classId) {
            var userProfileUrl = './class?action=true&classId=' + classId;
            window.location.href = userProfileUrl;
        }
    </script>
</html>
