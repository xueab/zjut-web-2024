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

        int userId = Integer.parseInt(req.getParameter("userId"));
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        // 加密
        password = encrypt(password);
        String role = req.getParameter("role");
        Date lastPasswordChange = new Date(req.getParameter("lastPasswordChange"));
        int failedLoginAttempts = Integer.parseInt(req.getParameter("failedLoginAttempts"));
        Date accountLockedUntil = new Date(req.getParameter("accountLockedUntil"));

        User u = new User(userId, username, password, role, lastPasswordChange, failedLoginAttempts, accountLockedUntil);

        user.update(u);

        // 重定向
        resp.sendRedirect(req.getContextPath() + "/systemManager.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    public String encrypt(String password) throws UnsupportedEncodingException {
        Digest digest = new SM3Digest();
        // 对输入进行编码，SM3需要一个字节序列
        byte[] inputBytes = password.getBytes("UTF-8");
        // 进行摘要
        byte[] outputBytes = new byte[digest.getDigestSize()];
        digest.update(inputBytes, 0, inputBytes.length);
        digest.doFinal(outputBytes, 0);
        // 将字节数组转换为十六进制字符串
        return Hex.toHexString(outputBytes);
    }
}
