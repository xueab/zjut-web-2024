<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Financial Manager Dashboard</title>
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
%>//读入账号登录的username属性
<div class="sidebar">
    <a href="#" onclick="showSection('viewSalaries')"><i class="fas fa-money-check-alt"></i>查看工资</a>
    <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
</div>

<div id="viewSalaries" class="container content-section">
    <h2>查看工资</h2>
    <br>
    <div class="form-group">
        <input type="text" class="form-control" id="searchInput" placeholder="搜索员工姓名">
    </div>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>员工ID</th>
            <th>姓名</th>
            <th>职位</th>
            <th>基本工资</th>
            <th>岗位津贴</th>
            <th>午餐补贴</th>
            <th>加班工资</th>
            <th>全勤工资</th>
            <th>社保</th>
            <th>公积金</th>
            <th>个人所得税</th>
            <th>迟到/请假扣款</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="salary" items="${salaryList}">
            <tr>
                <td>${salary.id}</td>
                <td>${salary.name}</td>
                <td>${salary.position}</td>
                <td>${salary.basicSalary}</td>
                <td>${salary.allowance}</td>
                <td>${salary.lunchSubsidy}</td>
                <td>${salary.overtimeSalary}</td>
                <td>${salary.fullAttendanceSalary}</td>
                <td>${salary.socialSecurity}</td>
                <td>${salary.housingFund}</td>
                <td>${salary.personalIncomeTax}</td>
                <td>${salary.otherDeductions}</td>
                <td>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#editSalaryModal" data-id="${salary.id}" data-name="${salary.name}" data-position="${salary.position}" data-basic="${salary.basicSalary}" data-allowance="${salary.allowance}" data-lunch="${salary.lunchSubsidy}" data-overtime="${salary.overtimeSalary}" data-full="${salary.fullAttendanceSalary}" data-social="${salary.socialSecurity}" data-housing="${salary.housingFund}" data-tax="${salary.personalIncomeTax}" data-deduction="${salary.otherDeductions}">编辑</button>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#deleteSalaryModal" data-id="${salary.id}">删除</button>
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
                        <label for="addEmployeeId">员工ID:</label>
                        <input type="text" class="form-control" id="addEmployeeId" name="id" required>
                    </div>
                    <div class="form-group">
                        <label for="addEmployeeName">姓名:</label>
                        <input type="text" class="form-control" id="addEmployeeName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="addEmployeePosition">职位:</label>
                        <input type="text" class="form-control" id="addEmployeePosition" name="position" required>
                    </div>
                    <div class="form-group">
                        <label for="addBasicSalary">基本工资:</label>
                        <input type="number" class="form-control" id="addBasicSalary" name="basicSalary" required>
                    </div>
                    <div class="form-group">
                        <label for="addAllowance">岗位津贴:</label>
                        <input type="number" class="form-control" id="addAllowance" name="allowance" required>
                    </div>
                    <div class="form-group">
                        <label for="addLunchSubsidy">午餐补贴:</label>
                        <input type="number" class="form-control" id="addLunchSubsidy" name="lunchSubsidy" required>
                    </div>
                    <div class="form-group">
                        <label for="addOvertimeSalary">加班工资:</label>
                        <input type="number" class="form-control" id="addOvertimeSalary" name="overtimeSalary" required>
                    </div>
                    <div class="form-group">
                        <label for="addFullAttendanceSalary">全勤工资:</label>
                        <input type="number" class="form-control" id="addFullAttendanceSalary" name="fullAttendanceSalary" required>
                    </div>
                    <div class="form-group">
                        <label for="addSocialSecurity">社保:</label>
                        <input type="number" class="form-control" id="addSocialSecurity" name="socialSecurity" required>
                    </div>
                    <div class="form-group">
                        <label for="addHousingFund">公积金:</label>
                        <input type="number" class="form-control" id="addHousingFund" name="housingFund" required>
                    </div>
                    <div class="form-group">
                        <label for="addPersonalIncomeTax">个人所得税:</label>
                        <input type="number" class="form-control" id="addPersonalIncomeTax" name="personalIncomeTax" required>
                    </div>
                    <div class="form-group">
                        <label for="addOtherDeductions">其他扣款:</label>
                        <input type="number" class="form-control" id="addOtherDeductions" name="otherDeductions" required>
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

