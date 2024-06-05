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

// 删除工资

@WebServlet("/deleteSalary.do")
public class deleteSalary extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SalaryService s = new SalaryService();

        int empNo = Integer.parseInt(req.getParameter("deleteempNo"));
        int year = Integer.parseInt(req.getParameter("deleteyear"));
        int month = Integer.parseInt(req.getParameter("deletemonth"));
        BigDecimal basicSalary = new BigDecimal(req.getParameter("deletebasicSalary"));
        BigDecimal overtimePay = new BigDecimal(req.getParameter("deleteovertimePay"));
        BigDecimal fullAttendanceBonus = new BigDecimal(req.getParameter("deletefullAttendanceBonus"));
        BigDecimal personalTax = new BigDecimal(req.getParameter("deletepersonalTax"));
        BigDecimal netSalary = new BigDecimal(req.getParameter("deletenetSalary"));

        Salary salary = new Salary(empNo, year, month, basicSalary, overtimePay, fullAttendanceBonus, personalTax, netSalary);

        s.delete(salary);

        resp.sendRedirect("/financialManager.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
