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
<div class="sidebar">
    <a href="#" onclick="showSection('viewSalaries')"><i class="fas fa-money-check-alt"></i>查看工资</a>
    <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
</div>

<div id="viewSalaries" class="container content-section active">
    <h2>查看工资</h2>
    <!-- 搜索框 -->
    <div class="form-group">
        <input type="text" class="form-control" id="searchKeyword" placeholder="输入关键字搜索">
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
        <tbody id="employeeTableBody">
        <!-- 这里是搜索结果，初始展示全部员工信息 -->
        <tr>
            <td>1</td>
            <td>张三</td>
            <td>软件工程师</td>
            <td>10000</td>
            <td>2000</td>
            <td>300</td>
            <td>500</td>
            <td>1000</td>
            <td>800</td>
            <td>500</td>
            <td>1500</td>
            <td>200</td>
            <td><button class="btn btn-warning" data-toggle="modal" data-target="#editSalaryModal" data-id="1" data-name="张三" data-position="软件工程师" data-basic="10000" data-allowance="2000" data-lunch="300" data-overtime="500" data-full="1000" data-social="800" data-housing="500" data-tax="1500" data-deduction="200">编辑</button></td>
        </tr>
        <tr>
            <td>2</td>
            <td>李四</td>
            <td>产品经理</td>
            <td>12000</td>
            <td>2500</td>
            <td>400</td>
            <td>600</td>
            <td>1200</td>
            <td>900</td>
            <td>600</td>
            <td>1700</td>
            <td>300</td>
            <td><button class="btn btn-warning" data-toggle="modal" data-target="#editSalaryModal" data-id="2" data-name="李四" data-position="产品经理" data-basic="12000" data-allowance="2500" data-lunch="400" data-overtime="600" data-full="1200" data-social="900" data-housing="600" data-tax="1700" data-deduction="300">编辑</button></td>
        </tr>
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
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存更改</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // 当点击侧边栏链接时显示相应的内容部分
    function showSection(sectionId) {
        $('.content-section').removeClass('active');
        $('#' + sectionId).addClass('active');
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

    $('#editSalaryModal').on('show.bs.modal', function(event) {
        var button = $(event.relatedTarget); // 触发模态框的按钮
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
        modal.find('#edit-id').val(id);
        modal.find('#edit-name').val(name);
        modal.find('#edit-position').val(position);
        modal.find('#edit-basic').val(basic);
        modal.find('#edit-allowance').val(allowance);
        modal.find('#edit-lunch').val(lunch);
        modal.find('#edit-overtime').val(overtime);
        modal.find('#edit-full').val(full);
        modal.find('#edit-social').val(social);
        modal.find('#edit-housing').val(housing);
        modal.find('#edit-tax').val(tax);
        modal.find('#edit-deduction').val(deduction);
    });
</script>
</body>
</html>
