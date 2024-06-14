package service;

import dao.UserDao;
import model.User;
import org.bouncycastle.crypto.Digest;
import org.bouncycastle.crypto.digests.SM3Digest;
import org.bouncycastle.util.encoders.Hex;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ChangePasswordService {
    public boolean checkPassword(String password) {
        // 判断密码长度是否大于8位, 是否包含数字,大小字母,特殊字符
        if (password == null || password.length() <= 8) {
            return false;
        }

        // (?=.*[0-9])：必须包含至少一个数字
        // (?=.*[a-z])：必须包含至少一个小写字母
        // (?=.*[A-Z])：必须包含至少一个大写字母
        // (?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?])：必须包含至少一个特殊字符
        String regex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>/?]).+$";
        // 编译正则表达式
        Pattern pattern = Pattern.compile(regex);
        // 创建匹配器对象, 检查密码是否与正则表达式完全匹配
        Matcher matcher = pattern.matcher(password);

        return matcher.matches();
    }



    public void changePassword(String username, String newPassword) throws UnsupportedEncodingException {
        newPassword = encrypt(newPassword);
        UserDao userDao = new UserDao();
        userDao.changePassword(username, newPassword);
    }
    public String encrypt(String password) throws UnsupportedEncodingException {
        // // 创建SM3哈希算法实例
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

    public boolean checkOldPassword(String username, String oldPassword) throws UnsupportedEncodingException {
        UserService userService = new UserService();
        List<User> list = userService.selectAll();
        oldPassword = encrypt(oldPassword);
        for (User user : list) {
            if (user.getUsername().equals(username)) {
                if (user.getPassword().equals(oldPassword)) {
                    return true;
                }
                return false;
            }
        }
        return false;
    }
}
