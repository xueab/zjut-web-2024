package controller;

import model.Employee;
import service.EmployeeService;
import service.LoginService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/loginServlet.do")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        LoginService s = new LoginService();
        EmployeeService employeeService = new EmployeeService();
        // 检查用户名和密码是否正确
        if (s.checkUser(username, password)) {
            // 确定用户角色
            String role = s.getUserRole(username, password);
            String redirectURL = "";
            if (role.equals("peopleManager")) {
                // 重定向到人事管理员界面
                redirectURL = "peopleManager.jsp";
            } else if (role.equals("financialManager")) {
                // 重定向到财务管理员界面
                redirectURL = "financialManager.jsp";
            } else if (role.equals("generalManager")) {
                // 重定向到总经理界面
                redirectURL = "generalManager.jsp";
            } else if (role.equals("systemManager")) {
                // 重定向到系统管理员界面
                redirectURL = "systemManager.jsp";
            }
            // 在重定向URL中附加username参数
            if (!redirectURL.isEmpty()) {
                List<Employee> list = employeeService.selectAll();
                for (Employee employee : list) {
                    System.out.println(employee.getName());
                }
                req.setAttribute("employee", list);
                req.getRequestDispatcher(redirectURL).forward(req, resp);
                //resp.sendRedirect(redirectURL + "?username=" + username);
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