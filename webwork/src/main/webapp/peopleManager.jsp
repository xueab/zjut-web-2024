<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <a href="#" onclick="showSection('roleManagement')"><i class="fas fa-user-shield"></i>角色管理</a>
    <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
</div>

<div class="main">
    <div id="roleManagement" class="container content-section active">
        <h2>角色管理</h2>
        <form action="setRole.do" method="post">
            <div class="form-group">
                <label for="username">用户名:</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="role">角色:</label>
                <select class="form-control" id="role" name="role">
                    <option value="hrAdmin">人事管理员</option>
                    <option value="financeAdmin">财务管理员</option>
                    <option value="generalManager">总经理</option>
                    <option value="auditAdmin">审计管理员</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">设置角色</button>
        </form>
        <br>
        <br>
        <h3>所有用户及其角色</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>用户名</th>
                <th>角色</th>
            </tr>
            </thead>
            <tbody>
            <!-- 使用假数据展示 -->
            <tr>
                <td>zhangsan</td>
                <td>人事管理员</td>
            </tr>
            <tr>
                <td>lisi</td>
                <td>财务管理员</td>
            </tr>
            <tr>
                <td>wanger</td>
                <td>总经理</td>
            </tr>
            <tr>
                <td>mazi</td>
                <td>审计管理员</td>
            </tr>
            <!-- 可以根据需要添加更多假数据 -->
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


<script>
    function showSection(sectionId) {
        $('.content-section').removeClass('active');
        $('#' + sectionId).addClass('active');
    }

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