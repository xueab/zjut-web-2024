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

@WebServlet("/registerServlet.do")
public class registerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = new String(req.getParameter("username").getBytes("ISO-8859-1"),"utf-8");

        String password = req.getParameter("password");

        RegisterService reg = new RegisterService();

        // 判断用户名是否存在
        if (reg.checkUserExist(username)) {
            resp.sendRedirect(req.getContextPath() + "/register.jsp");
            return;
        }


        if (reg.checkPasswordValid(password)) {
            // 密码符合要求
            // 加密
            password = encrypt(password);
            // 添加用户
            UserService userService = new UserService();
            int id = userService.count() + 1;
            User user = new User(id, username, password, "", new Date(),0, new Date());
            System.out.println(user.toString());
            userService.add(user);
        }
        else {
            // 密码不符合要求
            resp.sendRedirect(req.getContextPath() + "/register.jsp");
            return;
        }

        // 重定向到登录界面
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    public String encrypt(String password) throws UnsupportedEncodingException {
        // 创建SM3哈希算法实例
        Digest digest = new SM3Digest();
        // 将密码转换成字节数组
        byte[] inputBytes = password.getBytes("UTF-8");
        // 创建输出字节数组,长度等于SM3算法输出摘要的大小
        byte[] outputBytes = new byte[digest.getDigestSize()];
        // 将输入字节数组给SM3算法进行处理
        digest.update(inputBytes, 0, inputBytes.length);
        // 进行哈希计算,结果存储在输出数组中
        digest.doFinal(outputBytes, 0);
        // 将字节数组转换为十六进制字符串
        return Hex.toHexString(outputBytes);
    }

}
