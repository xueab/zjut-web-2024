import com.alibaba.fastjson.JSONObject;
import dao.EmployeeDao;
import dao.SalaryDao;
import dao.UserDao;
import model.Employee;
import model.Salary;
import model.User;
import org.junit.Test;
import service.EmployeeService;
import service.SalaryService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class text_UserDao {
    @Test
    public void main() {
        SalaryService salaryService = new SalaryService();
        Map<String, Double> map = salaryService.getSalaryStats();
        for (Map.Entry<String, Double> entry : map.entrySet()) {
            System.out.println(entry.getKey() + ":" + entry.getValue());
        }
    }
}
