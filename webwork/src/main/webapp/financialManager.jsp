<%@ page import="model.Salary" %>
<%@ page import="service.SalaryService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>财务管理员</title>
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
            transition: background-color 0.5s ease;
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
            transition: width 0.5s ease;
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
            animation: fadeIn 1s ease-in-out;
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
        @keyframes fadeIn {
            from {opacity: 0;}
            to {opacity: 1;}
        }
    </style>
</head>
<body>
<%
    String username = request.getParameter("username");
%>
<div class="sidebar">
    <a href="financialManager.jsp?section=viewSalaries&username=<%=username%>" onclick="showSection('viewSalaries')"><i class="fas fa-money-check-alt"></i>查看工资</a>
    <a href="financialManager.jsp?section=changePassword&username=<%=username%>" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
    <button class="btn btn-success" data-toggle="modal" data-target="#addSalaryModal"><i class="fas fa-plus"></i> 添加记录</button>
    <button class="btn btn-info" data-toggle="modal" data-target="#salaryPieChartModal">
        <i class="fas fa-chart-pie"></i> 显示工资分布饼状图
    </button>
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#queryModal"><i class="fas fa-calendar-check"></i>
        历史工资查询
    </button>
    <button class="btn btn-primary" onclick="window.location.href='exportExcelServlet'"><i class="fas fa-file-export"></i> 导出</button>
    <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#logoutModal">
        <i class="fas fa-sign-out-alt"></i> 退出登录
    </button>
</div>
<div class="main">
    <div id="viewSalaries" class="container content-section active">
        <h2>查看工资</h2>
        <br>
        <%
            int currentpage = 1;
            int pagesize = 10; // 每页显示10条记录
            int totalpages = 0;
            SalaryService salaryService = new SalaryService();
            if (request.getParameter("currentpage") != null) {
                try {
                    currentpage = Integer.parseInt(request.getParameter("currentpage"));
                } catch (NumberFormatException e) {
                    currentpage = 1; // 如果参数不是有效的整数，默认显示第一页
                }
            }
            List<Salary> salary = salaryService.selectAll();
            List<Salary> salarys = salaryService.selectByPage(currentpage-1);
            Map<String, Double> salaryMap = salaryService.getSalaryStats();
            request.setAttribute("salaryMap", salaryMap);
            request.setAttribute("salarys", salarys);
            request.setAttribute("salary", salary);
            totalpages = (int) Math.ceil(salary.size() / (double) pagesize);
        %>
        <div>
            <form action="uploadExcelServlet" method="post" enctype="multipart/form-data">
                <input type="file" name="file"/>
                <input type="hidden" name="username" value=<%=username%>>
                <button class="btn btn-primary">导入</button>
            </form>
        </div>
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
                <th>操作</th>
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
                    <td>
                        <button class="btn btn-warning" data-toggle="modal" data-target="#editSalaryModal"
                                data-empNo="${salaryRole.empNo}" data-year="${salaryRole.year}" data-month="${salaryRole.month}"
                                data-basicSalary="${salaryRole.basicSalary}" data-overtimePay="${salaryRole.overtimePay}"
                                data-fullAttendanceBonus="${salaryRole.fullAttendanceBonus}" data-personTax="${salaryRole.personalTax}"
                                data-netSalary="${salaryRole.netSalary}">编辑</button>
                        <button class="btn btn-danger" data-toggle="modal" data-target="#deleteSalaryModal"
                                data-empNo="${salaryRole.empNo}" data-year="${salaryRole.year}" data-month="${salaryRole.month}">删除</button>
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
                    <a class="page-link" href="financialManager.jsp?currentpage=<%= currentpage - 1 %>&username=<%=username%>">上一页</a>
                </li>
                <%
                    }
                    for (int i = startPage; i <= endPage; i++) {
                %>
                <li class="page-item <%= (i == currentpage) ? "active" : "" %>">
                    <a class="page-link" href="financialManager.jsp?currentpage=<%= i %>&username=<%=username%>"><%= i %></a>
                </li>
                <%
                    }
                    if (currentpage < totalpages) {
                %>
                <li class="page-item">
                    <a class="page-link" href="financialManager.jsp?currentpage=<%= currentpage + 1 %>&username=<%=username%>">下一页</a>
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
            <input type="hidden" name="username" value=<%=username%>>
            <input type="hidden" name="role" value="financialManager">
            <button type="submit" class="btn btn-primary">修改密码</button>
        </form>
    </div>
</div>
<div class="modal fade" id="addSalaryModal" tabindex="-1" role="dialog" aria-labelledby="addSalaryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="addSalary.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addSalaryModalLabel">添加工资记录</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addempNo">员工编号:</label>
                        <input type="text" class="form-control" id="addempNo" name="addempNo" required>
                    </div>
                    <div class="form-group">
                        <label for="addyear">工资所属年份</label>
                        <input type="text" class="form-control" id="addyear" name="addyear" required>
                    </div>
                    <div class="form-group">
                        <label for="addmonth">工资所属月份:</label>
                        <input type="text" class="form-control" id="addmonth" name="addmonth" required>
                    </div>
                    <div class="form-group">
                        <label for="addbasicSalary">基本工资:</label>
                        <input type="text" class="form-control" id="addbasicSalary" name="addbasicSalary" required>
                    </div>
                    <div class="form-group">
                        <label for="addovertimePay">加班工资:</label>
                        <input type="text" class="form-control" id="addovertimePay" name="addovertimePay" required>
                    </div>
                    <div class="form-group">
                        <label for="addfullAttendanceBonus">全勤奖:</label>
                        <input type="text" class="form-control" id="addfullAttendanceBonus" name="addfullAttendanceBonus" required>
                    </div>
                    <input type="hidden" name="username" value=<%=username%>>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="editSalaryModal" tabindex="-1" role="dialog" aria-labelledby="editSalaryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="editSalary.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editSalaryModalLabel">编辑工资记录</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editempNo" name="editempNo">
                    <input type="hidden" id="edityear" name="edityear">
                    <input type="hidden" id="editmonth" name="editmonth">
                    <div class="form-group">
                        <label for="editbasicSalary">基本工资:</label>
                        <input type="text" class="form-control" id="editbasicSalary" name="editbasicSalary" required>
                    </div>
                    <div class="form-group">
                        <label for="editovertimePay">加班工资:</label>
                        <input type="text" class="form-control" id="editovertimePay" name="editovertimePay" required>
                    </div>
                    <div class="form-group">
                        <label for="editfullAttendanceBonus">全勤奖:</label>
                        <input type="text" class="form-control" id="editfullAttendanceBonus" name="editfullAttendanceBonus" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">保存修改</button>
                </div>
                <input type="hidden" name="username" value=<%=username%>>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="deleteSalaryModal" tabindex="-1" role="dialog" aria-labelledby="deleteSalaryModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="deleteSalary.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteSalaryModalLabel">删除工资记录</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>确定要删除该条的工资信息吗?</p>
                    <input type="hidden" id="deleteEmpNo" name="deleteempNo">
                    <input type="hidden" id="deleteYear" name="deleteyear">
                    <input type="hidden" id="deleteMonth" name="deletemonth">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-danger">删除</button>
                </div>
                <input type="hidden" name="username" value=<%=username%>>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="queryModal" tabindex="-1" aria-labelledby="queryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="searchServlet" method="post">
                <input type="hidden" name="username" value="Salary">
            <div class="modal-header">
                <h5 class="modal-title" id="queryModalLabel">历史工资查询</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="queryType">选择查询方式:</label>
                        <select class="form-control" id="queryType">
                            <option value="name">通过姓名</option>
                            <option value="department">通过部门</option>
                            <option value="date">通过时间段</option>
                        </select>
                    </div>
                    <div id="nameInput" class="form-group">
                        <input type="hidden" name="keyword" value="name">
                        <label for="name">姓名:</label>
                        <input type="text" class="form-control" id="name" name="name">
                    </div>
                    <div id="departmentInput" class="form-group">
                        <input type="hidden" name="keyword" value="department">
                        <label for="department">部门:</label>
                        <input type="text" class="form-control" id="department" name="department">
                    </div>
                    <div id="dateRangeInput" class="form-group">
                        <input type="hidden" name="keyword" value="date">
                        <label for="startDate">开始日期:</label>
                        <input type="month" class="form-control" id="startDate" name="startDate">
                        <label for="endDate" class="mt-2">结束日期:</label>
                        <input type="month" class="form-control" id="endDate" name="endDate">
                    </div>
                </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="submit" class="btn btn-primary">查询</button>
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
    $('form').on('submit', function () {
        var form = $(this);
        // 延迟清空表单，确保表单提交完成
        setTimeout(function () {
            form.find('input').val('');
        }, 1000); // 延迟1秒清空表单
    });

    function showSection(sectionId) {
        var sections = document.getElementsByClassName('content-section');
        for (var i = 0; i < sections.length; i++) {
            sections[i].classList.remove('active');
        }
        document.getElementById(sectionId).classList.add('active');
    }

    google.charts.load('current', {'packages':['corechart']});
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
        var options = {
            'title': '工资收入分布情况',
            'width': 400,
            'height': 300
        };
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
    }
