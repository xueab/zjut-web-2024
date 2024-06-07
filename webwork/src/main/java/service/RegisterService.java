package service;

import model.User;
import org.bouncycastle.crypto.Digest;
import org.bouncycastle.crypto.digests.SM3Digest;
import org.bouncycastle.util.encoders.Hex;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegisterService {
    public boolean checkUserExist(String username) {
        UserService userService = new UserService();
        List<User> list = userService.selectAll();

        for (User user : list) {
            if (user.getUsername().equals(username)) {
                return true;
            }
        }
        return false;
    }

    public boolean checkPasswordValid(String password) {
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
        // 创建匹配器对象
        Matcher matcher = pattern.matcher(password);

        return matcher.matches();
    }

}
