package controller;

import model.Log;
import model.Salary;
import service.LogService;
import service.SalaryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/searchServlet")
public class searchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
/*        String name = req.getParameter("name");
        String keyword = req.getParameter("keyword");
        if (name.equals("Salary")) {
            SalaryService salaryService = new SalaryService();
            List<Salary> list = salaryService.search(keyword);
            req.setAttribute("list", list);
            req.getRequestDispatcher("/financialManager.jsp").forward(req, resp);
        }
        else if (name.equals("Log")) {
            LogService logService = new LogService();
            logService.search(keyword);
            List<Log> list = logService.search(keyword);
            req.setAttribute("list", list);
            req.getRequestDispatcher("/Log.jsp").forward(req, resp);
        }*/
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
