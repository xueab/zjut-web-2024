package dao;

import util.BaseDao;

public class DependentDao extends BaseDao {
    public void deleteByNo(int empNo)
    {
        String sql = "delete from dependent where emp_no=?";
        this.executeUpdate(sql,empNo);
        return;
    }
}
