package service;

public class LoginService {
    public bool selectUser(string name) {
        UserDa0 user = new UserDa0();
        List<User> list = user.selectUser();

        for (User s : list) {
            if (s.getName.equal(name)) {
                return true;
            }
        }
        return false;
    }
}
