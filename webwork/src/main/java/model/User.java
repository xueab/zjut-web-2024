package model;

import java.util.Date;

public class User {
    private int userId; // 用户ID
    private String username; // 用户名
    private String password; // 密码（SM3加密）
    private String role; // 角色
    private Date lastPasswordChange; // 上次密码更改日期
    private int failedLoginAttempts; // 登录失败次数
    private Date accountLockedUntil; // 账户锁定截止时间


    public User() {
    }

    public User(int userId, String username, String password, String role, Date lastPasswordChange, int failedLoginAttempts, Date accountLockedUntil) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.role = role;
        this.lastPasswordChange = lastPasswordChange;
        this.failedLoginAttempts = failedLoginAttempts;
        this.accountLockedUntil = accountLockedUntil;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getLastPasswordChange() {
        return lastPasswordChange;
    }

    public void setLastPasswordChange(Date lastPasswordChange) {
        this.lastPasswordChange = lastPasswordChange;
    }

    public int getFailedLoginAttempts() {
        return failedLoginAttempts;
    }

    public void setFailedLoginAttempts(int failedLoginAttempts) {
        this.failedLoginAttempts = failedLoginAttempts;
    }

    public Date getAccountLockedUntil() {
        return accountLockedUntil;
    }

    public void setAccountLockedUntil(Date accountLockedUntil) {
        this.accountLockedUntil = accountLockedUntil;
    }
}
