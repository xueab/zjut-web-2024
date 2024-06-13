package dao;

import util.BaseDao;

import java.math.BigDecimal;
import java.sql.SQLException;

public class SpecialDeductionDao extends BaseDao {
    public void deleteByNo(int empNo)
    {
        String sql= "delete from specialdeduction where emp_no=?";
        this.executeUpdate(sql,empNo);
        return;
    }

    //计算专项附加扣除总额
    public BigDecimal getSpecialDeduction(int empNo,int year)
    {
        String sql= "select * from specialdeduction where emp_no=? and year=?";
        rs = this.executQuery(sql,empNo,year);
        BigDecimal bd = new BigDecimal(0);
        try {
            while (rs.next())
            {
                bd = bd.add(rs.getBigDecimal("education_deduction"));
                bd = bd.add(rs.getBigDecimal("continued_education_deduction"));
                bd = bd.add(rs.getBigDecimal("serious_illness_deduction"));
                bd = bd.add(rs.getBigDecimal("housing_loan_interest_deduction"));
                bd = bd.add(rs.getBigDecimal("housing_rent_deduction"));
                bd = bd.add(rs.getBigDecimal("elderly_support_deduction"));
                bd = bd.add(rs.getBigDecimal("childcare_deduction"));
                break;
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return bd;
    }
}
