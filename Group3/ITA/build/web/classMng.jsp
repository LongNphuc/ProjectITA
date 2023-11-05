<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <div class="col-sm-12 col-xl-6">
            <div class="bg-light rounded h-100 p-4">
                <ul class="nav nav-tabs" id="myTabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="list-student-tab" data-toggle="tab" href="#list-student" role="tab" aria-controls="list-student" aria-selected="true">ClassDetail</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="group-tab" data-toggle="tab" href="#group" role="tab" aria-controls="group" aria-selected="false">Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="project-tab" data-toggle="tab" href="#project" role="tab" aria-controls="project" aria-selected="false">Project</a>
                    </li>
                </ul>
                <div class="tab-content" id="myTabsContent">
                    <jsp:include page="classDetail.jsp"/>
                    <jsp:include page="listStudent.jsp"/>
                    <div class="tab-pane fade" id="project" role="tabpanel" aria-labelledby="project-tab">
                        <!-- Content for Project Tab -->
                        <h6 class="mb-4">Project IMS</h6>
                        <div id="chart"></div>
                    </div>
                </div>
            </div>
        </div>


        <script>
            $(document).ready(function () {
                $('#myTabs a').on('click', function (e) {
                    e.preventDefault(),
                            $(this).tab('show');
                });
            });

            // JavaScript để ẩn các tab khi chuyển đổi
            $('#myTabs a').on('click', function (e) {
                e.preventDefault();
                var target = $(this).attr('href');
                $('.tab-pane').removeClass('show active');
                $(target).addClass('show active');
            });
        </script>

        <!-- Thêm các liên kết thư viện d3.js và JavaScript cho biểu đồ cột -->
        <script src="https://d3js.org/d3.v5.min.js"></script>
        <script>
            // Dữ liệu cho biểu đồ
            var data = [
                {group: "Group 1", commitTotal: 50, issue: 10},
                {group: "Group 2", commitTotal: 30, issue: 15},
                {group: "Group 3", commitTotal: 40, issue: 20},
                {group: "Group 4", commitTotal: 20, issue: 5}
            ];

            // Kích thước của biểu đồ
            var width = 600;
            var height = 300;
            var margin = {top: 20, right: 20, bottom: 100, left: 40};

            // Tạo đối tượng SVG cho biểu đồ
            var svg = d3.select("#chart")
                    .append("svg")
                    .attr("width", width)
                    .attr("height", height);

            // Tạo biến x cho dữ liệu cột commit total và issue
            var x = d3.scaleBand()
                    .domain(data.map(function (d) {
                        return d.group;
                    }))
                    .range([margin.left, width - margin.right])
                    .padding(0.6);

            var y = d3.scaleLinear()
                    .domain([0, d3.max(data, function (d) {
                            return Math.max(d.commitTotal, d.issue);
                        })])
                    .nice()
                    .range([height - margin.bottom, margin.top]);

            // Vẽ các cột cho commit total
            svg.selectAll(".commitTotal")
                    .data(data)
                    .enter().append("rect")
                    .attr("class", "commitTotal")
                    .attr("x", function (d) {
                        return x(d.group);
                    })
                    .attr("y", function (d) {
                        return y(d.commitTotal);
                    })
                    .attr("width", x.bandwidth() / 2)
                    .attr("height", function (d) {
                        return y(0) - y(d.commitTotal);
                    })
                    .style("fill", "blue");

            // Vẽ các cột cho issue
            svg.selectAll(".issue")
                    .data(data)
                    .enter().append("rect")
                    .attr("class", "issue")
                    .attr("x", function (d) {
                        return x(d.group) + x.bandwidth() / 2;
                    })
                    .attr("y", function (d) {
                        return y(d.issue);
                    })
                    .attr("width", x.bandwidth() / 2)
                    .attr("height", function (d) {
                        return y(0) - y(d.issue);
                    })
                    .style("fill", "black");


            svg.append("text")
                    .attr("x", width - 60)
                    .attr("y", margin.top - 10)
                    .text("Commit")
                    .style("fill", "blue");

            svg.append("text")
                    .attr("x", width - 60)
                    .attr("y", margin.top + 10)
                    .text("Issue")
                    .style("fill", "black");

            svg.selectAll(".group-label")
                    .data(data)
                    .enter().append("text")
                    .attr("class", "group-label")
                    .text(function (d) {
                        return d.group;
                    })
                    .attr("x", function (d) {
                        return x(d.group) + x.bandwidth() / 2;
                    })
                    .attr("y", height - margin.bottom + 10)
                    .style("text-anchor", "middle")
                    .style("font-size", "12px");

            svg.selectAll(".commit-text")
                    .data(data)
                    .enter().append("text")
                    .attr("class", "commit-text")
                    .text(function (d) {
                        return d.commit;
                    })
                    .attr("x", function (d) {
                        return x(d.group) + x.bandwidth() / 4;
                    })
                    .attr("y", function (d) {
                        return y(d.commit) - 5;
                    })
                    .style("text-anchor", "middle")
                    .style("font-size", "12px")
                    .style("fill", "gray");

            // Thêm số chi tiết lên trên mỗi cột issue
            svg.selectAll(".issue-text")
                    .data(data)
                    .enter().append("text")
                    .attr("class", "issue-text")
                    .text(function (d) {
                        return d.issue;
                    })
                    .attr("x", function (d) {
                        return x(d.group) + 3 * x.bandwidth() / 4;
                    })
                    .attr("y", function (d) {
                        return y(d.issue) - 5;
                    })
                    .style("text-anchor", "middle")
                    .style("font-size", "12px")
                    .style("fill", "red");
        </script>
    </body>
</html>
