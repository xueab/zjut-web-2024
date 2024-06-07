package service;

import dao.UserDao;
import model.User;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class UserService {
    private UserDao userDao = new UserDao();
    public void update(User user) {
        userDao.update(user);
    }

    public void add(User user) {
        userDao.add(user);
    }

    public List<User> selectAll() {
        return userDao.selectUser();
    }

    public int count() {
        return userDao.count();
    }

    public void delete(int userId) {
        userDao.delete(userId);
    }
    // 用户登录失败次数加 1
    public void addone(String username) {
        userDao.addone(username);
    }

    // 获取用户失败次数
    public int getFailNumber(String username) {
        return userDao.getFailNumber(username);
    }

    // 锁定账户
    public void lockAccount(String username) {
        userDao.setAccountLockedUntil(username,new Date(System.currentTimeMillis() + 30 * 60 * 1000)); // 锁定30分钟
    }
    // 重置失败次数
    public void resetFailNumber(String username) {
        userDao.resetFailNumber(username);
    }
    // 判断账户是否锁定
/*    public boolean isAccountLocked(String username) {
        Date accountLockTime = userDao.getAccountLockUntil(username);
        // 检查 accountLockTime 是否在当前时间之后（即，检查账户锁定时间是否还没有过期）
        // new Date() 表示当前时间
        // 如果 accountLockTime 在当前时间之后，after 方法返回 true，否则返回 false
        System.out.println(accountLockTime);
        System.out.println(new Date().getTime());
        return accountLockTime.after(new Date());
    }*/
    public boolean isAccountLocked(String username) {
        Timestamp accountLockTime = userDao.getAccountLockUntil(username);

        // 检查 accountLockTime 是否在当前时间之后（即，检查账户锁定时间是否还没有过期）
        if (accountLockTime != null) {
            System.out.println("Account lock time: " + accountLockTime);
            System.out.println("Current time: " + new Timestamp(new Date().getTime()));
            return accountLockTime.after(new Timestamp(new Date().getTime()));
        }

        // 如果没有找到记录或锁定时间为 null，返回 false
        return false;
    }
}
