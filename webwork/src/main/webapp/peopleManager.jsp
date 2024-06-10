<%@ page import="service.EmployeeService" %>
<%@ page import="model.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<body>
<%
    String username = request.getParameter("username");
%>
<div class="sidebar">
    <a href="#" onclick="showSection('employeeManagement')"><i class="fas fa-user-shield"></i>角色管理</a>
    <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#logoutModal">
        <i class="fas fa-sign-out-alt"></i> 退出登录
    </button>
</div>
<div class="main">
    <div id="employeeManagement" class="container content-section active">
        <h2>员工管理</h2>
        <br><br>
        <button class="btn btn-info" data-toggle="modal" data-target="#employeePieChartModal">显示饼状图</button>
        <br><br>
        <h3>所有员工</h3>
        <%
            int currentpage = 1;
            int pagesize = 10; // 每页显示10个员工
            int totalpages = 0;


            // 获取请求参数中的页码
            if (request.getParameter("currentpage") != null) {
                try {
                    currentpage = Integer.parseInt(request.getParameter("currentpage"));
                } catch (NumberFormatException e) {
                    currentpage = 1; // 如果参数不是有效的整数，默认显示第一页
                }
            }
            EmployeeService employeeService = new EmployeeService();
            List<Employee> employees = employeeService.selectAll();
            List<Employee> employee = employeeService.selectByPage(currentpage-1);
            totalpages = (int) Math.ceil(employees.size() / (double) pagesize);
            request.setAttribute("employee", employee);
        %>
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
                        <button class="btn btn-warning" data-toggle="modal" data-target="#editemployeeModal"
                                data-name="${employeeRole.name}" data-empno="${employeeRole.empNo}"
                                data-depname="${employeeRole.depName}" data-position="${employeeRole.position}"
                                data-idnumber="${employeeRole.idNumber}" data-phone="${employeeRole.phone}"
                                data-address="${employeeRole.address}">修改</button>
                        <button class="btn btn-danger" data-toggle="modal" data-target="#deleteemployeeModal"
                                data-name="${employeeRole.name}" data-empno="${employeeRole.empNo}"
                                data-depname="${employeeRole.depName}" data-position="${employeeRole.position}"
                                data-idnumber="${employeeRole.idNumber}" data-phone="${employeeRole.phone}"
                                data-address="${employeeRole.address}">删除</button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div>
            <ul class="pagination">
                <%
                    int startPage = Math.max(1, currentpage - 2);
                    int endPage = Math.min(totalpages, currentpage + 2);

                    if (currentpage > 1) {
                %>
                <li class="page-item">
                    <a class="page-link" href="peopleManager.jsp?currentpage=<%= currentpage - 1 %>">上一页</a>
                </li>
                <%
                    }
                    for (int i = startPage; i <= endPage; i++) {
                %>
                <li class="page-item <%= (i == currentpage) ? "active" : "" %>">
                    <a class="page-link" href="peopleManager.jsp?currentpage=<%= i %>"><%= i %></a>
                </li>
                <%
                    }
                    if (currentpage < totalpages) {
                %>
                <li class="page-item">
                    <a class="page-link" href="peopleManager.jsp?currentpage=<%= currentpage + 1 %>">下一页</a>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
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
                    <input type="text" class="form-control" name="name" placeholder="姓名" required>
                    <input type="text" class="form-control" name="empNo" placeholder="员工编号" required>
                    <input type="text" class="form-control" name="depName" placeholder="部门" required>
                    <input type="text" class="form-control" name="position" placeholder="职务" required>
                    <input type="text" class="form-control" name="idNumber" placeholder="身份证号" required>
                    <input type="text" class="form-control" name="phone" placeholder="手机号" required>
                    <input type="text" class="form-control" name="address" placeholder="住址" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
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
                    <input type="hidden" name="empNo" id="deleteEmpNo">
                    <p>你确定要删除该员工吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-danger">删除</button>
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
                    <input type="hidden" name="oldEmpNo" id="editOldEmpNo">
                    <input type="text" class="form-control" name="name" id="editName" placeholder="姓名" required>
                    <input type="text" class="form-control" name="empNo" id="editEmpNo" placeholder="员工编号" required>
                    <input type="text" class="form-control" name="depName" id="editDepName" placeholder="部门" required>
                    <input type="text" class="form-control" name="position" id="editPosition" placeholder="职务" required>
                    <input type="text" class="form-control" name="idNumber" id="editIdNumber" placeholder="身份证号" required>
                    <input type="text" class="form-control" name="phone" id="editPhone" placeholder="手机号" required>
                    <input type="text" class="form-control" name="address" id="editAddress" placeholder="住址" required>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
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
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="employeePieChartModalLabel">员工分布饼状图</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="employeePieChart"></div>
            </div>
        </div>
    </div>
</div>

<script>
    function showSection(sectionId) {
        document.querySelectorAll('.content-section').forEach(section => {
            section.classList.remove('active');
        });
        document.getElementById(sectionId).classList.add('active');
    }

    $('#editemployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var modal = $(this);
        modal.find('#editOldEmpNo').val(button.data('empno'));
        modal.find('#editName').val(button.data('name'));
        modal.find('#editEmpNo').val(button.data('empno'));
        modal.find('#editDepName').val(button.data('depname'));
        modal.find('#editPosition').val(button.data('position'));
        modal.find('#editIdNumber').val(button.data('idnumber'));
        modal.find('#editPhone').val(button.data('phone'));
        modal.find('#editAddress').val(button.data('address'));
    });

    $('#deleteemployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var modal = $(this);
        modal.find('#deleteEmpNo').val(button.data('empno'));
    });

    function confirmLogout() {
        window.location.href = 'login.jsp';
    }

    $('#employeePieChartModal').on('shown.bs.modal', function () {
        $.ajax({
            url: 'employeeChartData.do',
            type: 'GET',
            success: function (data) {
                drawPieChart(data);
            },
            error: function (error) {
                console.error('Error fetching employee data', error);
            }
        });
    });

    function drawPieChart(data) {
        google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(function() {
            var chartData = [['部门', '人数']];
            for (var dep in data) {
                chartData.push([dep, data[dep]]);
            }
            var dataTable = google.visualization.arrayToDataTable(chartData);
            var options = {
                title: '员工分布情况',
                pieHole: 0.4
            };
            var chart = new google.visualization.PieChart(document.getElementById('employeePieChart'));
            chart.draw(dataTable, options);
        });
    }
</script>
</body>
</html>
