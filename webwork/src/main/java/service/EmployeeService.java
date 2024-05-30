package service;

import model.Employee;

import java.util.List;
import dao.EmployeeDao;

public class EmployeeService {
    private EmployeeDao employee = new EmployeeDao();
    public double show(String deptname) {
        // 部门人数
        int n = employee.selectByName(deptname);
        // 总人数
        int count = employee.count();
        return n / count;
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
}
