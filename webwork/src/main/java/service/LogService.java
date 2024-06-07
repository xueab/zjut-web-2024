package service;

import dao.LogDao;
import model.Log;

import java.util.List;

public class LogService {
    private LogDao logDao = new LogDao();
    public void add(Log log) {
        logDao.add(log);
    }

//    public List<Log> selectAll() {
//        //return logDao.selectAll();
//    }

    public List<Log> selectByPage(int page) {
        return logDao.selectByPage(page * 10);
    }
}
