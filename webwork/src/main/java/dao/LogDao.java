package dao;

import model.Log;
import util.BaseDao;

public class LogDao extends BaseDao {

    public void add(Log log) {
        String sql = "insert into system_logs (timestamp,log_level,message,username,ip_address) values(?,?,?,?,?)";
        this.executeUpdate(sql,log.getTime(),log.getLevel(),log.getMessage(),log.getUsername(),log.getIpAddress());
    }
}
