package dao;

import model.Employee;
import util.BaseDao;

import java.util.ArrayList;
import java.util.List;

public class EmployeeDao extends BaseDao {

    public int count()
    {
        List<Employee> list = this.selectAll();
        return list.size();
    }

    public List<Employee> selectAll()//查找所有员工
    {
        String sql = "select * from employee";
        rs = this.executQuery(sql,null);
        List<Employee> list = new ArrayList<Employee>();
        try {
            while(rs.next())
            {
                Employee employee = new Employee();
                employee.setEmpNo(rs.getString("emp_no"));
                employee.setName(rs.getString("name"));
                employee.setDepName(rs.getString("dept_name"));
                employee.setPosition(rs.getString("position"));
                employee.setIdNumber(rs.getString("id_number"));
                employee.setPhone(rs.getString("phone"));
                employee.setAddress(rs.getString("address"));
                list.add(employee);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }

    public int selectByName(String deptName)
    {
        String sql = "select * from employee where dept_name=?";
        rs = this.executQuery(sql,deptName);
        List<Employee> list = new ArrayList<Employee>();
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

    public void add(Employee employee)
    {
        String sql = "insert into employee (emp_no,name,dept_name,position,id_number,phone,address) values(?,?,?,?,?,?,?)";
        this.executeUpdate(sql,employee.getEmpNo(),employee.getName(),employee.getDepName(),employee.getPosition(),employee.getIdNumber(),employee.getPhone(),employee.getAddress());
        return ;
    }

    public void update(Employee employee)
    {
        String sql = "update employee set dept_name = ?,position = ?,id_number = ?,phone = ?,address = ? where emp_no = ?";
        this.executeUpdate(sql,employee.getDepName(),employee.getPosition(),employee.getIdNumber(),employee.getPhone(),employee.getAddress(),employee.getEmpNo());
        return ;
    }

    public void delete(String name)
    {
        String sql = "delete from employee where name = ?";
        this.executeUpdate(sql,name);
        return ;
    }
}