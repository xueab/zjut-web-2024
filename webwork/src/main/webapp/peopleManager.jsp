<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>人事管理员</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 18px;
            color: white;
            display: block;
        }
        .sidebar a i {
            margin-right: 10px;
        }
        .sidebar a:hover {
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
            width: 50%;
            margin: auto;
        }
    </style>
</head>
<body>
<%
    String username = request.getParameter("username");
%>
<div class="sidebar">
    <a href="#" onclick="showSection('employeeManagement')"><i class="fas fa-user-shield"></i>角色管理</a>
    <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
</div>

<div class="main">
    <div id="employeeManagement" class="container content-section active">
        <h2>员工管理</h2>
        <br><br>
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
                <th>职务</th>
                <th>身份证号</th>
                <th>手机号</th>
                <th>住址</th>
                <th>操作</th>
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
                    <td>
                        <button class="btn btn-warning" data-toggle="modal" data-target="#editemployeeModal" data-name="${employeeRole.name}" data-empno="${employeeRole.empNo}" data-depName="${employeeRole.depName}" data-position="${employeeRole.position}" data-idNumber="${employeeRole.idNumber}" data-phone="${employeeRole.phone}" data-address="${employeeRole.address}">修改</button>
                        <button class="btn btn-danger" data-toggle="modal" data-target="#deleteemployeeModal" data-username="${employeeRole.name}">删除</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <button class="btn btn-success" data-toggle="modal" data-target="#addemployeeModal">添加员工</button>
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

<div class="modal fade" id="addemployeeModal" tabindex="-1" role="dialog" aria-labelledby="addemployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="addemployee.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addemployeeModalLabel">添加员工</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addName">姓名:</label>
                        <input type="text" class="form-control" id="addName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="addEmpNo">员工编号:</label>
                        <input type="text" class="form-control" id="addEmpNo" name="empNo" required>
                    </div>
                    <div class="form-group">
                        <label for="addDepName">部门:</label>
                        <input type="text" class="form-control" id="addDepName" name="depName" required>
                    </div>
                    <div class="form-group">
                        <label for="addPosition">职务:</label>
                        <input type="text" class="form-control" id="addPosition" name="position" required>
                    </div>
                    <div class="form-group">
                        <label for="addIdNumber">身份证号:</label>
                        <input type="text" class="form-control" id="addIdNumber" name="idNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="addPhone">手机号:</label>
                        <input type="text" class="form-control" id="addPhone" name="phone" required>
                    </div>
                    <div class="form-group">
                        <label for="addAddress">住址:</label>
                        <input type="text" class="form-control" id="addAddress" name="address" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">添加</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="editemployeeModal" tabindex="-1" role="dialog" aria-labelledby="editemployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="updateemployee.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editemployeeModalLabel">修改员工信息</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="editName">姓名:</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="editEmpNo">员工编号:</label>
                        <input type="text" class="form-control" id="editEmpNo" name="empNo" required>
                    </div>
                    <div class="form-group">
                        <label for="editDepName">部门:</label>
                        <input type="text" class="form-control" id="editDepName" name="depName" required>
                    </div>
                    <div class="form-group">
                        <label for="editPosition">职务:</label>
                        <input type="text" class="form-control" id="editPosition" name="position" required>
                    </div>
                    <div class="form-group">
                        <label for="editIdNumber">身份证号:</label>
                        <input type="text" class="form-control" id="editIdNumber" name="idNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="editPhone">手机号:</label>
                        <input type="text" class="form-control" id="editPhone" name="phone" required>
                    </div>
                    <div class="form-group">
                        <label for="editAddress">住址:</label>
                        <input type="text" class="form-control" id="editAddress" name="address" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteemployeeModal" tabindex="-1" role="dialog" aria-labelledby="deleteemployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="deleteemployee.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteemployeeModalLabel">删除员工</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="deleteName" name="name">
                    <p>确定要删除这个员工吗?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-danger">删除</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="employeePieChartModal" tabindex="-1" role="dialog" aria-labelledby="employeePieChartModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="employeePieChartModalLabel">部门员工比例饼状图</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <canvas id="departmentPieChart"></canvas>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script>
    $('#deleteemployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var name = button.data('username');
        var modal = $(this);
        modal.find('#deleteName').val(name);
    });

    $('#editemployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var name = button.data('name');
        var empNo = button.data('empno');
        var depName = button.data('depname');
        var position = button.data('position');
        var idNumber = button.data('idnumber');
        var phone = button.data('phone');
        var address = button.data('address');
        var modal = $(this);
        modal.find('#editName').val(name);
        modal.find('#editEmpNo').val(empNo);
        modal.find('#editDepName').val(depName);
        modal.find('#editPosition').val(position);
        modal.find('#editIdNumber').val(idNumber);
        modal.find('#editPhone').val(phone);
        modal.find('#editAddress').val(address);
    });

    function showSection(sectionId) {
        $('.content-section').removeClass('active');
        $('#' + sectionId).addClass('active');
    }

    function renderPieChart(data) {
        // 创建数据表
        data = google.visualization.arrayToDataTable([
            ['Department', 'Percentage'],
            <c:forEach var="entry" items="${departmentStats}">
            ['${entry.key}', ${entry.value}],
            </c:forEach>
        ]);

        // 设置图表选项
        var options = {
            title: 'Department Statistics'
        };

        // 创建并绘制图表
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
    }

    $('#employeePieChartModal').on('show.bs.modal', function () {
        $.ajax({
            url: 'showEmployeeServlet?action=getDepartmentStats',
            method: 'GET',
            dataType: 'json',
            success: function (data) {
                renderPieChart(data);
            }
        });
    });
</script>
</body>
</html>
