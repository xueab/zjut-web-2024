package controller;

import model.Salary;
import service.SalaryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;

// 添加工资

@WebServlet("addSalaryServlet")
public class addSalaryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SalaryService s = new SalaryService();

        int empNo = Integer.parseInt(req.getParameter("empNo"));
        int year = Integer.parseInt(req.getParameter("year"));
        int month = Integer.parseInt(req.getParameter("month"));
        BigDecimal basicSalary = new BigDecimal(req.getParameter("basicSalary"));
        BigDecimal overtimePay = new BigDecimal(req.getParameter("overtimePay"));
        BigDecimal fullAttendanceBonus = new BigDecimal(req.getParameter("fullAttendanceBonus"));
        BigDecimal personalTax = new BigDecimal(req.getParameter("personalTax"));
        BigDecimal netSalary = new BigDecimal(req.getParameter("netSalary"));

        Salary salary = new Salary(empNo, year, month, basicSalary, overtimePay, fullAttendanceBonus, personalTax, netSalary);

        s.add(salary);

        resp.sendRedirect("/financialManager.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
