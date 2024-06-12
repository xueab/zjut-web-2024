<%@ page import="service.UserService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="service.SalaryService" %>
<%@ page import="model.Salary" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>系统管理员</title>
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
    request.getParameter("username");
%>
<div class="sidebar">
    <a href="systemManager.jsp?section=roleManagement" onclick="showSection('roleManagement')"><i class="fas fa-user-shield"></i>角色管理</a>
    <a href="systemManager.jsp?section=viewSalaries" onclick="showSection('viewSalaries')"><i class="fas fa-money-check-alt"></i>查看工资</a>
    <a href="systemManager.jsp?section=changePassword" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
    <button class="btn btn-info" data-toggle="modal" data-target="#salaryPieChartModal">
        <i class="fas fa-chart-pie"></i>员工工资分布饼状图
    </button>
    <button class="btn btn-primary" onclick="window.location.href='exportExcelServlet'"><i class="fas fa-file-export"></i> 导出</button>
    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#logoutModal">
        <i class="fas fa-sign-out-alt"></i> 退出登录
    </button>
</div>

<div class="main">
    <div id="roleManagement" class="container content-section active">
        <%
            int currentpage = 1;
            int pagesize = 10; // 每页显示10条记录
            int totalpages = 0;
            UserService userService = new UserService();
            if (request.getParameter("currentpage") != null) {
                try {
                    currentpage = Integer.parseInt(request.getParameter("currentpage"));
                } catch (NumberFormatException e) {
                    currentpage = 1; // 如果参数不是有效的整数，默认显示第一页
                }
            }
            List<model.User> user = userService.selectAll();
            List<model.User> users = userService.selectByPage(currentpage-1);
            request.setAttribute("users", users);
            request.setAttribute("user", user);
            totalpages = (int) Math.ceil(user.size() / (double) pagesize);
        %>
        <h2>所有用户及其角色</h2>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>用户名</th>
                <th>角色</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="userRolesTable">
            <c:forEach var="userRole" items="${users}">
                <tr>
                    <td>${userRole.username}</td>
                    <td>${userRole.role}</td>
                    <td>
                        <button class="btn btn-warning" data-toggle="modal" data-target="#editRoleModal" data-username="${userRole.username}" data-role="${userRole.role}" data-userId="${userRole.userId}">修改</button>
                        <button class="btn btn-danger" data-toggle="modal" data-target="#deleteRoleModal" data-userId="${userRole.userId}">删除</button>
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
                    <a class="page-link" href="systemManager.jsp?currentpage=<%= currentpage - 1 %>">上一页</a>
                </li>
                <%
                    }
                    for (int i = startPage; i <= endPage; i++) {
                %>
                <li class="page-item <%= (i == currentpage) ? "active" : "" %>">
                    <a class="page-link" href="systemManager.jsp?currentpage=<%= i %>"><%= i %></a>
                </li>
                <%
                    }
                    if (currentpage < totalpages) {
                %>
                <li class="page-item">
                    <a class="page-link" href="systemManager.jsp?currentpage=<%= currentpage + 1 %>">下一页</a>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>

    <div id="viewSalaries" class="container content-section">
        <h2>查看工资</h2>
        <br>
        <%
            int cpage = 1;
            int totalpage = 0;
            SalaryService salaryService = new SalaryService();
            if (request.getParameter("cpage") != null) {
                try {
                    cpage = Integer.parseInt(request.getParameter("cpage"));
                } catch (NumberFormatException e) {
                    cpage = 1; // 如果参数不是有效的整数，默认显示第一页
                }
            }
            List<Salary> salary = salaryService.selectAll();
            List<Salary> salarys = salaryService.selectByPage(cpage-1);
            Map<String, Double> salaryMap = salaryService.getSalaryStats();
            request.setAttribute("salaryMap", salaryMap);
            request.setAttribute("salarys", salarys);
            request.setAttribute("salary", salary);
            totalpage = (int) Math.ceil(salary.size() / (double) pagesize);
        %>
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
            </tr>
            </thead>
            <tbody id="salaryRolesTable">
            <c:forEach var="salaryRole" items="${salarys}">
                <tr>
                    <td>${salaryRole.empNo}</td>
                    <td>${salaryRole.year}</td>
                    <td>${salaryRole.month}</td>
                    <td>${salaryRole.basicSalary}</td>
                    <td>${salaryRole.overtimePay}</td>
                    <td>${salaryRole.fullAttendanceBonus}</td>
                    <td>${salaryRole.personalTax}</td>
                    <td>${salaryRole.netSalary}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div>
            <ul class="pagination">
                <%
                    int startPage1 = Math.max(1, cpage - 2);
                    int endPage1 = Math.min(totalpage, cpage + 2);
                    if (cpage > 1) {
                %>
                <li class="page-item">
                    <a class="page-link" href="systemManager.jsp?cpage=<%= cpage - 1 %>&section=viewSalaries">上一页</a>
                </li>
                <%
                    }
                    for (int i = startPage1; i <= endPage1; i++) {
                %>
                <li class="page-item <%= (i == cpage) ? "active" : "" %>">
                    <a class="page-link" href="systemManager.jsp?cpage=<%= i %>&section=viewSalaries"><%= i %></a>
                </li>
                <%
                    }
                    if (cpage < totalpage) {
                %>
                <li class="page-item">
                    <a class="page-link" href="systemManager.jsp?cpage=<%= cpage + 1 %>&section=viewSalaries">下一页</a>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
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
            <input type="hidden" id="username" name="username">
            <input type="hidden" id="role" name="systemManager">
            <button type="submit" class="btn btn-primary">提交</button>
        </form>
    </div>
</div>

<div class="modal fade" id="editRoleModal" tabindex="-1" role="dialog" aria-labelledby="editRoleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="systemManage" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editRoleModalLabel">设置角色</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="editUsername">用户名：</label>
                        <input type="text" class="form-control" id="editUsername" name="editusername" readonly>
                        <input type="hidden" id="editUserId" name="edituserId">
                    </div>
                    <div class="form-group">
                        <label for="editRole">角色：</label>
                        <select class="form-control" id="editrole" name="editrole">
                            <option value="peopleManager">人事管理员</option>
                            <option value="financialManager">财务管理员</option>
                            <option value="generalManager">总经理</option>
                            <option value="systemManager">系统管理员</option>
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
                    <h5 class="modal-title" id="deleteRoleModalLabel">删除员工</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>确定要删除此角色吗？</p>
                    <input type="hidden" id="deleteUserId" name="deleteuserId">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-danger">删除</button>
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
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
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

        if (data.getNumberOfRows() === 0) {
            $('#piechart').text('没有数据可显示');
            return;
        }

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

    function confirmLogout() {
        window.location.href = 'login.jsp';
    }
</script>

<script>
    $('form').on('submit', function () {
        var form = $(this);
        // 延迟清空表单，确保表单提交完成
        setTimeout(function () {
            form.find('input').val('');
        }, 1000); // 延迟1秒清空表单
    });

    $('#editRoleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var username = button.data('username');
        var role = button.data('role');
        var userId = button.data('userid');

        var modal = $(this);
        modal.find('#editUsername').val(username);
        modal.find('#editRole').val(role);
        modal.find('#editUserId').val(userId);
    });

    $('#deleteRoleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var userId = button.data('userid');
        var modal = $(this);
        modal.find('#deleteUserId').val(userId);
    });

    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        var results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }

    document.addEventListener('DOMContentLoaded', function() {
        var section = getUrlParameter('section');
        if (section) {
            showSection(section);
        }
    });
</script>
</body>
</html>