package controller;

import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;


// 删除用户
@WebServlet("/deleteRole.do")
public class deleteUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService user = new UserService();
        String username = new String(req.getParameter("username").getBytes("ISO-8859-1"),"utf-8");
        int userId = Integer.parseInt(req.getParameter("deleteuserId"));
        user.delete(userId);

        // 重定向
        resp.sendRedirect(req.getContextPath() + "/systemManager.jsp" + "?username=" + username);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