</script>

<script>
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

    document.addEventListener("DOMContentLoaded", function() {
        const queryType = document.getElementById("queryType");
        const nameInput = document.getElementById("nameInput");
        const departmentInput = document.getElementById("departmentInput");
        const dateRangeInput = document.getElementById("dateRangeInput");

        queryType.onchange = function() {
            const value = queryType.value;
            nameInput.style.display = "none";
            departmentInput.style.display = "none";
            dateRangeInput.style.display = "none";

            if (value === "name") {
                nameInput.style.display = "block";
            } else if (value === "department") {
                departmentInput.style.display = "block";
            } else if (value === "date") {
                dateRangeInput.style.display = "block";
            }
        }
        queryType.onchange();
    });

    $('#deleteSalaryModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var empNo = button.data('empno');
        var year = button.data('year');
        var month = button.data('month');

        var modal = $(this);
        modal.find('#deleteEmpNo').val(empNo);
        modal.find('#deleteYear').val(year);
        modal.find('#deleteMonth').val(month);
    });

    $('#editSalaryModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var empNo = button.data('empno');
        var year = button.data('year');
        var month = button.data('month');
        var editbasicSalary = button.data('basicSalary');
        var editovertimePay = button.data('overtimePay');
        var editfullAttendanceBonus = button.data('fullAttendanceBonus');
        var editpersonalTax = button.data('personalTax');

        var modal = $(this);
        modal.find('#editEmpNo').val(empNo);
        modal.find('#editYear').val(year);
        modal.find('#editMonth').val(month);
        modal.find('#editbasicSalary').val(editbasicSalary);
        modal.find('#editovertimePay').val(editovertimePay);
        modal.find('#editfullAttendanceBonus').val(editfullAttendanceBonus);
        modal.find('#editpersonalTax').val(editpersonalTax);
    });

    $('queryModal').on('show.bs.modal', function (event){
        var button = $(event.relatedTarget);
        var name = button.data('name');
        var department = button.data('department');
        var startDate = button.data('startDate');
        var endDate = button.data('endDate');

        var modal = $(this);
        modal.find('#name').val(name);
        modal.find('#department').val(department);
        modal.find('#startDate').val(startDate);
        modal.find('#endDate').val(endDate);
    });
</script>
</body>
</html>