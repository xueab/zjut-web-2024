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

// 编辑工资

@WebServlet("/editSalary.do")
public class updateSalaryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SalaryService s = new SalaryService();

        int empNo = Integer.parseInt(req.getParameter("editempNo"));
        int year = Integer.parseInt(req.getParameter("edityear"));
        int month = Integer.parseInt(req.getParameter("editmonth"));
        BigDecimal basicSalary = new BigDecimal(req.getParameter("editbasicSalary"));
        System.out.println(basicSalary);
        BigDecimal overtimePay = new BigDecimal(req.getParameter("editovertimePay"));
        BigDecimal fullAttendanceBonus = new BigDecimal(req.getParameter("editfullAttendanceBonus"));
        BigDecimal personalTax = new BigDecimal(req.getParameter("editpersonalTax"));
        BigDecimal netSalary = new BigDecimal(req.getParameter("editnetSalary"));

        Salary salary = new Salary(empNo, year, month, basicSalary, overtimePay, fullAttendanceBonus, personalTax, netSalary);

        s.update(salary);

        resp.sendRedirect(req.getContextPath() + "/financialManager.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
