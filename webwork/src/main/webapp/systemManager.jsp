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
    <a href="#" onclick="showSection('roleManagement')"><i class="fas fa-user-shield"></i>角色管理</a>
    <a href="#" onclick="showSection('viewSalaries')"><i class="fas fa-money-check-alt"></i>查看工资</a>
    <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
</div>

<div class="main">
    <div id="roleManagement" class="container content-section active">
        <h2>角色管理</h2>
        <br><br>
        <button class="btn btn-info" data-toggle="modal" data-target="#rolePieChartModal">显示饼状图</button>
        <br><br>
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
            <c:forEach var="userRole" items="${list}">
                <tr>
                    <td>${userRole.username}</td>
                    <td>${userRole.role}</td>
                    <td>
                        <button class="btn btn-warning" data-toggle="modal" data-target="#editRoleModal" data-username="${userRole.username}" data-role="${userRole.role}">修改</button>
                        <button class="btn btn-danger" data-toggle="modal" data-target="#deleteRoleModal" data-username="${userRole.username}">删除</button>
                    </td>
                </tr>
            </c:forEach>
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
            <button type="submit" class="btn btn-primary">提交</button>
        </form>
    </div>
</div>

<!-- Add Role Modal -->
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
                        <label for="addUsername">用户名:</label>
                        <input type="text" class="form-control" id="addUsername" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="addRole">角色:</label>
                        <select class="form-control" id="addRole" name="role">
                            <option value="hrAdmin">人事管理员</option>
                            <option value="financeAdmin">财务管理员</option>
                            <option value="generalManager">总经理</option>
                            <option value="auditAdmin">审计管理员</option>
                        </select>
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

<div class="modal fade" id="editRoleModal" tabindex="-1" role="dialog" aria-labelledby="editRoleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="editRole.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editRoleModalLabel">设置角色</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="editUsername">用户名：</label>
                        <input type="text" class="form-control" id="editUsername" name="username" readonly>
                    </div>
                    <div class="form-group">
                        <label for="editRole">角色：</label>
                        <select class="form-control" id="editRole" name="role">
                            <option value="hrAdmin">人事管理员</option>
                            <option value="financeAdmin">财务管理员</option>
                            <option value="generalManager">总经理</option>
                            <option value="auditAdmin">系统管理员</option>
                        </select>
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
                    <input type="hidden" id="deleteUsername" name="username">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-danger">删除</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="rolePieChartModal" tabindex="-1" role="dialog" aria-labelledby="rolePieChartModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="rolePieChartModalLabel">角色分布</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <canvas id="rolePieChart"></canvas>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>
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

    $('#editRoleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var username = button.data('username');
        var role = button.data('role');
        var modal = $(this);
        modal.find('#editUsername').val(username);
        modal.find('#editRole').val(role);
    });

    $('#deleteRoleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var username = button.data('username');
        var modal = $(this);
        modal.find('#deleteUsername').val(username);
    });

    // 添加绘制饼状图的JavaScript代码
    document.addEventListener('DOMContentLoaded', function () {
        $('#rolePieChartModal').on('shown.bs.modal', function () {
            var ctx = document.getElementById('rolePieChart').getContext('2d');

            // 从JSP中获取角色数据
            var roleData = {
                hrAdmin: ${hrAdminCount},
                financeAdmin: ${financeAdminCount},
                generalManager: ${generalManagerCount},
                auditAdmin: ${auditAdminCount}
            };

            var roleLabels = ['人事管理员', '财务管理员', '总经理', '审计管理员'];
            var roleValues = [roleData.hrAdmin, roleData.financeAdmin, roleData.generalManager, roleData.auditAdmin];
            var roleColors = ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0'];

            // 如果之前已经创建过饼图实例，销毁它
            if (window.rolePieChartInstance) {
                window.rolePieChartInstance.destroy();
            }

            // 创建新的饼状图实例
            window.rolePieChartInstance = new Chart(ctx, {
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
    });

</script>
</body>
</html>