package controller;

import model.Employee;
import service.EmployeeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// 修改员工信息
@WebServlet("/updateemployee.do")
public class updateEmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EmployeeService e = new EmployeeService();
        String empNo = req.getParameter("empNo");
        String name = req.getParameter("name");
        String depName = req.getParameter("depName");
        String position = req.getParameter("position");
        String idNumber = req.getParameter("idNumber");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        Employee employee = new Employee(empNo, name, depName, position, idNumber, phone, address);

        e.updateEmployee(employee);

        // 重定向
        resp.sendRedirect("/peopleManager.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
