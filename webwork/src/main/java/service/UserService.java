package service;

import model.User;

public class UserService {
    public void update(User user) {
        UserDao userDao = new UserDao();
        userDao.update(user);
    }
}
