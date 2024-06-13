<%@ page import="java.util.List" %>
<%@ page import="service.LogService" %>
<%@ page import="model.Log" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri ="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>审计管理员</title>
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
<div>
    <%
        String username = request.getParameter("username");

    %>
    <div class="sidebar">
        <a href="Log.jsp?section=logManagement&username=<%=username%>" onclick="showSection('logManagement')"><i class="fas fa-user-shield"></i>查看日志</a>
        <a href="Log.jsp?section=changePassword&username=<%=username%>" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#queryModal"><i class="fas fa-calendar-check"></i>
            历史日志查询
        </button>
    </div>
    <div class="main">
        <div id="logManagement" class="container content-section active">
            <h2>查看日志</h2>
            <%
                int currentpage = 1;
                int pagesize = 10; // 每页显示10个员工
                int totalpages = 0;
                LogService logService = new LogService();
                if (request.getParameter("currentpage") != null) {
                    try {
                        currentpage = Integer.parseInt(request.getParameter("currentpage"));
                    } catch (NumberFormatException e) {
                        currentpage = 1; // 如果参数不是有效的整数，默认显示第一页
                    }
                }
                List<Log> log = logService.selectAll();
                List<Log> logs = logService.selectByPage(currentpage-1);
                request.setAttribute("logs", logs);
                request.setAttribute("log", log);
                totalpages = (int) Math.ceil(log.size() / (double) pagesize);
            %>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>时间</th>
                    <th>级别</th>
                    <th>内容</th>
                    <th>用户</th>
                    <th>IP地址</th>
                </tr>
                </thead>
                <tbody id="logRolesTable">
                <c:forEach var="logRole" items="${logs}">
                    <tr>
                        <td>${logRole.time}</td>
                        <td>${logRole.level}</td>
                        <td>${logRole.message}</td>
                        <td>${logRole.username}</td>
                        <td>${logRole.ipAddress}</td>
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
                        <a class="page-link" href="Log.jsp?currentpage=<%= currentpage - 1 %>&username=<%=username%>">上一页</a>
                    </li>
                    <%
                        }
                        for (int i = startPage; i <= endPage; i++) {
                    %>
                    <li class="page-item <%= (i == currentpage) ? "active" : "" %>">
                        <a class="page-link" href="Log.jsp?currentpage=<%= i %>&username=<%=username%>"><%= i %></a>
                    </li>
                    <%
                        }
                        if (currentpage < totalpages) {
                    %>
                    <li class="page-item">
                        <a class="page-link" href="Log.jsp?currentpage=<%= currentpage + 1 %>&username=<%=username%>">下一页</a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
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
                <input type="hidden" id="role" name="Log">
                <button type="submit" class="btn btn-primary">修改密码</button>
            </form>
        </div>

    <div class="modal fade" id="queryModal" tabindex="-1" aria-labelledby="queryModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="queryModalLabel">历史日志查询</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="queryType">选择查询方式:</label>
                            <select class="form-control" id="queryType">
                                <option value="name">通过用户名</option>
                                <option value="dateRange">通过时间段</option>
                            </select>
                        </div>
                        <div id="nameInput" class="form-group">
                            <label for="name">姓名:</label>
                            <input type="text" class="form-control" id="name">
                        </div>
                        <div id="dateRangeInput" class="form-group">
                            <label for="startDate">开始日期:</label>
                            <input type="month" class="form-control" id="startDate">
                            <label for="endDate" class="mt-2">结束日期:</label>
                            <input type="month" class="form-control" id="endDate">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Submit</button>
                </div>
            </div>
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
    document.addEventListener("DOMContentLoaded", function() {
        const queryType = document.getElementById("queryType");
        const nameInput = document.getElementById("nameInput");
        const dateRangeInput = document.getElementById("dateRangeInput");

        queryType.onchange = function() {
            const value = queryType.value;
            nameInput.style.display = "none";
            dateRangeInput.style.display = "none";

            if (value === "name") {
                nameInput.style.display = "block";
            }else if (value === "dateRange") {
                dateRangeInput.style.display = "block";
            }
        }
        queryType.onchange();
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
            } else if (value === "dateRange") {
                dateRangeInput.style.display = "block";
            }
        }
        queryType.onchange();
    });
</script>
</body>
</html>
