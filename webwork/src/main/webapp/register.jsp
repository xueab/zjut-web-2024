<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
</head>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .login-container {
        background-color: #fff;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        width: 400px;
        padding: 20px;
        text-align: center;
    }
    .login-container img {
        width: 100%;
        border-radius: 10px 10px 0 0;
    }
    .login-container h2 {
        margin-bottom: 20px;
    }
    .login-container form {
        display: flex;
        flex-direction: column;
        align-items: center;
    }
    .login-container input[type="text"],
    .login-container input[type="password"] {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    .login-container input[type="checkbox"] {
        margin: 10px 0;
    }
    .login-container button {
        background-color: #28a745;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 20px;
    }
    .login-container button:hover {
        background-color: #218838;
    }
    .login-container .options {
        display: flex;
        justify-content: space-between;
        width: 100%;
        margin-top: 10px;
    }
</style>
<body>
<div class="login-container">
    <img src="login.jpg" alt="Login Image">
    <h2>注册</h2>
    <form action="registerServlet.do" method="post">
        <input type="text" name="username" placeholder="请输入用户名" required>
        <input type="password" name="password" placeholder="请输入密码" required>
        <button type="submit">注册</button>
    </form>
</div>
</body>
</html>
