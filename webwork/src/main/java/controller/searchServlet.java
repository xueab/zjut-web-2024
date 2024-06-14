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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;



@WebServlet("/searchServlet")
public class searchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");

        String keyword = req.getParameter("keyword");
        System.out.println(username);

        System.out.println(keyword);
        if (username.equals("Salary")) {
            SalaryService salaryService = new SalaryService();
            if (keyword.equals("deptName")) {
                // 按部门名查询
                String deptName = new String(req.getParameter("deptName").getBytes("ISO-8859-1"), "utf-8");
                List<Salary> list = salaryService.searchByDeptName(deptName);
                req.setAttribute("list", list);
                for (Salary salary : list) {
                    System.out.println("----");
                    System.out.println(salary);
                }
                req.getRequestDispatcher("/financialManager.jsp"+"?section=viewSalary").forward(req, resp);
            }
            else if (keyword.equals("name")) {
                // 按员工姓名查询
                String name = new String(req.getParameter("name").getBytes("ISO-8859-1"), "utf-8");
                System.out.println("--------------------------------------------");
                System.out.println(name);
                List<Salary> list = salaryService.searchByName(name);
                for (Salary salary : list) {
                    System.out.println("----");
                    System.out.println(salary);
                }
                req.setAttribute("list", list);
                req.getRequestDispatcher("/financialManager.jsp").forward(req, resp);
            }
            else if (keyword.equals("date")) {
                // 按时间查询
                String beginTimeStr = req.getParameter("startDate");
                String endTimeStr = req.getParameter("endDate");
                System.out.println(beginTimeStr);
                System.out.println(endTimeStr);
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");


                Date beginTime = null;
                Date endTime = null;
                try {
                    beginTime = dateFormat.parse(beginTimeStr);
                    endTime =  dateFormat.parse(endTimeStr);
                } catch (ParseException e) {
                    throw new RuntimeException(e);
                }

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
                String beginTimeStr = req.getParameter("startDate");
                String endTimeStr = req.getParameter("endDate");
                // 定义日期格式
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
                
                Date beginTime = null;
                Date endTime = null;
                try {
                    beginTime = dateFormat.parse(beginTimeStr);
                    endTime =  dateFormat.parse(endTimeStr);
                } catch (ParseException e) {
                    throw new RuntimeException(e);
                }
                List<Log> list = logService.searchByDate(beginTime, endTime);
                req.setAttribute("list", list);
                req.getRequestDispatcher("/Log.jsp").forward(req, resp);
            }

        }
        else if (username.equals("general")) {
            SalaryService salaryService = new SalaryService();
            if (keyword.equals("deptName")) {
                // 按部门名查询
                String deptName = new String(req.getParameter("deptName").getBytes("ISO-8859-1"), "utf-8");
                List<Salary> list = salaryService.searchByDeptName(deptName);
                req.setAttribute("list", list);
                for (Salary salary : list) {
                    System.out.println("----");
                    System.out.println(salary);
                }
                req.getRequestDispatcher("/generalManager.jsp").forward(req, resp);
            }
            else if (keyword.equals("name")) {
                // 按员工姓名查询
                String name = new String(req.getParameter("name").getBytes("ISO-8859-1"), "utf-8");
                System.out.println("--------------------------------------------");
                System.out.println(name);
                List<Salary> list = salaryService.searchByName(name);
                for (Salary salary : list) {
                    System.out.println("----");
                    System.out.println(salary);
                }
                req.setAttribute("list", list);
                req.getRequestDispatcher("/generalManager.jsp").forward(req, resp);
            }
            else if (keyword.equals("date")) {
                // 按时间查询
                String beginTimeStr = req.getParameter("startDate");
                String endTimeStr = req.getParameter("endDate");
                System.out.println(beginTimeStr);
                System.out.println(endTimeStr);
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");


                Date beginTime = null;
                Date endTime = null;
                try {
                    beginTime = dateFormat.parse(beginTimeStr);
                    endTime =  dateFormat.parse(endTimeStr);
                } catch (ParseException e) {
                    throw new RuntimeException(e);
                }

                List<Salary> list = salaryService.searchByDate(beginTime, endTime);
                req.setAttribute("list", list);
                req.getRequestDispatcher("/generalManager.jsp").forward(req, resp);
            }

        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
