<%@ page import="model.Salary" %>
<%@ page import="service.SalaryService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>财务管理员</title>
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
    <a href="#" onclick="showSection('viewSalaries')"><i class="fas fa-money-check-alt"></i>查看工资</a>
    <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
</div>
<div class="main">
<div id="viewSalaries" class="container content-section active">
    <h2>查看工资</h2>
    <br>
    <div class="form-group">
        <input type="text" class="form-control" id="searchInput" placeholder="搜索员工姓名">
    </div>
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
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <% SalaryService SalaryService = new SalaryService();
            List<Salary> salary = SalaryService.selectAll();
            Map<String, Double> salaryMap = SalaryService.getSalaryStats();
            request.setAttribute("employeeMap", salaryMap);
            request.setAttribute("salary", salary);
        %>
        <button class="btn btn-info" data-toggle="modal" data-target="#employeePieChartModal">显示工资分布饼状图</button>
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
                <td>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#editSalaryModal" data-empNo="${salary.empNo}" data-year="${salary.year}" data-month="${salary.month}" data-basicSalary="${salary.basicSalary}" data-overtimePay="${salary.overtimePay}" data-fullAttendanceBonus="${salary.fullAttendanceBonus}" data-personTax="${salary.personalTax}" data-netSalary="${salary.netSalary}">编辑</button>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#editSalaryModal" data-empNo="${salary.empNo}" data-year="${salary.year}" data-month="${salary.month}" data-basicSalary="${salary.basicSalary}" data-overtimePay="${salary.overtimePay}" data-fullAttendanceBonus="${salary.fullAttendanceBonus}" data-personTax="${salary.personalTax}" data-netSalary="${salary.netSalary}">删除</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <button class="btn btn-success" data-toggle="modal" data-target="#addSalaryModal">添加记录</button>
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

<div class="modal fade" id="addSalaryModal" tabindex="-1" role="dialog" aria-labelledby="addSalaryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="addSalary.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addSalaryModalLabel">添加工资记录</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addempNo">员工编号:</label>
                        <input type="text" class="form-control" id="addempNo" name="addempNo" required>
                    </div>
                    <div class="form-group">
                        <label for="addyear">工资所属年份</label>
                        <input type="text" class="form-control" id="addyear" name="addyear" required>
                    </div>
                    <div class="form-group">
                        <label for="addmonth">工资所属月份:</label>
                        <input type="text" class="form-control" id="addmonth" name="addmonth" required>
                    </div>
                    <div class="form-group">
                        <label for="addbasicSalary">基本工资:</label>
                        <input type="number" class="form-control" id="addbasicSalary" name="addbasicSalary" required>
                    </div>
                    <div class="form-group">
                        <label for="addovertimeSalary">加班工资:</label>
                        <input type="number" class="form-control" id="addovertimeSalary" name="addovertimeSalary" required>
                    </div>
                    <div class="form-group">
                        <label for="addfullAttendanceBonus">全勤奖:</label>
                        <input type="number" class="form-control" id="addfullAttendanceBonus" name="addfullAttendanceBonus" required>
                    </div>
                    <div class="form-group">
                        <label for="addpersonalTax">个人所得税:</label>
                        <input type="number" class="form-control" id="addpersonalTax" name="addpersonalTax" required>
                    </div>
                    <div class="form-group">
                        <label for="addnetSalary">实发工资:</label>
                        <input type="number" class="form-control" id="addnetSalary" name="addnetSalary" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>
</div>

