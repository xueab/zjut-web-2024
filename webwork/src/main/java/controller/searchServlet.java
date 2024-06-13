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
import java.util.Date;
import java.util.List;


@WebServlet("/searchServlet")
public class searchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String keyword = req.getParameter("keyword");
        if (username.equals("Salary")) {
            SalaryService salaryService = new SalaryService();
            if (keyword.equals("deptName")) {
                // 按部门名查询
                String deptName = req.getParameter("deptName");
                List<Salary> list = salaryService.searchByDeptName(deptName);
                req.setAttribute("list", list);
                req.getRequestDispatcher("/financialManager.jsp").forward(req, resp);
            }
            else if (keyword.equals("name")) {
                // 按员工姓名查询
                String name = req.getParameter("name");
                List<Salary> list = salaryService.searchByName(name);
                req.setAttribute("list", list);
                req.getRequestDispatcher("/financialManager.jsp").forward(req, resp);
            }
            else if (keyword.equals("date")) {
                // 按时间查询
                Date beginTime = new Date(req.getParameter("startDate"));
                Date endTime = new Date(req.getParameter("endDate"));
                List<Salary> list = salaryService.searchByDate(beginTime, endTime);
                req.setAttribute("list", list);
                req.getRequestDispatcher("/financialManager.jsp").forward(req, resp);
            }

        }
        else if (username.equals("Log")) {
            LogService logService = new LogService();
            if (keyword.equals("name")) {
                String name = req.getParameter("name");
                List<Log> list = logService.searchByName(name);
                req.setAttribute("list", list);
                req.getRequestDispatcher("/Log.jsp").forward(req, resp);
            }
            else if (keyword.equals("date")) {
                // 按时间查询
                Date beginTime = new Date(req.getParameter("startDate"));
                Date endTime = new Date(req.getParameter("endDate"));
                List<Log> list = logService.searchByDate(beginTime, endTime);
                req.setAttribute("list", list);
                req.getRequestDispatcher("/Log.jsp").forward(req, resp);
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
