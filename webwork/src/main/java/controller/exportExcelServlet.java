package controller;


import service.SalaryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


// 导出excel
@WebServlet("/exportExcelServlet")
public class exportExcelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SalaryService s = new SalaryService();
        s.exportExcel(resp);

        String username = new String(req.getParameter("username").getBytes("ISO-8859-1"),"utf-8");

        resp.sendRedirect(req.getContextPath() + "/financialManager.jsp" + "username=" + username);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
