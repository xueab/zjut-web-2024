package dao;

import model.Employee;
import model.Log;
import model.Salary;
import util.BaseDao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class LogDao extends BaseDao {

    public List<Log> selectAll()
    {
        String sql = "select * from system_logs";
        rs = this.executQuery(sql,null);
        List<Log> list = new ArrayList<Log>();
        try {
            while(rs.next())
            {
                Log log = new Log();
                log.setTime(rs.getTimestamp("timestamp"));
                log.setLevel(rs.getString("log_level"));
                log.setMessage(rs.getString("message"));
                log.setUsername(rs.getString("username"));
                log.setIpAddress(rs.getString("ip_address"));
                list.add(log);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }
    public void add(Log log) {
        String sql = "insert into system_logs (timestamp,log_level,message,username,ip_address) values(?,?,?,?,?)";
        this.executeUpdate(sql,log.getTime(),log.getLevel(),log.getMessage(),log.getUsername(),log.getIpAddress());
    }

    public List<Log> selectByPage(int idx) {
        String sql = "select * from system_logs LIMIT ? ,10";
        rs = this.executQuery(sql,idx);
        List<Log> list = new ArrayList<Log>();
        try {
            while(rs.next())
            {
                Log log = new Log();
                log.setTime(rs.getTimestamp("timestamp"));
                log.setLevel(rs.getString("log_level"));
                log.setMessage(rs.getString("message"));
                log.setUsername(rs.getString("username"));
                log.setIpAddress(rs.getString("ip_address"));
                list.add(log);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }

    public List<Log> searchByDate(Date beginTime, Date endTime) {
        String sql = "select * from system_logs where timestamp >= ? and timestamp <= ?";
        rs = this.executQuery(sql,beginTime,endTime);
        List<Log> list = new ArrayList<Log>();
        try {
            while(rs.next())
            {
                Log log = new Log();
                log.setTime(rs.getTimestamp("timestamp"));
                log.setLevel(rs.getString("log_level"));
                log.setMessage(rs.getString("message"));
                log.setUsername(rs.getString("username"));
                log.setIpAddress(rs.getString("ip_address"));
                list.add(log);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }

    public List<Log> searchByName(String name) {
        String sql = "select * from system_logs where username = ?";
        rs = this.executQuery(sql,name);
        List<Log> list = new ArrayList<Log>();
        try {
            while(rs.next())
            {
                Log log = new Log();
                log.setTime(rs.getTimestamp("timestamp"));
                log.setLevel(rs.getString("log_level"));
                log.setMessage(rs.getString("message"));
                log.setUsername(rs.getString("username"));
                log.setIpAddress(rs.getString("ip_address"));
                list.add(log);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally {
            this.closeAll(this.conn,this.pstmt,this.rs);
        }
        return list;
    }

}
