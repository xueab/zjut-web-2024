package service;

import dao.LogDao;
import model.Log;
import model.Salary;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class LogService {
    private LogDao logDao = new LogDao();
    public void add(Log log) {
        logDao.add(log);
    }

    public List<Log> selectAll() {
        return logDao.selectAll();
    }

/*    public List<Log> search(String keyword) {
        return logDao.search(keyword);
    }*/

    public List<Log> selectByPage(int page) {
        return logDao.selectByPage(page * 10);
    }

/*    public List<Log> searchByName(String name) {
        return logDao.serchByName(name);
    }*/

    public List<Log> searchByDate(Date beginTime, Date endTime) {
        return logDao.searchByDate(beginTime,endTime);
    }

    public List<Log> searchByName(String name) {

        return logDao.searchByName(name);
    }
}
