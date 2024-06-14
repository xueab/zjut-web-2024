package controller;

import model.Employee;
import service.EmployeeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

// 修改员工信息
@WebServlet("/updateemployee.do")
public class updateEmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EmployeeService e = new EmployeeService();
        String username = new String(req.getParameter("username").getBytes("ISO-8859-1"),"utf-8");
        int empNo = Integer.parseInt(req.getParameter("editempNo"));
        String name = new String(req.getParameter("editname").getBytes("ISO-8859-1"), "utf-8");
        String depName = new String(req.getParameter("editdepName").getBytes("ISO-8859-1"), "utf-8");
        String position = req.getParameter("editposition");
        String idNumber = req.getParameter("editidNumber");
        String phone = req.getParameter("editphone");
        String address = req.getParameter("editaddress");


        Employee employee = new Employee(empNo, name, depName, position, idNumber, phone, address);

        e.updateEmployee(employee);

        // 重定向
        resp.sendRedirect(req.getContextPath() + "/peopleManager.jsp" + "?username=" + username);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
