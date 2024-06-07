package dao;

import model.User;
import util.BaseDao;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
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
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }

    public int count()
    {
        List<User> list = this.selectUser();
        return list.size();
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

    public void addone(String username) {
        String sql = "UPDATE User SET failed_login_attempts = failed_login_attempts + 1 WHERE username = ?";
        this.executeUpdate(sql,username);
        return ;
    }

    public int getFailNumber(String username) {
        String sql = "select * from user where username = ?";
        rs = this.executQuery(sql,username);
        int ans = 0;
        try {
            while (rs.next())
            {
                ans = rs.getInt("failed_login_attempts");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return ans;
    }

    public void setAccountLockedUntil(String username, Date date) {
        String sql = "update user set account_locked_until = ? where username = ?";
        this.executeUpdate(sql,date,username);
        return ;
    }

    public void resetFailNumber(String username) {
        String sql = "update user set failed_login_attempts = 0 where username = ?";
        this.executeUpdate(sql,username);
        return ;
    }

    public Timestamp getAccountLockUntil(String username) {
        String sql = "select * from user where username = ?";
        rs = this.executQuery(sql,username);
        Timestamp ans = null;
        try{
            while(rs.next())
            {
                ans = rs.getTimestamp("account_locked_until");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return ans;
    }
}
