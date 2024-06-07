package service;

import dao.LogDao;
import model.Log;

public class LogService {
    private LogDao logDao = new LogDao();
    public void add(Log log) {
        logDao.add(log);
    }
}
