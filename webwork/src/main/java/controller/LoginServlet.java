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
import java.util.Map;

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
            if (redirectURL.equals("peopleManager.jsp")) {
                List<Employee> list = employeeService.selectAll();
                Map<String, Double> map = employeeService.getDepartmentStats();
//                for (Employee employee : list) {
//                    System.out.println(employee.getName());
//                }

                req.setAttribute("employeeMap", map);
                req.setAttribute("employee", list);
                req.getRequestDispatcher("/peopleManager.jsp").forward(req, resp);
                //resp.sendRedirect(redirectURL + "?username=" + username);
            }else if (redirectURL.equals("financialManager.jsp")) {
                List<Salary> list = salaryService.selectAll();
//                for (Salary salary : list) {
//                    System.out.println(salary.getEmpNo());
//                
                req.setAttribute("salary", list);
                req.getRequestDispatcher("/financialManager.jsp").forward(req, resp);
                //resp.sendRedirect(redirectURL + "?username=" + username);
            }else if (redirectURL.equals("generalManager.jsp")) {
                List<Employee> list = employeeService.selectAll();
                List<Salary> list2 = salaryService.selectAll();
//                for (Employee employee : list) {
//                    System.out.println(employee.getName());
//                }
//                for (Salary salary : list2) {
//                    System.out.println(salary.getEmpNo());
//                }
                req.setAttribute("employee", list);
                req.setAttribute("salary", list2);
                req.getRequestDispatcher("/generalManager.jsp").forward(req, resp);
            } else if (redirectURL.equals("systemManager.jsp")) {
                List<User> list = userService.selectAll();
                for (User user : list) {
                    System.out.println(user.getUsername());
                }
                req.setAttribute("user", list);
                req.getRequestDispatcher("/systemManager.jsp").forward(req, resp);
            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }


}
//添加了向重定向页面传入username的功能