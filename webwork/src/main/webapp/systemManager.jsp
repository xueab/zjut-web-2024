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
<div class="sidebar">
    <a href="#" onclick="showSection('roleManagement')"><i class="fas fa-user-shield"></i>角色管理</a>
    <a href="#" onclick="showSection('viewSalaries')"><i class="fas fa-money-check-alt"></i>查看工资</a>
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

    <div id="viewSalaries" class="container content-section">
        <h2>查看工资</h2>
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
                <td>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#editSalaryModal" data-id="1" data-name="张三" data-position="软件工程师" data-basic="10000" data-allowance="2000" data-lunch="300" data-overtime="500" data-full="1000" data-social="800" data-housing="500" data-tax="1500" data-deduction="200">编辑</button>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#deleteSalaryModal" data-id="1">删除</button>
                </td>
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
                <td>
                    <button class="btn btn-warning" data-toggle="modal" data-target="#editSalaryModal" data-id="2" data-name="李四" data-position="产品经理" data-basic="12000" data-allowance="2500" data-lunch="400" data-overtime="600" data-full="1200" data-social="900" data-housing="600" data-tax="1700" data-deduction="300">编辑</button>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#deleteSalaryModal" data-id="2">删除</button>
                </td>
            </tr>
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

<div class="modal fade" id="addSalaryModal" tabindex="-1" role="dialog" aria-labelledby="addSalaryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="addSalary.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addSalaryModalLabel">添加工资</h5>
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
<!-- Edit Role Modal -->
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
    function showSection(sectionId) {
        $('.content-section').removeClass('active');
        $('#' + sectionId).addClass('active');
    }

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

    $('#deleteSalaryModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var id = button.data('id');
        var modal = $(this);
        modal.find('#deleteSalaryId').val(id);
    });


    // 添加绘制饼状图的JavaScript代码
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