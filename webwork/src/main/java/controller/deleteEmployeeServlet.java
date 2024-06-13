package controller;

import service.EmployeeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// 删除员工信息
@WebServlet("/deleteemployee.do")
public class deleteEmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EmployeeService e = new EmployeeService();
        int empNo = Integer.parseInt(req.getParameter("deleteempNo"));
        String name = req.getParameter("deletename");
        String username = req.getParameter("username");

        e.deleteEmployee(empNo, name);

        System.out.println(empNo);
        System.out.println(name);

        // 重定向
        resp.sendRedirect(req.getContextPath() + "/peopleManager.jsp" + "?username=" + username);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
