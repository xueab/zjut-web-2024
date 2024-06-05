package service;

import dao.EmployeeDao;
import model.Employee;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EmployeeService {
    private EmployeeDao employeeDao = new EmployeeDao();

    public Map<String, Double> getDepartmentStats() {
        Map<String, Double> stats = new HashMap<>();
        // 假设有a, b, c, d四个部门
        String[] departments = {"a部门", "b部门", "c部门", "d部门"};
        int totalEmployees = employeeDao.count();
        if (totalEmployees == 0) {
            for (String dept : departments) {
                stats.put(dept, 0.0);
            }
        } else {
            for (String dept : departments) {
                int deptCount = employeeDao.selectByName(dept);
                double percentage = (double) deptCount / totalEmployees * 100;
                stats.put(dept, percentage);
            }
        }
        return stats;
    }

    public List<Employee> selectAll() {
        return employeeDao.selectAll();
    }

    public void addEmployee(Employee e) {
        employeeDao.add(e);
    }

    public void updateEmployee(Employee e) {
        employeeDao.update(e);
    }

    public void deleteEmployee(String empNo, String name) {
        employeeDao.delete(name);
    }
}