<div class="modal fade" id="editSalaryModal" tabindex="-1" role="dialog" aria-labelledby="editSalaryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="editSalary.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editSalaryModalLabel">编辑工资记录</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="editempNo">员工编号:</label>
                        <input type="text" class="form-control" id="editempNo" name="editempNo" required>
                    </div>
                    <div class="form-group">
                        <label for="edityear">工资所属年份</label>
                        <input type="text" class="form-control" id="edityear" name="edityear" required>
                    </div>
                    <div class="form-group">
                        <label for="editmonth">工资所属月份:</label>
                        <input type="text" class="form-control" id="editmonth" name="editmonth" required>
                    </div>
                    <div class="form-group">
                        <label for="editbasicSalary">基本工资:</label>
                        <input type="number" class="form-control" id="editbasicSalary" name="editbasicSalary" required>
                    </div>
                    <div class="form-group">
                        <label for="editovertimeSalary">加班工资:</label>
                        <input type="number" class="form-control" id="editovertimeSalary" name="editovertimeSalary" required>
                    </div>
                    <div class="form-group">
                        <label for="editfullAttendanceBonus">全勤奖:</label>
                        <input type="number" class="form-control" id="editfullAttendanceBonus" name="editfullAttendanceBonus" required>
                    </div>
                    <div class="form-group">
                        <label for="editpersonalTax">个人所得税:</label>
                        <input type="number" class="form-control" id="editpersonalTax" name="editpersonalTax" required>
                    </div>
                    <div class="form-group">
                        <label for="editnetSalary">实发工资:</label>
                        <input type="number" class="form-control" id="editnetSalary" name="editnetSalary" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">保存修改</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteSalaryModal" tabindex="-1" role="dialog" aria-labelledby="deleteSalaryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="deleteSalary.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteSalaryModalLabel">删除工资</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>确定要删除该员工的工资信息吗?</p>
                    <input type="hidden" id="deleteempNo" name="deleteempNo">
                    <input type="hidden" id="deleteyear" name="deleteyear">
                    <input type="hidden" id="deletemonth" name="deletemonth">
                    <input type="hidden" id="deletebasicSalary" name="deletebasicSalary">
                    <input type="hidden" id="deleteovertimePay" name="deleteovertimePay">
                    <input type="hidden" id="deletefullAttendanceBonus" name="deletefullAttendanceBonus">
                    <input type="hidden" id="deletepersonalTax" name="deletepersonalTax">
                    <input type="hidden" id="deletenetSalary" name="deletenetSalary">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-danger">删除</button>
                </div>
            </form>
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
                <div id="piechart" style="width: 100%; height: 400px;"></div>
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
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
    }
</script>

