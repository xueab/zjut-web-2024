package controller;

import model.User;
import org.bouncycastle.crypto.Digest;
import org.bouncycastle.crypto.digests.SM3Digest;
import org.bouncycastle.util.encoders.Hex;
import service.UserService;
import service.RegisterService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

// 注册

@WebServlet("registerServlet")
public class registerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        RegisterService reg = new RegisterService();

        // 判断用户名是否存在
        if (reg.checkUserExist(username)) {
            resp.getWriter().write("username exist");
        }


        if (reg.checkPasswordValid(password)) {
            // 密码符合要求
            // 加密
            password = encrypt(password);
            // 添加用户
            UserService userService = new UserService();
            int id = userService.count() + 1;
            User user = new User(id, username, password, "", new Date(),0, new Date());
            userService.add(user);
        }
        else {
            // 密码不符合要求
            resp.getWriter().write("password error");
        }

        // 重定向到登录界面
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
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
