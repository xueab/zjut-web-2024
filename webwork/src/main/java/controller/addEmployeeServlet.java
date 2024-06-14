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
        String username = new String(req.getParameter("username").getBytes("ISO-8859-1"), "utf-8");
        String name = new String(req.getParameter("addname").getBytes("ISO-8859-1"), "utf-8");
        int empNo = Integer.parseInt(req.getParameter("addempNo"));
        String depName = new String(req.getParameter("adddepName").getBytes("ISO-8859-1"), "utf-8");
        String position = new String(req.getParameter("addposition").getBytes("ISO-8859-1"), "utf-8");
        String idNumber = req.getParameter("addidNumber");
        String phone = req.getParameter("addphone");
        String address = new String(req.getParameter("addaddress").getBytes("ISO-8859-1"),"utf-8");

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
