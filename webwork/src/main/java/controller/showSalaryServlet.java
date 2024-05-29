package controller;

import service.SalaryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


// 显示工资占比
@WebServlet("showSalaryServlet")
public class showSalaryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SalaryService s = new SalaryService();

        // 3k - 5k
        double n1 = s.show(3000, 5000);
        // 5k - 8k
        double n2 = s.show(5000, 8000);
        // 8k - 12k
        double n3 = s.show(8000, 12000);
        // 12k 以上
        double n4 = s.show(12000, 20000);

        req.setAttribute("3k-5k", n1);
        req.setAttribute("5k-8k", n2);
        req.setAttribute("8k-12k", n3);
        req.setAttribute("12k以上", n4);

        req.getRequestDispatcher("salaryMange.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
