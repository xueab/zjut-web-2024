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
@WebServlet("/addemployee.do")
public class addEmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EmployeeService e = new EmployeeService();
        String username = req.getParameter("username");
        String name = req.getParameter("addname");
        int empNo = Integer.parseInt(req.getParameter("addempNo"));
        String depName = req.getParameter("adddepName");
        String position = req.getParameter("addposition");
        String idNumber = req.getParameter("addidNumber");
        String phone = req.getParameter("addphone");
        String address = req.getParameter("addaddress");

        Employee employee = new Employee(empNo, name, depName, position, idNumber, phone, address);
        e.addEmployee(employee);

        // 重定向
        resp.sendRedirect(req.getContextPath() + "/peopleManager.jsp" + "?username=" + username);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