<script>
    // 当点击侧边栏链接时显示相应的内容部分
    function showSection(sectionId) {
        var sections = document.getElementsByClassName("content-section");
        for (var i = 0; i < sections.length; i++) {
            sections[i].style.display = "none";
        }
        document.getElementById(sectionId).style.display = "block";
    }

    // 当搜索框中的内容发生变化时，执行搜索函数
    $('#searchKeyword').on('input', function() {
        searchEmployees($(this).val());
    });

    // 搜索员工函数
    function searchEmployees(keyword) {
        var tableBody = $('#employeeTableBody');
        tableBody.empty(); // 清空表格内容

        // 假设这是你的员工数据，可以根据关键字进行搜索过滤
        var employees = [
            { id: 1, name: '张三', position: '软件工程师', basic: 10000, allowance: 2000, lunch: 300, overtime: 500, full: 1000, social: 800, housing: 500, tax: 1500, deduction: 200 },
            { id: 2, name: '李四', position: '产品经理', basic: 12000, allowance: 2500, lunch: 400, overtime: 600, full: 1200, social: 900, housing: 600, tax: 1700, deduction: 300 }
        ];

        // 根据关键字过滤员工信息
        var filteredEmployees = employees.filter(function(employee) {
            return employee.name.toLowerCase().includes(keyword.toLowerCase());
        });

        // 将搜索结果添加到表格中
        filteredEmployees.forEach(function(employee) {
            var row = '<tr>' +
                '<td>' + employee.empNo + '</td>' +
                '<td>' + employee.year + '</td>' +
                '<td>' + employee.month + '</td>' +
                '<td>' + employee.basic + '</td>' +
                '<td>' + employee.allowance + '</td>' +
                '<td>' + employee.lunch + '</td>' +
                '<td>' + employee.overtime + '</td>' +
                '<td>' + employee.full + '</td>' +
                '<td>' + employee.social + '</td>' +
                '<td>' + employee.housing + '</td>' +
                '<td>' + employee.tax + '</td>' +
                '<td>' + employee.deduction + '</td>' +
                '<td><button class="btn btn-warning" data-toggle="modx`al" data-target="#editSalaryModal" data-id="' + employee.id + '" data-name="' + employee.name + '" data-position="' + employee.position + '" data-basic="' + employee.basic + '" data-allowance="' + employee.allowance + '" data-lunch="' + employee.lunch + '" data-overtime="' + employee.overtime + '" data-full="' + employee.full + '" data-social="' + employee.social + '" data-housing="' + employee.housing + '" data-tax="' + employee.tax + '" data-deduction="' + employee.deduction + '">编辑</button></td>' +
                '</tr>';
            tableBody.append(row);
        });
    }

    $('#deleteSalaryModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var deleteempNo = button.data('deleteempNo');
        var deleteyear = button.data('deleteyear');
        var deletemonth = button.data('deletemonth');
        var deletebasicSalary = button.data('deletebasicSalary');
        var deleteovertimePay = button.data('deleteovertimePay');
        var deletefullAttendanceBonus = button.data('deletefullAttendanceBonus');
        var deletepersonalTax = button.data('deletepersonalTax');
        var deletenetSalary = button.data('deletenetSalary');

        var modal = $(this);
        modal.find('.modal-body #deleteempNo').val(deleteempNo);
        modal.find('.modal-body #deleteyear').val(deleteyear);
        modal.find('.modal-body #deletemonth').val(deletemonth);
        modal.find('.modal-body #deletebasicSalary').val(deletebasicSalary);
        modal.find('.modal-body #deleteovertimePay').val(deleteovertimePay);
        modal.find('.modal-body #deletefullAttendanceBonus').val(deletefullAttendanceBonus);
        modal.find('.modal-body #deletepersonalTax').val(deletepersonalTax);
        modal.find('.modal-body #deletenetSalary').val(deletenetSalary);
    });

    $('#editSalaryModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var editempNo = button.data('editempNo');
        var edityear = button.data('edityear');
        var editmonth = button.data('editmonth');
        var editbasicSalary = button.data('editbasicSalary');
        var editovertimePay = button.data('editovertimePay');
        var editfullAttendanceBonus = button.data('editfullAttendanceBonus');
        var editpersonalTax = button.data('editpersonalTax');
        var editnetSalary = button.data('editnetSalary');

        var modal = $(this);
        modal.find('.modal-body #editempNo').val(editempNo);
        modal.find('.modal-body #edityear').val(edityear);
        modal.find('.modal-body #editmonth').val(editmonth);
        modal.find('.modal-body #editbasicSalary').val(editbasicSalary);
        modal.find('.modal-body #editovertimePay').val(editovertimePay);
        modal.find('.modal-body #editfullAttendanceBonus').val(editfullAttendanceBonus);
        modal.find('.modal-body #editpersonalTax').val(editpersonalTax);
        modal.find('.modal-body #editneSalary').val(editnetSalary);
    });
</script>
<script>
    $(document).ready(function(){
        $('#addSalaryModal').on('hidden.bs.modal', function () {
            // 清空表单数据
            $('#addSalaryModalLabel')[0].reset();
        });
    });
</script>
<script>
    $(document).ready(function(){
        $('#addSalaryModal').on('hidden.bs.modal', function () {
            // 清空表单数据
            $('#addSalaryModalLabel')[0].reset();
        });
    });
</script>
<script>
    $(document).ready(function(){
        $('#addSalaryModal').on('hidden.bs.modal', function () {
            // 清空表单数据
            $('#addSalaryModalLabel')[0].reset();
        });
    });
</script>
<script>
    $(document).ready(function(){
        $('#addSalaryModal').on('hidden.bs.modal', function () {
            // 清空表单数据
            $('#addSalaryModalLabel')[0].reset();
        });
    });
</script>

</body>
</html>
