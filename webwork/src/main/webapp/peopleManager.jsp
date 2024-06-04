<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
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
%>//读入登录账号的username属性
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
            <form action="addempoyee.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addemployeeModalLabel">添加员工</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addemployeename">姓名:</label>
                        <input type="text" class="form-control" id="addemployeename" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="addemployeeempno">编号:</label>
                        <input type="text" class="form-control" id="addemployeeempno" name="empno" required>
                    </div>
                    <div class="form-group">
                        <label for="addemployeedepName">部门:</label>
                        <input type="text" class="form-control" id="addemployeedepName" name="depName" required>
                    </div>
                    <div class="form-group">
                        <label for="addemployeeposition">职务:</label>
                        <input type="text" class="form-control" id="addemployeeposition" name="position" required>
                    </div>
                    <div class="form-group">
                        <label for="addemployeeidNumber">身份证号:</label>
                        <input type="text" class="form-control" id="addemployeeidNumber" name="idNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="addemployeephone">电话号码:</label>
                        <input type="text" class="form-control" id="addemployeephone" name="phone" required>
                    </div>
                    <div class="form-group">
                        <label for="addemployeeaddress">地址:</label>
                        <input type="text" class="form-control" id="addemployeeaddress" name="address" required>
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

<div class="modal fade" id="editemployeeModal" tabindex="-1" role="dialog" aria-labelledby="editemployeeModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="editemployee.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editemployeeModalLabel">编辑员工</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="edit-name">姓名:</label>
                        <input type="text" class="form-control" id="edit-name" name="name" readonly>
                    </div>
                    <div class="form-group">
                        <label for="edit-empNo">编号:</label>
                        <input type="text" class="form-control" id="edit-empNo" name="empNo" readonly>
                    </div>
                    <div class="form-group">
                        <label for="edit-depName">部门:</label>
                        <input type="number" class="form-control" id="edit-depName" name="depName" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-position">职务:</label>
                        <input type="number" class="form-control" id="edit-position" name="position" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-idNumber">身份证号:</label>
                        <input type="number" class="form-control" id="edit-idNumber" name="idNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-phone">电话:</label>
                        <input type="number" class="form-control" id="edit-phone" name="phone" required>
                    </div>
                    <div class="form-group">
                        <label for="edit-address">地址:</label>
                        <input type="number" class="form-control" id="edit-address" name="address" required>
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
                    <p>确定要删除此员工吗？</p>
                    <input type="hidden" id="deleteempno" name="empno">
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
    function showSection(sectionId) {
        var sections = document.getElementsByClassName("content-section");
        for (var i = 0; i < sections.length; i++) {
            sections[i].style.display = "none";
        }
        document.getElementById(sectionId).style.display = "block";
    }

    $('#editempolyeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var name = button.data('name');
        var empno = button.data('empno');
        var depName = button.data('depName');
        var position = button.data('position');
        var idNumber = button.data('idNumber');
        var phone = button.data('phone');
        var address = button.data('address');
        var modal = $(this);
        modal.find('#editname').val(name);
        modal.find('#editempno').val(empno);
        modal.find('#editdepName').val(depName);
        modal.find('#editposition').val(position);
        modal.find('#editidNumber').val(idNumber);
        modal.find('#editphone').val(phone);
        modal.find('#editaddress').val(address);
    });

    $('#editemployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var name = button.data('name');
        var empno = button.data('empno');
        var depName = button.data('depName');
        var position = button.data('position');
        var idNumber = button.data('idNumber');
        var phone = button.data('phone');
        var address = button.data('address');

        var modal = $(this);
        modal.find('.modal-body #name').val(name);
        modal.find('.modal-body #empno').val(empno);
        modal.find('.modal-body #depName').val(depName);
        modal.find('.modal-body #position').val(position);
        modal.find('.modal-body #idNumber').val(idNumber);
        modal.find('.modal-body #phone').val(phone);
        modal.find('.modal-body #address').val(address);
    });

    $('#deleteRoleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var empno = button.data('empno');
        var modal = $(this);
        modal.find('#deleteempno').val(empno);
    });

</script>
</body>
</html>