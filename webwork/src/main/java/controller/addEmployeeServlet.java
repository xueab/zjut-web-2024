package controller;

import model.Employee;
import service.EmployeeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// 添加员工
@WebServlet("/addEmployee.do")
public class addEmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EmployeeService e = new EmployeeService();
        String name = req.getParameter("name");
        String empNo = req.getParameter("empNo");
        String depName = req.getParameter("depName");
        String position = req.getParameter("position");
        String idNumber = req.getParameter("idNumber");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        Employee employee = new Employee(empNo, name, depName, position, idNumber, phone, address);

        e.addEmployee(employee);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
