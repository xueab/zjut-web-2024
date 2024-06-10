<%@ page import="service.EmployeeService" %>
<%@ page import="model.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Salary" %>
<%@ page import="service.SalaryService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>人事管理员</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

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
            background: linear-gradient(to bottom, #5F9EA0, #4682B4, #87CEEB, #B0E0E6, #E0FFFF);
            padding-top: 20px;
            color: white;
        }
        .sidebar a, .sidebar button {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
            text-align: left;
            background: none;
            border: none;
            cursor: pointer;
        }
        .sidebar a i, .sidebar button i {
            margin-right: 10px;
        }
        .sidebar a:hover, .sidebar button:hover {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
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
        .chart-container {
            width: 100%;
            height: 400px;
            margin: 0 auto;
        }
        .pagination {
            justify-content: center;
            margin-top: 20px;
        }
        .page-item.active .page-link {
            background-color: #007bff;
            border-color: #007bff;
        }
        .page-link {
            color: #007bff;
        }
        .page-link:hover {
            color: #0056b3;
        }
    </style>
</head>
<div>
<%
    String username = request.getParameter("username");
%>
<div class="sidebar">
    <a href="#" onclick="showSection('employeeManagement')"><i class="fas fa-user-shield"></i>角色管理</a>
    <a href="#" onclick="showSection('viewSalaries')"><i class="fas fa-money-check-alt"></i>查看工资</a>
    <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#logoutModal">
        <i class="fas fa-sign-out-alt"></i> 退出登录
    </button>
</div>
<div class="main">
    <div id="employeeManagement" class="container content-section active">
        <h2>员工管理</h2>
        <%
            EmployeeService employeeService = new EmployeeService();
            List<Employee> employee = employeeService.selectAll();
            Map<String, Double> employeeMap = employeeService.getDepartmentStats();
            request.setAttribute("employeeMap", employeeMap);
            request.setAttribute("employee", employee);
        %>
        <button class="btn btn-info" data-toggle="modal" data-target="#employeePieChartModal">显示饼状图</button>
        <br><br>
        <h3>所有员工</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>姓名</th>
                <th>员工编号</th>
                <th>部门</th>
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
    </div>

    <div id="viewSalaries" class="container content-section">
        <h2>查看工资</h2>
        <br>
        <% SalaryService salaryService = new SalaryService();
            List<Salary> salary = salaryService.selectAll();
            Map<String, Double> salaryMap = salaryService.getSalaryStats();
            request.setAttribute("salaryMap", salaryMap);
            request.setAttribute("salary", salary);
        %>
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
            <tbody id="salaryRolesTable">
            <button class="btn btn-info" data-toggle="modal" data-target="#salaryPieChartModal">显示工资分布饼状图</button>
            <c:forEach var="salaryRole" items="${salary}">
                <tr>
                    <td>${salaryRole.empNo}</td>
                    <td>${salaryRole.year}</td>
                    <td>${salaryRole.month}</td>
                    <td>${salaryRole.basicSalary}</td>
                    <td>${salaryRole.overtimePay}</td>
                    <td>${salaryRole.fullAttendanceBonus}</td>
                    <td>${salaryRole.personalTax}</td>
                    <td>${salaryRole.netSalary}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <button class="btn btn-primary" onclick="window.location.href='exportExcelServlet'">导出</button>
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
</div>

<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="logoutModalLabel">确认退出</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                你确定要退出登录吗？
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" onclick="confirmLogout()">退出</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="employeePieChartModal" tabindex="-1" role="dialog" aria-labelledby="employeePieChartModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="employeePieChartModalLabel">员工部门比例</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="piechart1" class="chart-container"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="salaryPieChartModal" tabindex="-1" role="dialog" aria-labelledby="salaryPieChartModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="salaryPieChartModalLabel">工资收入分布</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="piechart2" style="width: 100%; height: 400px;"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
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

    function confirmLogout() {
        window.location.href = 'login.jsp';
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
            'width': 600,
            'height': 450,
            'titleTextStyle': {
                'fontSize': 24, // 调整字体大小
                'bold': true, // 是否加粗
                'color': '#000000' // 字体颜色
            }
        };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('piechart1'));
        chart.draw(data, options);
    }
</script>

<script type="text/javascript">
    $('form').on('submit', function () {
        var form = $(this);
        // 延迟清空表单，确保表单提交完成
        setTimeout(function () {
            form.find('input').val('');
        }, 1000); // 延迟1秒清空表单
    });

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

        if (data.getNumberOfRows() === 0) {
            $('#piechart').text('没有数据可显示');
            return;
        }

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
</body>
</html>
