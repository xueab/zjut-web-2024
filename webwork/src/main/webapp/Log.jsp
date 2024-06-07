<%@ page import="service.EmployeeService" %>
<%@ page import="model.Employee" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Salary" %>
<%@ page import="service.SalaryService" %>
<%@ page import="service.LogService" %>
<%@ page import="model.Log" %>
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
            width: 100%;
            height: 400px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<div>
    <%
        String username = request.getParameter("username");
    %>
    <div class="sidebar">
        <a href="#" onclick="showSection('logManagement')"><i class="fas fa-log-shield"></i>查看日志</a>
        <a href="#" onclick="showSection('changePassword')"><i class="fas fa-key"></i>修改密码</a>
    </div>
    <div class="main">
        <div id="logManagement" class="container content-section active">
            <h2>查看日志</h2>
            <%
                LogService logService = new LogService();
                List<Log> log = logService.selectAll();
                request.setAttribute("log", log);
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
                <c:forEach var="logRole" items="${log}">
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
</div>

<script type="text/javascript">
    function showSection(sectionId) {
        var sections = document.getElementsByClassName('content-section');
        for (var i = 0; i < sections.length; i++) {
            sections[i].classList.remove('active');
        }
        document.getElementById(sectionId).classList.add('active');
    }
</script>
</body>
</html>
