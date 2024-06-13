package controller;


import model.User;
import org.bouncycastle.crypto.Digest;
import org.bouncycastle.crypto.digests.SM3Digest;
import org.bouncycastle.util.encoders.Hex;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;


// 更新用户
@WebServlet("/systemManage")
public class updateUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserService user = new UserService();
        String username = req.getParameter("username");
        int userId = Integer.parseInt(req.getParameter("edituserId"));
        String editusername = req.getParameter("editusername");

        String role = req.getParameter("editrole");


        user.update(userId, editusername, role);

        // 重定向
        resp.sendRedirect(req.getContextPath() + "/systemManager.jsp" + "?username" + username);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }


}
