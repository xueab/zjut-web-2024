import dao.EmployeeDao;
import dao.UserDao;
import model.Employee;
import model.User;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

public class text_UserDao {
    @Test
    public void main() {
        UserDao UserDao = new UserDao();
        EmployeeDao EmployeeDao = new EmployeeDao();
        Employee employee = new Employee("3","1","1","1","1","1","1");
        EmployeeDao.delete("1");
    }
}
