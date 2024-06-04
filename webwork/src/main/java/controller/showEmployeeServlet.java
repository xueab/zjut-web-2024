package controller;

import service.EmployeeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// 显示各部门人数占比
@WebServlet("/showEmployeeServlet")
public class showEmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EmployeeService e = new EmployeeService();
        double n1 = e.show("a部门");
        double n2 = e.show("b部门");
        double n3 = e.show("c部门");
        double n4 = e.show("d部门");

        req.setAttribute("a部门", n1);
        req.setAttribute("b部门", n2);
        req.setAttribute("c部门", n3);
        req.setAttribute("d部门", n4);
        // 转发
        req.getRequestDispatcher("/peopleManager.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