<div class="modal fade" id="editSalaryModal" tabindex="-1" role="dialog" aria-labelledby="editSalaryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="editSalary.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editSalaryModalLabel">编辑工资</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="edit-id" name="id">
                    <div class="form-group">
                        <label for="edit-name">姓名:</label>
                        <input type="text" class="form-control" id="edit-name" name="name" readonly>
                    </div>
                    <div class="form-group">
                        <label for="edit-position">职位:</label>
                        <input type="text" class="form-control" id="edit-position" name="position" readonly>
                    </div>
                    <div class="form-group">
                        <label for="edit-basic">基本工资:</label>
                        <input type="number" class="form-control" id="edit-basic" name="basic" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-allowance">岗位津贴:</label>
                        <input type="number" class="form-control" id="edit-allowance" name="allowance" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-lunch">午餐补贴:</label>
                        <input type="number" class="form-control" id="edit-lunch" name="lunch" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-overtime">加班工资:</label>
                        <input type="number" class="form-control" id="edit-overtime" name="overtime" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-full">全勤工资:</label>
                        <input type="number" class="form-control" id="edit-full" name="full" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-social">社保:</label>
                        <input type="number" class="form-control" id="edit-social" name="social" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-housing">公积金:</label>
                        <input type="number" class="form-control" id="edit-housing" name="housing" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-tax">个人所得税:</label>
                        <input type="number" class="form-control" id="edit-tax" name="tax" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-deduction">迟到/请假扣款:</label>
                        <input type="number" class="form-control" id="edit-deduction" name="deduction" required>
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
                    <input type="hidden" id="deleteSalaryId" name="id">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-danger">删除</button>
                </div>
            </form>
        </div>
    </div>
</div>

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
                '<td>' + employee.id + '</td>' +
                '<td>' + employee.name + '</td>' +
                '<td>' + employee.position + '</td>' +
                '<td>' + employee.basic + '</td>' +
                '<td>' + employee.allowance + '</td>' +
                '<td>' + employee.lunch + '</td>' +
                '<td>' + employee.overtime + '</td>' +
                '<td>' + employee.full + '</td>' +
                '<td>' + employee.social + '</td>' +
                '<td>' + employee.housing + '</td>' +
                '<td>' + employee.tax + '</td>' +
                '<td>' + employee.deduction + '</td>' +
                '<td><button class="btn btn-warning" data-toggle="modal" data-target="#editSalaryModal" data-id="' + employee.id + '" data-name="' + employee.name + '" data-position="' + employee.position + '" data-basic="' + employee.basic + '" data-allowance="' + employee.allowance + '" data-lunch="' + employee.lunch + '" data-overtime="' + employee.overtime + '" data-full="' + employee.full + '" data-social="' + employee.social + '" data-housing="' + employee.housing + '" data-tax="' + employee.tax + '" data-deduction="' + employee.deduction + '">编辑</button></td>' +
                '</tr>';
            tableBody.append(row);
        });
    }

    $('#deleteSalaryModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var id = button.data('id');

        var modal = $(this);
        modal.find('.modal-body #salaryId').val(id);
    });

    $('#editSalaryModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var id = button.data('id');
        var name = button.data('name');
        var position = button.data('position');
        var basic = button.data('basic');
        var allowance = button.data('allowance');
        var lunch = button.data('lunch');
        var overtime = button.data('overtime');
        var full = button.data('full');
        var social = button.data('social');
        var housing = button.data('housing');
        var tax = button.data('tax');
        var deduction = button.data('deduction');

        var modal = $(this);
        modal.find('.modal-body #salaryId').val(id);
        modal.find('.modal-body #name').val(name);
        modal.find('.modal-body #position').val(position);
        modal.find('.modal-body #basicSalary').val(basic);
        modal.find('.modal-body #allowance').val(allowance);
        modal.find('.modal-body #lunchSubsidy').val(lunch);
        modal.find('.modal-body #overtimeSalary').val(overtime);
        modal.find('.modal-body #fullAttendanceSalary').val(full);
        modal.find('.modal-body #socialSecurity').val(social);
        modal.find('.modal-body #housingFund').val(housing);
        modal.find('.modal-body #personalIncomeTax').val(tax);
        modal.find('.modal-body #otherDeductions').val(deduction);
    });
</script>
</body>
</html>
