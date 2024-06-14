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

@WebServlet("/addSalary.do")
public class addSalaryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SalaryService s = new SalaryService();
        // HTTP请求默认使用ISO-8859-1字符编码
        // 将获取的字节序列按照ISO-8859-1编码转换为字节数组
        // 将得到的字节数组按照UTF-8编码转换为字符串
        // 另一种解决方法
        // request.setCharacterEncoding("UTF-8");
        String username = new String(req.getParameter("username").getBytes("ISO-8859-1"), "utf-8");
        int empNo = Integer.parseInt(req.getParameter("addempNo"));
        int year = Integer.parseInt(req.getParameter("addyear"));
        int month = Integer.parseInt(req.getParameter("addmonth"));
        BigDecimal basicSalary = new BigDecimal(req.getParameter("addbasicSalary"));
        BigDecimal overtimePay = new BigDecimal(req.getParameter("addovertimePay"));
        BigDecimal fullAttendanceBonus = new BigDecimal(req.getParameter("addfullAttendanceBonus"));
        BigDecimal personalTax = new BigDecimal(req.getParameter("addpersonalTax"));
        BigDecimal netSalary = new BigDecimal(req.getParameter("addnetSalary"));

        Salary salary = new Salary(empNo, year, month, basicSalary, overtimePay, fullAttendanceBonus, personalTax, netSalary);

        s.add(salary);

        resp.sendRedirect(req.getContextPath() + "/financialManager.jsp" + "?username=" + username);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
