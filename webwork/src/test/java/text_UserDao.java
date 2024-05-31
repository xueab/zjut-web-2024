import dao.EmployeeDao;
import dao.SalaryDao;
import dao.UserDao;
import model.Employee;
import model.Salary;
import model.User;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

public class text_UserDao {
    @Test
    public void main() {
        SalaryDao salaryDao = new SalaryDao();
        List<Salary> list =  salaryDao.selectAll();
        for (Salary salary : list) {
            System.out.println(salary.getNetSalary());
        }
    }
}
