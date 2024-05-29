package dao;

import model.User;
import util.BaseDao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao extends BaseDao {
    public List<User> selectUser() {//查找所有用户
        String sql = "select * from user";
        rs = this.executQuery(sql,null);
        List<User> list = new ArrayList<User>();
        try {
            while(rs.next())
            {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setLastPasswordChange(rs.getDate("last_password_change"));
                user.setFailedLoginAttempts(rs.getInt("failed_login_attempts"));
                user.setAccountLockedUntil(rs.getDate("account_locked_until"));
                list.add(user);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }

}
