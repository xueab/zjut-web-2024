package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import model.Employee;

@WebServlet("/showEmployeeServlet")
public class showEmployeeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("getDepartmentStats".equals(action)) {
            List<Employee> employeeList = getEmployeeList(); // 从数据库或其他数据源获取员工列表
            Map<String, Integer> departmentStats = new HashMap<>();

            for (Employee emp : employeeList) {
                String depName = emp.getDepName();
                departmentStats.put(depName, departmentStats.getOrDefault(depName, 0) + 1);
            }

            String json = new Gson().toJson(departmentStats);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.write(json);
            out.close();
        }
    }

    private List<Employee> getEmployeeList() {
        // 实现获取员工列表的逻辑
        return null;
    }
}
