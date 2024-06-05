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
import java.util.Date;
import java.util.List;
import java.util.Map;

@WebServlet("/loginServlet.do")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        LoginService s = new LoginService();
        UserService userService = new UserService();

        // 检查用户名和密码是否正确
        if (s.checkUser(username, password)) {
            // 判断用户账户是否锁定
            if (!userService.isAccountLocked(username)) {
                // 重置失败次数
                userService.resetFailNumber(username);
            }
            else {
                resp.getWriter().write("账户已被锁定，请稍后再试。");
                return;
            }

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
                //resp.sendRedirect(redirectURL + "?username=" + username);
                resp.sendRedirect(req.getContextPath() + "/" +  redirectURL);
            }else if (redirectURL.equals("financialManager.jsp")) {

                //resp.sendRedirect(redirectURL + "?username=" + username);
                resp.sendRedirect(req.getContextPath() + "/" +  redirectURL);
            }else if (redirectURL.equals("generalManager.jsp")) {

                resp.sendRedirect(req.getContextPath() + "/" + redirectURL);
            } else if (redirectURL.equals("systemManager.jsp")) {

                resp.sendRedirect(req.getContextPath() + "/" + redirectURL);
            }
        }
        // 用户名错误
        else if (!s.checkUsername(username)) {
            resp.getWriter().write("用户名错误");
        }
        // 密码错误
        else {
            // 登录失败次数加 1
            userService.addone(username);
            // 获取登录失败次数
            int failNumber = userService.getFailNumber(username);
            if (failNumber >= 5) {
                // 锁定账户
                userService.lockAccount(username);
            }
        }

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }


}