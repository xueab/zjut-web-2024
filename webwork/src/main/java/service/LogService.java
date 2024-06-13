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

//    public List<Log> selectAll() {
//        //return logDao.selectAll();
//    }

    public List<Log> search(String keyword) {
        return logDao.search(keyword);
    }

    public List<Log> selectByPage(int page) {
        return logDao.selectByPage(page * 10);
    }

    public List<Log> searchByName(String name) {
        return logDao.serchByName(name);
    }

    public List<Salary> searchByDate(Date beginTime, Date endTime) {
        // 将Date转换成Calendar
        // 创建一个 Calendar 对象并设置时间为当前 date
        Calendar calendarBegin = Calendar.getInstance();
        calendarBegin.setTime(beginTime);
        Calendar calendarEnd = Calendar.getInstance();
        calendarEnd.setTime(endTime);

        // 获取年份
        int beginYear = calendarBegin.get(Calendar.YEAR);
        int endYear = calendarEnd.get(Calendar.YEAR);

        // 获取月份
        int beginMonth = calendarBegin.get(Calendar.MONTH) + 1;
        int endMonth = calendarEnd.get(Calendar.MONTH) + 1;

        logDao.searchByDate(beginYear, beginMonth, endYear, endMonth);
    }
}
