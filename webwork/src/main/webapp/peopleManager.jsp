<%@ page import="service.EmployeeService" %>
<%@ page import="model.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
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
        <% EmployeeService employeeService = new EmployeeService();
            List<Employee> employee = employeeService.selectAll();
            Map<String, Double> employeeMap = employeeService.getDepartmentStats();
            request.setAttribute("employeeMap", employeeMap);
            request.setAttribute("employee", employee);
        %>
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
                        <button class="btn btn-danger" data-toggle="modal" data-target="#editemployeeModal" data-name="${employeeRole.name}" data-empno="${employeeRole.empNo}" data-depName="${employeeRole.depName}" data-position="${employeeRole.position}" data-idNumber="${employeeRole.idNumber}" data-phone="${employeeRole.phone}" data-address="${employeeRole.address}">删除</button>
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
                        <input type="text" class="form-control" id="addaddress" name="address" required>
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

<div class="modal fade" id="employeePieChartModal" tabindex="-1" role="dialog" aria-labelledby="employeePieChartModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="employeePieChartModalLabel">员工部门分布图</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="piechart" style="width: 100%; height: 400px;"></div>
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

        // Set chart options
        var options = {
            'title': '员工部门分布',
            'width': 400,
            'height': 300
        };

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
    }
</script>

<script>
    $('#deleteemployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var name = button.data('deletename');
        var id = button.data('deleteempNo');
        var modal = $(this);
        modal.find('#deleteName').val(name);
        modal.find('#deleteName').val(name);
    });

    $('#editemployeeModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var name = button.data('editname');
        var empNo = button.data('editempno');
        var depName = button.data('editdepname');
        var position = button.data('editposition');
        var idNumber = button.data('editidnumber');
        var phone = button.data('editphone');
        var address = button.data('editaddress');
        var modal = $(this);
        modal.find('#editName').val(name);
        modal.find('#editEmpNo').val(empNo);
        modal.find('#editDepName').val(depName);
        modal.find('#editPosition').val(position);
        modal.find('#editIdNumber').val(idNumber);
        modal.find('#editPhone').val(phone);
        modal.find('#editAddress').val(address);
    });
</script>
</body>
</html>
