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
    <button class="btn btn-info" data-toggle="modal" data-target="#employeePieChartModal"><i class="fas fa-chart-pie"></i>员工部门占比饼状图</button>
    <button class="btn btn-success" data-toggle="modal" data-target="#addemployeeModal"><i class="fas fa-plus"></i>添加员工</button>

    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#logoutModal">
        <i class="fas fa-sign-out-alt"></i> 退出登录
    </button>
</div>
<div class="main">
    <div id="employeeManagement" class="container content-section active">
        <h2>员工管理</h2>
        <br><br>
        <%
            int currentpage = 1;
            int pagesize = 10; // 每页显示10个员工
            int totalpages = 0;
            EmployeeService employeeService = new EmployeeService();
            if (request.getParameter("currentpage") != null) {
                try {
                    currentpage = Integer.parseInt(request.getParameter("currentpage"));
                } catch (NumberFormatException e) {
                    currentpage = 1; // 如果参数不是有效的整数，默认显示第一页
                }
            }
            List<Employee> employee = employeeService.selectAll();
            List<Employee> employees = employeeService.selectByPage(currentpage-1);
            Map<String, Double> employeeMap = employeeService.getDepartmentStats();
            request.setAttribute("employeeMap", employeeMap);
            request.setAttribute("employees", employees);
            request.setAttribute("employee", employee);
            totalpages = (int) Math.ceil(employee.size() / (double) pagesize);
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
            <c:forEach var="employeeRole" items="${employees}">
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
                        <label for="addname">员工姓名:</label>
                        <input type="text" class="form-control" id="addname" name="addname" required>
                    </div>
                    <div class="form-group">
                        <label for="addempNo">员工编号:</label>
                        <input type="text" class="form-control" id="addempNo" name="addempNo" required>
                    </div>
                    <div class="form-group">
                        <label for="adddepName">部门名称:</label>
                        <input type="text" class="form-control" id="adddepName" name="adddepName" required>
                    </div>
                    <div class="form-group">
                        <label for="addposition">岗位:</label>
                        <input type="text" class="form-control" id="addposition" name="addposition" required>
                    </div>
                    <div class="form-group">
                        <label for="addidNumber">身份证号:</label>
                        <input type="text" class="form-control" id="addidNumber" name="addidNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="addphone">手机号:</label>
                        <input type="text" class="form-control" id="addphone" name="addphone" required>
                    </div>
                    <div class="form-group">
                        <label for="addaddress">住址:</label>
                        <input type="text" class="form-control" id="addaddress" name="addaddress" required>
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
                    <input type="hidden" id="deleteName" name="deletename">
                    <input type="hidden" id="deleteId" name="deleteempNo">
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
                        <label for="editname">员工姓名:</label>
                        <input type="text" class="form-control" id="editname" name="editname" required>
                    </div>
                    <div class="form-group">
                        <label for="editempNo">员工编号:</label>
                        <input type="text" class="form-control" id="editempNo" name="editempNo" required>
                    </div>
                    <div class="form-group">
                        <label for="editdepName">部门名称:</label>
                        <input type="text" class="form-control" id="editdepName" name="editdepName" required>
                    </div>
                    <div class="form-group">
                        <label for="editposition">岗位:</label>
                        <input type="text" class="form-control" id="editposition" name="editposition" required>
                    </div>
                    <div class="form-group">
                        <label for="editidNumber">身份证号:</label>
                        <input type="text" class="form-control" id="editidNumber" name="editidNumber" required>
                    </div>
                    <div class="form-group">
                        <label for="editphone">手机号:</label>
                        <input type="text" class="form-control" id="editphone" name="editphone" required>
                    </div>
                    <div class="form-group">
                        <label for="editaddress">住址:</label>
                        <input type="text" class="form-control" id="editaddress" name="editaddress" required>
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
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="employeePieChartModalLabel">员工部门比例</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="piechart" class="chart-container"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<script>
    $('form').on('submit', function () {
        var form = $(this);
        // 延迟清空表单，确保表单提交完成
        setTimeout(function () {
            form.find('input').val('');
        }, 1000); // 延迟1秒清空表单
    });

    $('#addemployeeModal').on('hidden.bs.modal', function () {
        // 清空表单数据
        $(this).find('#addname').val('');
        $(this).find('#addempNo').val('');
        $(this).find('#adddepName').val('');
        $(this).find('#addposition').val('');
        $(this).find('#addidNumber').val('');
        $(this).find('#addphone').val('');
        $(this).find('#addaddress').val('');
    });
    $('#deleteemployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // 触发事件的按钮
        var name = button.data('name');
        var empNo = button.data('empno');
        var modal = $(this);
        modal.find('#deleteName').val(name);
        modal.find('#deleteId').val(empNo);
    });
    $('#editemployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var editname = button.data('name');
        var editempNo = button.data('empno');
        var editdepName = button.data('depname');
        var editposition = button.data('position');
        var editidNumber = button.data('idnumber');
        var editphone = button.data('phone');
        var editaddress = button.data('address');

        var modal = $(this);
        modal.find('#editname').val(editname);
        modal.find('#editempNo').val(editempNo);
        modal.find('#editdepName').val(editdepName);
        modal.find('#editposition').val(editposition);
        modal.find('#editidNumber').val(editidNumber);
        modal.find('#editphone').val(editphone);
        modal.find('#editaddress').val(editaddress);
    });
</script>

<script type="text/javascript">
    function showSection(sectionId) {
        var sections = document.getElementsByClassName('content-section');
        for (var i = 0; i < sections.length; i++) {
            sections[i].classList.remove('active');
        }
        document.getElementById(sectionId).classList.add('active');
    }

    // Load the Visualization API and the corechart package.
    google.charts.load('current', {'packages':['corechart']});

    // Set a callback to run when the Google Visualization API is loaded.
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        // Create the data table.
        var data = google.visualization.arrayToDataTable([
            ['Department', 'Percentage'],
            <c:forEach var="entry" items="${employeeMap}">
            ['${entry.key}', ${entry.value}],
            </c:forEach>
        ]);

        if (data.getNumberOfRows() === 0) {
            $('#piechart').text('没有数据可显示');
            return;
        }

        // Set chart options
        var options = {
            'title': '员工部门分布',
            'width': 600,
            'height': 450,
            'titleTextStyle': {
                'fontSize': 24, // 调整字体大小
                'bold': true, // 是否加粗
                'color': '#000000' // 字体颜色
            }
        };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
    }

    function confirmLogout() {
        window.location.href = 'login.jsp';
    }
</script>
</body>
</html>