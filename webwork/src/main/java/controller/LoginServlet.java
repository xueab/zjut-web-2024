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
            if (role.equals("人事管理员")) {
                // 重定向到人事管理员界面
                resp.sendRedirect("peoplemange.jsp");
            }
            else if (role.equals("财务管理员")) {
                // 重定向到财务管理员界面
                resp.sendRedirect("salaryMange.jsp");
            }
            else if (role.equals("总经理")) {
                // 重定向到总经理界面
                resp.sendRedirect("leader.jsp");
            }
            else if (role.equals("系统管理员")) {
                // 重定向到系统管理员界面
                resp.sendRedirect("management.jsp");
            }
            else if (role.equals("审计员")) {
                //
                //resp.sendRedirect("peopleMange.jsp");
            }
        }
        else {

        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
