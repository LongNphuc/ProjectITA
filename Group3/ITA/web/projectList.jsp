<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Project List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
            }

            h1 {
                background-color: #007BFF;
                color: white;
                padding: 10px;
            }

            table {
                margin: 20px auto;
                border-collapse: collapse;
                width: 80%;
            }

            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }

            th {
                background-color: #007BFF;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
        </style>

        <!-- Bootstrap css -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap-select -->
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/css/bootstrap-select.min.css">

        <!-- JQuery -->
        <script src='https://code.jquery.com/jquery-3.5.1.js'></script>

        <!-- Multiple-select -->
        <link rel="stylesheet" href="https://unpkg.com/multiple-select@1.6.0/dist/multiple-select.min.css">
        <script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
        <script src="https://unpkg.com/multiple-select@1.6.0/dist/multiple-select.min.js"></script>

        <!-- Momentjs -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

        <!-- Chartjs -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <!-- Fontawesome css
        <link rel="stylesheet" data-purpose="Layout StyleSheet" title="Web Awesome"
        href="/css/app-wa-02670e9412103b5852dcbe140d278c49.css?vsn=d"> -->
        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
        <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    </head>
    <body>
        <h1>Project List</h1>
        <table>
            <tr>
                <th>Project Name</th>
                <th>Date Create</th>
                <th></th>
                <th></th>
                <th></th>

            </tr>
            <c:forEach items="${projectList}" var="p">
                <tr>
                    <td>${p.getProjectName()}</td>
                    <td>${p.dateCreate}</td>
                    <td><form action="project" method="post">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="projectId" value="${p.getProjectId()}">
                            <td> <button class="btn btn-danger" type="submit" >Delete</button></td>
                        </form><td><button id="updateButton" class="btn btn-outline-success" data-bs-toggle="modal" 
                                       data-bs-target="#myModal${p.getProjectId()}">
                            Update
                        </button>                     
                    </td>
                </tr>
                <div class="modal fade" id="myModal${p.getProjectId()}" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" style="background-color: white; color: black;" >Update project</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="project" method="post" id="updateCourseForm" onsubmit="return checkText($('#_update-course-name'), $('#_update-course-name'));">
                                    <input type="hidden" name="queryString" value="${pageContext.request.queryString}" />
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="projectId" value="${p.getProjectId()}">                                                    
                                    <div class="form-floating">   
                                        <input type="text" name="projectName" class="form-control" id="_update-course-name"
                                               placeholder="course-name" value="${p.getProjectName()}" required
                                               oninput="checkText($('#_update-course-name'), $('#_update-course-name-feedback'))">
                                        <label for="f-course-name-update">Project name</label>
                                    </div>
                                    <div class="invalid-feedback" id="_update-course-name-feedback">
                                    </div>
                                    <button style="margin-top: 10px" class="btn btn-primary" type="submit">Update</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </table>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
            Create project 
        </button>
        <!-- Modal -->
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Create Project</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Bao lấy form và đặt action và method của form -->
                        <form id="createProjectForm" action="project" method="post">
                            <input type="hidden" name="action" value="create">
                            <div class="form-floating mt-3">
                                <input type="text" name="projectName" class="form-control"
                                       id="f-course-name" placeholder="course-name" required
                                       oninput="checkText($('#f-course-name'), $('#_course-name-feedback')); checkCourseCode()">
                                <label for="f-course-name">Project name</label>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <!-- Đặt nút "Create" với type="button" và gắn sự kiện click để submit form -->
                        <button type="button" class="btn btn-primary" onclick="submitCreateProjectForm()">Create</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function submitCreateProjectForm() {
                // Sử dụng JavaScript để submit form
                document.getElementById("createProjectForm").submit();
            }
        </script>


        <script>
            // JavaScript để hiển thị modal khi nút "Update" được nhấn
            function openUpdateProjectModal(projectId) {
                var modalId = `#updateProjectModal${projectId}`;
                $(modalId).modal('show');
            }

            // Gọi hàm openUpdateProjectModal khi nút "Update" được nhấn
            $('.btn-primary').click(function () {
                var projectId = $(this).data('target').replace('#updateProjectModal', '');
                openUpdateProjectModal(projectId);
            });
        </script>






        <script>
            function openCreateProjectModal() {
                // Hiển thị popup tạo dự án bằng cách thay đổi thuộc tính "display" thành "block"
                document.getElementById("createProjectModal").style.display = "block";
            }

            function createProject() {
                // Lấy tên dự án từ trường nhập liệu
                var projectName = document.getElementById("newProjectName").value;

                // Thực hiện gửi yêu cầu tạo dự án lên máy chủ (có thể sử dụng AJAX)

                // Sau khi tạo dự án thành công, cập nhật danh sách dự án hoặc làm các công việc khác theo nhu cầu

                // Đóng popup bằng cách đặt lại thuộc tính "display" thành "none"
                document.getElementById("createProjectModal").style.display = "none";

                // Xóa giá trị nhập liệu sau khi tạo dự án
                document.getElementById("newProjectName").value = "";
            }
        </script>

        <!-- Modal for Project Update -->

        <script>
            function deleteProject(projectId) {
                // Tạo một đối tượng XMLHttpRequest
                $.post("question", {
                    "action": "delete",
                    "projectId": projectId
                }, function (data) {

                    ;
                }, "json");

                // Xử lý sự kiện khi yêu cầu hoàn thành
                // Load lại trang
                location.reload();

            }
            ;
        </script>


        <!-- Popper -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>

        <!-- Bootstrap -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Bootstrap-select -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.14.0-beta3/dist/js/bootstrap-select.min.js"></script>
    </body>

</html>
