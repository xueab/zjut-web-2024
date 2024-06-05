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

        int empNo = Integer.parseInt(req.getParameter("editempNo"));
        String name = req.getParameter("editname");
        String depName = req.getParameter("editdepName");
        String position = req.getParameter("editposition");
        String idNumber = req.getParameter("editidNumber");
        String phone = req.getParameter("editphone");
        String address = req.getParameter("editaddress");


        Employee employee = new Employee(empNo, name, depName, position, idNumber, phone, address);

        e.updateEmployee(employee);

        // 重定向
        resp.sendRedirect(req.getContextPath() + "/peopleManager.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
