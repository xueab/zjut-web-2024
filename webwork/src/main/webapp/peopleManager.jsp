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
        <br><br>
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
        <br><br>
        <div class="chart-container">
            <canvas id="rolePieChart"></canvas>
        </div>
        <br><br>
        <h3>所有用户及其角色</h3>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>用户名</th>
                <th>角色</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="userRolesTable">
            <!-- 使用假数据展示 -->
            <tr>
                <td>zhangsan</td>
                <td>人事管理员</td>
                <td>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#editRoleModal" data-username="zhangsan" data-role="hrAdmin">修改</button>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#deleteRoleModal" data-username="zhangsan">删除</button>
                </td>
            </tr>
            <tr>
                <td>lisi</td>
                <td>财务管理员</td>
                <td>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#editRoleModal" data-username="lisi" data-role="financeAdmin">修改</button>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#deleteRoleModal" data-username="lisi">删除</button>
                </td>
            </tr>
            <tr>
                <td>wanger</td>
                <td>总经理</td>
                <td>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#editRoleModal" data-username="wanger" data-role="generalManager">修改</button>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#deleteRoleModal" data-username="wanger">删除</button>
                </td>
            </tr>
            <tr>
                <td>mazi</td>
                <td>审计管理员</td>
                <td>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#editRoleModal" data-username="mazi" data-role="auditAdmin">修改</button>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#deleteRoleModal" data-username="mazi">删除</button>
                </td>
            </tr>
            <!-- 可以根据需要添加更多假数据 -->
            </tbody>
        </table>
        <button class="btn btn-success" data-toggle="modal" data-target="#addRoleModal">添加角色</button>
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

<div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog" aria-labelledby="addRoleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="addRole.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addRoleModalLabel">添加角色</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="add-username">用户名:</label>
                        <input type="text" class="form-control" id="add-username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="add-role">角色:</label>
                        <select class="form-control" id="add-role" name="role">
                            <option value="hrAdmin">人事管理员</option>
                            <option value="financeAdmin">财务管理员</option>
                            <option value="generalManager">总经理</option>
                            <option value="auditAdmin">审计管理员</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">提交</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="editRoleModal" tabindex="-1" role="dialog" aria-labelledby="editRoleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="editRole.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editRoleModalLabel">修改角色</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="edit-username" name="username">
                    <div class="form-group">
                        <label for="edit-role">角色:</label>
                        <select class="form-control" id="edit-role" name="role">
                            <option value="hrAdmin">人事管理员</option>
                            <option value="financeAdmin">财务管理员</option>
                            <option value="generalManager">总经理</option>
                            <option value="auditAdmin">审计管理员</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">提交</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteRoleModal" tabindex="-1" role="dialog" aria-labelledby="deleteRoleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="deleteRole.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteRoleModalLabel">删除角色</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>确定要删除此角色吗？</p>
                    <input type="hidden" id="delete-username" name="username">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-danger">删除</button>
                </div>
            </form>
        </div>
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

    $('#editRoleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var username = button.data('username');
        var role = button.data('role');

        var modal = $(this);
        modal.find('#edit-username').val(username);
        modal.find('#edit-role').val(role);
    });

    $('#deleteRoleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var username = button.data('username');

        var modal = $(this);
        modal.find('#delete-username').val(username);
    });

    document.addEventListener('DOMContentLoaded', function () {
        var ctx = document.getElementById('rolePieChart').getContext('2d');

        // 假设这些是从服务器获取的角色数据
        var roleData = {
            hrAdmin: 10,
            financeAdmin: 5,
            generalManager: 3,
            auditAdmin: 2
        };

        var roleLabels = ['人事管理员', '财务管理员', '总经理', '审计管理员'];
        var roleValues = [roleData.hrAdmin, roleData.financeAdmin, roleData.generalManager, roleData.auditAdmin];
        var roleColors = ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0'];

        var rolePieChart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: roleLabels,
                datasets: [{
                    data: roleValues,
                    backgroundColor: roleColors
                }]
            },
            options: {
                responsive: true,
                legend: {
                    position: 'top',
                },
                title: {
                    display: true,
                    text: '角色分布'
                },
                animation: {
                    animateScale: true,
                    animateRotate: true
                }
            }
        });
    });

</script>
</body>
</html>