package dao;

import model.Salary;
import model.User;
import util.BaseDao;

import java.util.ArrayList;
import java.util.List;

public class SalaryDao extends BaseDao {
    public List<Salary> selectAll()
    {
        String sql = "select * from salary";
        rs = this.executQuery(sql,null);
        List<Salary> list = new ArrayList<Salary>();
        try {
            while(rs.next())
            {
                Salary salary = new Salary();
                salary.setEmpNo(rs.getInt("emp_no"));
                salary.setYear(rs.getInt("year"));
                salary.setMonth(rs.getInt("month"));
                salary.setBasicSalary(rs.getBigDecimal("basic_salary"));
                salary.setOvertimePay(rs.getBigDecimal("overtime_pay"));
                salary.setFullAttendanceBonus(rs.getBigDecimal("full_attendance_bonus"));
                salary.setPersonalTax(rs.getBigDecimal("personal_tax"));
                salary.setNetSalary(rs.getBigDecimal("net_salary"));
                list.add(salary);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }

    public int selectSalary(int low, int high) {
        String sql = "select * from salary where net_salary >= ? and net_salary <= ?";
        rs = this.executQuery(sql,low,high);
        int ans = 0;
        try {
            while(rs.next())
            {
                ans++;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return ans;
    }

    public int count() {
        String sql = "select * from salary";
        List<Salary> list = this.selectAll();
        return list.size();
    }


    public void save(List<Salary> list) {
        for (Salary salary : list) {
            this.add(salary);
        }
        return ;
    }

    public void add(Salary salary) {
        String sql = "insert into salary (emp_no,year,month,basic_salary,overtime_pay,full_attendance_bonus,personal_tax,net_salary) values(?,?,?,?,?,?,?,?)";
        this.executeUpdate(sql,salary.getEmpNo(),salary.getYear(),salary.getMonth(),salary.getBasicSalary(),salary.getOvertimePay(),
                salary.getFullAttendanceBonus(),salary.getPersonalTax(),salary.getNetSalary());
        return;
    }

    public void update(Salary salary) {
        String sql = "update salary set basic_salary = ?,overtime_pay = ?,full_attendance_bonus = ?,personal_tax = ? ,net_salary = ? where emp_no = ? and year = ? and month = ?";
        this.executeUpdate(sql,salary.getBasicSalary(),salary.getOvertimePay(),salary.getFullAttendanceBonus(),
                salary.getPersonalTax(),salary.getNetSalary(),salary.getEmpNo(),salary.getYear(),salary.getMonth());
        return;
    }

    public void delete(int empNo, int year, int month) {
        String sql = "delete from salary where emp_no=? and year=? and month=?";
        this.executeUpdate(sql,empNo,year,month);
        return ;
    }

    public void deleteByNo(int empNo) {
        String sql = "delete from salary where emp_no=?";
        this.executeUpdate(sql,empNo);
        return;
    }

    public List<Salary> selectByPage(int idx) {
        String sql = "select * from salary limit ?,10";
        rs = this.executQuery(sql,idx);
        List<Salary> list = new ArrayList<Salary>();
        try {
            while(rs.next())
            {
                Salary salary = new Salary();
                salary.setEmpNo(rs.getInt("emp_no"));
                salary.setYear(rs.getInt("year"));
                salary.setMonth(rs.getInt("month"));
                salary.setBasicSalary(rs.getBigDecimal("basic_salary"));
                salary.setOvertimePay(rs.getBigDecimal("overtime_pay"));
                salary.setFullAttendanceBonus(rs.getBigDecimal("full_attendance_bonus"));
                salary.setPersonalTax(rs.getBigDecimal("personal_tax"));
                salary.setNetSalary(rs.getBigDecimal("net_salary"));
                list.add(salary);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }

    public List<Salary> serchByName(String name) {
        String sql = "SELECT salary.emp_no,salary.year,salary.month,salary.basic_salary,salary.overtime_pay," +
                "salary.full_attendance_bonus,salary.personal_tax,salary.net_salary FROM salary,employee " +
                "WHERE salary.emp_no = employee.emp_no AND employee.name = ?";
        rs=this.executQuery(sql,name);
        List<Salary> list = new ArrayList<Salary>();
        try {
            while(rs.next())
            {
                Salary salary = new Salary();
                salary.setEmpNo(rs.getInt("emp_no"));
                salary.setYear(rs.getInt("year"));
                salary.setMonth(rs.getInt("month"));
                salary.setBasicSalary(rs.getBigDecimal("basic_salary"));
                salary.setOvertimePay(rs.getBigDecimal("overtime_pay"));
                salary.setFullAttendanceBonus(rs.getBigDecimal("full_attendance_bonus"));
                salary.setPersonalTax(rs.getBigDecimal("personal_tax"));
                salary.setNetSalary(rs.getBigDecimal("net_salary"));
                list.add(salary);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }

    public List<Salary> searchByDeptName(String deptName) {
        String sql = "SELECT salary.emp_no,salary.year,salary.month,salary.basic_salary,salary.overtime_pay," +
                "salary.full_attendance_bonus,salary.personal_tax,salary.net_salary FROM salary,employee " +
                "WHERE salary.emp_no = employee.emp_no AND employee.dept_name = ?";
        rs=this.executQuery(sql,deptName);
        List<Salary> list = new ArrayList<Salary>();
        try {
            while(rs.next())
            {
                Salary salary = new Salary();
                salary.setEmpNo(rs.getInt("emp_no"));
                salary.setYear(rs.getInt("year"));
                salary.setMonth(rs.getInt("month"));
                salary.setBasicSalary(rs.getBigDecimal("basic_salary"));
                salary.setOvertimePay(rs.getBigDecimal("overtime_pay"));
                salary.setFullAttendanceBonus(rs.getBigDecimal("full_attendance_bonus"));
                salary.setPersonalTax(rs.getBigDecimal("personal_tax"));
                salary.setNetSalary(rs.getBigDecimal("net_salary"));
                list.add(salary);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }

    public List<Salary> searchByDate(int beginYear, int beginMonth, int endYear, int endMonth) {
        String sql = "SELECT * FROM Salary WHERE (year > ? OR (year = ? AND month >= ?)) " +
                "AND (year < ? OR (year = ? AND month <= ?))";
        rs = this.executQuery(sql,beginYear,beginYear,beginMonth,endYear,endYear,endMonth);
        List<Salary> list = new ArrayList<Salary>();
        try {
            while(rs.next())
            {
                Salary salary = new Salary();
                salary.setEmpNo(rs.getInt("emp_no"));
                salary.setYear(rs.getInt("year"));
                salary.setMonth(rs.getInt("month"));
                salary.setBasicSalary(rs.getBigDecimal("basic_salary"));
                salary.setOvertimePay(rs.getBigDecimal("overtime_pay"));
                salary.setFullAttendanceBonus(rs.getBigDecimal("full_attendance_bonus"));
                salary.setPersonalTax(rs.getBigDecimal("personal_tax"));
                salary.setNetSalary(rs.getBigDecimal("net_salary"));
                list.add(salary);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }


}
