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

        String username = new String(req.getParameter("username").getBytes("ISO-8859-1"),"utf-8");
        int empNo = Integer.parseInt(req.getParameter("deleteempNo"));
        int year = Integer.parseInt(req.getParameter("deleteyear"));
        int month = Integer.parseInt(req.getParameter("deletemonth"));



        s.delete(empNo, year, month);

        resp.sendRedirect(req.getContextPath() + "/financialManager.jsp" + "?username=" + username);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
