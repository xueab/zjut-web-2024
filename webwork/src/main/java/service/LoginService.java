package service;

import model.User;
import org.bouncycastle.crypto.Digest;
import org.bouncycastle.crypto.digests.SM3Digest;
import org.bouncycastle.util.encoders.Hex;

import java.io.UnsupportedEncodingException;
import java.util.List;
import dao.UserDao;

public class LoginService {
    public boolean checkUser(String name, String password) throws UnsupportedEncodingException {
        UserDao user = new UserDao();
        List<User> list = user.selectUser();
        // 加密
        password = encrypt(password);

        for (User s : list) {
            if (s.getUsername().equals(name) && s.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
    }
    public boolean checkUsername(String name) {
        UserDao user = new UserDao();
        List<User> list = user.selectUser();

        for (User s : list) {
            if (s.getUsername().equals(name)) {
                return true;
            }
        }
        return false;
    }

    public boolean checkPassword(String password) throws UnsupportedEncodingException {
        UserDao user = new UserDao();
        List<User> list = user.selectUser();
        // 加密
        password = encrypt(password);

        for (User s : list) {
            if (s.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
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

    public String getUserRole(String name, String password) throws UnsupportedEncodingException {
        UserDao user = new UserDao();
        List<User> list = user.selectUser();

        password = encrypt(password);

        for (User s : list) {
            if (s.getUsername().equals(name) && s.getPassword().equals(password)) {
                return s.getRole();
            }
        }
        return null;
    }
}
