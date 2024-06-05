package controller;

import model.Employee;
import model.Salary;
import model.User;
import service.EmployeeService;
import service.LoginService;
import service.SalaryService;
import service.UserService;

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
        SalaryService salaryService = new SalaryService();
        UserService userService = new UserService();

        // 检查用户名和密码是否正确
        if (s.checkUser(username, password)) {
            // 确定用户角色
            String role = s.getUserRole(username, password);
            String redirectURL = "";
            if (role.equals("peopleManager")) {
                // 重定向到人事管理员界面
                List<Employee> list = employeeService.selectAll();

                req.setAttribute("employee", list);

                req.getRequestDispatcher("/peopleManager.jsp").forward(req, resp);
            } else if (role.equals("financialManager")) {
                // 重定向到财务管理员界面
                List<Salary> list = salaryService.selectAll();

                req.setAttribute("salary", list);
                req.getRequestDispatcher("/financialManager.jsp").forward(req, resp);
            } else if (role.equals("generalManager")) {
                // 重定向到总经理界面
                List<Employee> list = employeeService.selectAll();
                req.setAttribute("employee", list);
                req.getRequestDispatcher("/generalManager.jsp").forward(req, resp);
            } else if (role.equals("systemManager")) {
                // 重定向到系统管理员界面
                List<User> list = userService.selectAll();
                req.setAttribute("user", list);
                req.getRequestDispatcher("/systemManager.jsp").forward(req, resp);
            } else {
                // 登录失败的处理逻辑（例如重定向到登录页面并显示错误信息）
                resp.sendRedirect("login.jsp?error=invalid");
            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }


}
//添加了向重定向页面传入username的功能