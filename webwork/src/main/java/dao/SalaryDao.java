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

    public void delete(Salary salary) {
        String sql = "delete from salary where emp_no=? and year=? and month=?";
        this.executeUpdate(sql,salary.getEmpNo(),salary.getYear(),salary.getMonth());
        return ;
    }
}
