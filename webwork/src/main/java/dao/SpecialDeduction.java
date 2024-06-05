package dao;

import util.BaseDao;

public class SpecialDeduction extends BaseDao {
    public void deleteByNo(int empNo)
    {
        String sql= "delete from specialdeduction where emp_no=?";
        this.executeUpdate(sql,empNo);
        return;
    }
}
