package service;

import dao.UserDao;
import model.User;

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

    public void delete(int userId) {
        userDao.delete(userId);
    }
}
