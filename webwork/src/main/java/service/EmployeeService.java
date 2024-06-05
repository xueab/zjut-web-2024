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
        for (int i = 0; i < 4; i++) {
            stats.put(departments[i], show(departments[i]));
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
