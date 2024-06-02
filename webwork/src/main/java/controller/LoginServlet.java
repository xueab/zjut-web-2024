package controller;

import service.LoginService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        LoginService s = new LoginService();
        // 检查用户名和密码是否正确
        if (s.checkUser(username, password)) {
            // 确定用户角色
            String role = s.getUserRole(username, password);
            String redirectURL = "";
            if (role.equals("人事管理员")) {
                // 重定向到人事管理员界面
                redirectURL = "peoplemange.jsp";
            } else if (role.equals("财务管理员")) {
                // 重定向到财务管理员界面
                redirectURL = "salaryMange.jsp";
            } else if (role.equals("总经理")) {
                // 重定向到总经理界面
                redirectURL = "leader.jsp";
            } else if (role.equals("系统管理员")) {
                // 重定向到系统管理员界面
                redirectURL = "management.jsp";
            }
            // 在重定向URL中附加username参数
            if (!redirectURL.isEmpty()) {
                resp.sendRedirect(redirectURL + "?username=" + username);
            }
        } else {
            // 登录失败的处理逻辑（例如重定向到登录页面并显示错误信息）
            resp.sendRedirect("login.jsp?error=invalid");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
//添加了向重定向页面传入username的功能