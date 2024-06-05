package service;

import dao.EmployeeDao;
import model.Employee;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EmployeeService {
    private EmployeeDao employee = new EmployeeDao();

    public Map<String, Double> getDepartmentStats() {
        Map<String, Double> stats = new HashMap<>();
        // 假设有a, b, c, d四个部门
        String[] departments = {"a部门", "b部门", "c部门", "d部门"};
        int totalEmployees = employee.count();
        if (totalEmployees == 0) {
            for (String dept : departments) {
                stats.put(dept, 0.0);
            }
        } else {
            for (String dept : departments) {
                int deptCount = employee.selectByName(dept);
                double percentage = (double) deptCount / totalEmployees * 100;
                stats.put(dept, percentage);
            }
        }
        return stats;
    }

    public List<Employee> selectAll() {
        return employee.selectAll();
    }

    public void addEmployee(Employee e) {
        employee.add(e);
    }

    public void updateEmployee(Employee e) {
        employee.update(e);
    }

    public void deleteEmployee(String empNo, String name) {
        employee.delete(name);
    }

    public double show(String deptname) {
        // 部门人数
        int n = employee.selectByName(deptname);
        // 总人数
        int count = employee.count();
        return n / count;
    }
}
