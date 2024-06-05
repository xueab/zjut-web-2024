<%@ page import="service.EmployeeService" %>
<%@ page import="model.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="service.SalaryService" %>
<%@ page import="model.Salary" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>总经理</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
        }
        .sidebar {
            height: 100%;
            width: 250px;
            position: fixed;
            z-index: 1;
            top: 0;
            left: 0;
            background: linear-gradient(to bottom, #5F9EA0, #4682B4, #87CEEB, #B0E0E6, #E0FFFF); /* 渐变效果 */
            padding-top: 20px;
            color: white;
        }
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white; /* 文字颜色 */
            display: block;
        }
        .sidebar a i {
            margin-right: 10px;
        }
        .sidebar a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            color: white; /* 悬停时文字颜色 */
        }
        .main {
            margin-left: 260px;
            padding: 20px;
        }
        .card {
            margin-bottom: 20px;
        }
        .modal-content input {
            margin-bottom: 10px;
        }
        .content-section {
            display: none;
        }
        .active {
            display: block;
        }
    </style>
</head>
<body>
<%
    String username = request.getParameter("username");
%>
<div class="sidebar">
    <a href="#" onclick="showSection('employeeManagement')"><i class="fas fa-user-shield"></i>查看员工</a>
    <a href="#" onclick="showSection('viewSalaries')"><i class="fas fa-money-check-alt"></i>查看工资</a>
    <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
</div>

<div class="main">
    <div id="employeeManagement" class="container content-section active">
        <h2>员工管理</h2>
        <br><br>
        <% EmployeeService employeeService = new EmployeeService();
            List<Employee> employee = employeeService.selectAll();
            Map<String, Double> employeeMap = employeeService.getDepartmentStats();
            request.setAttribute("employeeMap", employeeMap);
            request.setAttribute("employee", employee);
        %>
        <% SalaryService SalaryService = new SalaryService();
            List<Salary> salary = SalaryService.selectAll();
            Map<String, Double> salaryMap = SalaryService.getSalaryStats();
            request.setAttribute("employeeMap", salaryMap);
            request.setAttribute("salary", salary);
        %>
        <button class="btn btn-info" data-toggle="modal" data-target="#employeePieChartModal">显示饼状图</button>
        <br><br>
        <br><br>
        <h3>所有员工</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>姓名</th>
                <th>员工编号</th>
                <th>部门</th>
                <th>岗位</th>
                <th>职务</th>
                <th>身份证号</th>
                <th>手机号</th>
                <th>住址</th>
            </tr>
            </thead>
            <tbody id="employeeRolesTable">
            <c:forEach var="employeeRole" items="${employee}">
                <tr>
                    <td>${employeeRole.name}</td>
                    <td>${employeeRole.empNo}</td>
                    <td>${employeeRole.depName}</td>
                    <td>${employeeRole.position}</td>
                    <td>${employeeRole.idNumber}</td>
                    <td>${employeeRole.phone}</td>
                    <td>${employeeRole.address}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <button class="btn btn-success" data-toggle="modal" data-target="#addemployeeModal">添加员工</button>
    </div>

    <div id="viewSalaries" class="container content-section">
        <h2>查看工资</h2>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>员工编号</th>
                <th>工资所属年份</th>
                <th>工资所属月份</th>
                <th>基本工资</th>
                <th>加班工资</th>
                <th>全勤奖</th>
                <th>个人所得税</th>
                <th>实发工资</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="salary" items="${salary}">
                <tr>
                    <td>${salary.empNo}</td>
                    <td>${salary.year}</td>
                    <td>${salary.month}</td>
                    <td>${salary.basicSalary}</td>
                    <td>${salary.overtimePay}</td>
                    <td>${salary.fullAttendanceBonus}</td>
                    <td>${salary.personalTax}</td>
                    <td>${salary.netSalary}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div id="changePassword" class="container content-section">
        <h2>修改密码</h2>
        <form action="changePassword.do" method="post">
            <div class="form-group">
                <label for="oldPassword">旧密码:</label>
                <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
            </div>
            <div class="form-group">
                <label for="newPassword">新密码:</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">确认新密码:</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn btn-primary">修改密码</button>
        </form>
    </div>
</div>

<div class="modal fade" id="employeePieChartModal" tabindex="-1" role="dialog" aria-labelledby="employeePieChartModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="salaryPieChartModalLabel">员工部门分布图</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="piechart1" style="width: 100%; height: 400px;"></div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="salaryPieChartModal" tabindex="-1" role="dialog" aria-labelledby="salaryPieChartModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="employeePieChartModalLabel">工资收入分布</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="piechart2" style="width: 100%; height: 400px;"></div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    function showSection(sectionId) {
        var sections = document.getElementsByClassName('content-section');
        for (var i = 0; i < sections.length; i++) {
            sections[i].classList.remove('active');
        }
        document.getElementById(sectionId).classList.add('active');
    }

    // Load the Visualization API and the corechart package.
    google.charts.load('current', {'packages':['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        // Create the data table.
        var data = google.visualization.arrayToDataTable([
            ['Salary', 'Percentage'],
            <c:forEach var="entry" items="${salaryMap}">
            ['${entry.key}', ${entry.value}],
            </c:forEach>
        ]);

        // Set chart options
        var options = {
            'title': '工资收入分布情况',
            'width': 400,
            'height': 300
        };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('piechart2'));
        chart.draw(data, options);
    }
</script>

<script type="text/javascript">
    function showSection(sectionId) {
        var sections = document.getElementsByClassName('content-section');
        for (var i = 0; i < sections.length; i++) {
            sections[i].classList.remove('active');
        }
        document.getElementById(sectionId).classList.add('active');
    }

    // Load the Visualization API and the corechart package.
    google.charts.load('current', {'packages':['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        // Create the data table.
        var data = google.visualization.arrayToDataTable([
            ['Department', 'Percentage'],
            <c:forEach var="entry" items="${employeeMap}">
            ['${entry.key}', ${entry.value}],
            </c:forEach>
        ]);

        // Set chart options
        var options = {
            'title': '员工部门分布',
            'width': 400,
            'height': 300
        };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('piechart1'));
        chart.draw(data, options);
    }
</script>

<script>
    function showSection(sectionId) {
        var sections = document.getElementsByClassName("content-section");
        for (var i = 0; i < sections.length; i++) {
            sections[i].style.display = "none";
        }
        document.getElementById(sectionId).style.display = "block";
    }
</script>
</body>
</html>