package controller;

import service.EmployeeService;
import service.SalaryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


// 总经理
@WebServlet("/LeaderServlet")
public class LeaderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EmployeeService e = new EmployeeService();
        SalaryService s = new SalaryService();


        // 获取部门占比
        double d1 = e.show("a部门");
        double d2 = e.show("b部门");
        double d3 = e.show("c部门");
        double d4 = e.show("d部门");

        req.setAttribute("a部门", d1);
        req.setAttribute("b部门", d2);
        req.setAttribute("c部门", d3);
        req.setAttribute("d部门", d4);

        // 获取工资占比

        // 3k - 5k
        double s1 = s.show(3000, 5000);
        // 5k - 8k
        double s2 = s.show(5000, 8000);
        // 8k - 12k
        double s3 = s.show(8000, 12000);
        // 12k 以上
        double s4 = s.show(12000, 20000);

        req.setAttribute("3k-5k", s1);
        req.setAttribute("5k-8k", s2);
        req.setAttribute("8k-12k", s3);
        req.setAttribute("12k以上", s4);

        req.getRequestDispatcher("leader.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }


}
