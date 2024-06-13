package controller;


import service.ChangePasswordService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/changePassword.do")
public class changePassswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        System.out.println(username);
        String role = req.getParameter("role");
        System.out.println(role);
        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        ChangePasswordService changePasswordService = new ChangePasswordService();
        if (newPassword.equals(confirmPassword) && changePasswordService.checkPassword(newPassword)
            && changePasswordService.checkOldPassword(username, oldPassword)) {
            changePasswordService.changePassword(username, newPassword);
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }
        // 新密码和confirmPassword不相同或旧密码错误
        if (role.equals("peopleManager")) {
            resp.sendRedirect(req.getContextPath() + "/peopleManager.jsp?" + "section=changePassword" + "&username=" + username);
        }
        else if (role.equals("financialManager")) {
            resp.sendRedirect(req.getContextPath() + "/financialManager.jsp?section=changePassword" + "&username=" + username);
        }
        else if (role.equals("generalManager")) {
            resp.sendRedirect(req.getContextPath() + "/generalManager.jsp?section=changePassword" + "&username=" + username);
        }
        else if (role.equals("systemManager")) {
            resp.sendRedirect(req.getContextPath() + "/systemManager.jsp?section=changePassword" + "&username=" + username);
        }
        else if (role.equals("logManager")) {
            resp.sendRedirect(req.getContextPath() + "/logManager.jsp?section=changePassword" + "&username=" + username);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
