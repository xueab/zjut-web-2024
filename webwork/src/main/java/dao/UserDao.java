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

    public void add(User user) {
        String sql = "insert into user (user_id,username,password,role,last_password_change,failed_login_attempts,account_locked_until) values(?,?,?,?,?,?,?)";
        this.executeUpdate(sql,user.getUserId(),user.getUsername(),user.getPassword(),user.getRole(),user.getLastPasswordChange(),
                user.getFailedLoginAttempts(),user.getAccountLockedUntil());
        return ;
    }

    public void update(User user) {
        String sql = "update user set username = ?,password = ?,role = ?,last_password_change = ?,failed_login_attempts = ?,account_locked_until = ?" +
                "where user_id = ?";
        this.executeUpdate(sql,user.getUsername(),user.getPassword(),user.getRole(),user.getLastPasswordChange(),user.getFailedLoginAttempts(),
                user.getAccountLockedUntil(),user.getUserId());
        return;
    }
    public void delete(int user_id) {
        String sql = "delete from user where user_id = ?";
        this.executeUpdate(sql,user_id);
        return ;
    }
}
