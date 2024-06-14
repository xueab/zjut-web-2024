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

        String username = new String(req.getParameter("username").getBytes("ISO-8859-1"),"utf-8");

        int empNo = Integer.parseInt(req.getParameter("editempNo"));
        int year = Integer.parseInt(req.getParameter("edityear"));
        int month = Integer.parseInt(req.getParameter("editmonth"));
        BigDecimal basicSalary = new BigDecimal(req.getParameter("editbasicSalary"));
        BigDecimal overtimePay = new BigDecimal(req.getParameter("editovertimePay"));
        BigDecimal fullAttendanceBonus = new BigDecimal(req.getParameter("editfullAttendanceBonus"));
        BigDecimal personalTax = BigDecimal.valueOf(0);
        BigDecimal netSalary = BigDecimal.valueOf(0);

        Salary salary = new Salary(empNo, year, month, basicSalary, overtimePay, fullAttendanceBonus, personalTax, netSalary);
        salary.setPersonalTax(salary.calculatePersonalTax());
        salary.setNetSalary(salary.calculateNetSalary());
        s.update(salary);

        resp.sendRedirect(req.getContextPath() + "/financialManager.jsp" + "?username=" + username);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
