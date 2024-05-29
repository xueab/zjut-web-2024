package service;

import model.User;
import org.bouncycastle.crypto.Digest;
import org.bouncycastle.crypto.digests.SM3Digest;
import org.bouncycastle.util.encoders.Hex;

import java.io.UnsupportedEncodingException;
import java.util.List;

public class LoginService {
    public boolean checkUser(String name, String password) throws UnsupportedEncodingException {
        UserDa0 user = new UserDa0();
        List<User> list = user.selectUser();

        password = encrypt(password);

        for (User s : list) {
            if (s.getUsername().equals(name) && s.getPassword().equals(password)) {
                return true;
            }
        }
        return false;
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

    public String getUserRole(String name, String password) throws UnsupportedEncodingException {
        UserDa0 user = new UserDa0();
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
