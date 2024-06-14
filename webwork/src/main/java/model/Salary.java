package model;

import dao.SpecialDeductionDao;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class    Salary {
    private int empNo; // 员工编号
    private int year; // 工资所属年份
    private int month; // 工资所属月份
    private BigDecimal basicSalary; // 基本工资
    private BigDecimal overtimePay; // 加班工资
    private BigDecimal fullAttendanceBonus; // 全勤奖
    private BigDecimal personalTax; // 个人所得税
    private BigDecimal netSalary; // 实发工资

/*    public BigDecimal calculatePersonalTax() {
        BigDecimal ans = basicSalary;

    }*/

    public Salary() {
    }

    public Salary(int empNo, int year, int month, BigDecimal basicSalary, BigDecimal overtimePay,
                  BigDecimal fullAttendanceBonus, BigDecimal personalTax, BigDecimal netSalary)
    {
        this.empNo = empNo;
        this.year = year;
        this.month = month;
        this.basicSalary = basicSalary;
        this.overtimePay = overtimePay;
        this.fullAttendanceBonus = fullAttendanceBonus;
        this.personalTax = personalTax;
        this.netSalary = netSalary;
    }



    public int getEmpNo() {
        return empNo;
    }

    public void setEmpNo(int empNo) {
        this.empNo = empNo;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public BigDecimal getBasicSalary() {
        return basicSalary;
    }

    public void setBasicSalary(BigDecimal basicSalary) {
        this.basicSalary = basicSalary;
    }

    public BigDecimal getOvertimePay() {
        return overtimePay;
    }

    public void setOvertimePay(BigDecimal overtimePay) {
        this.overtimePay = overtimePay;
    }

    public BigDecimal getFullAttendanceBonus() {
        return fullAttendanceBonus;
    }

    public void setFullAttendanceBonus(BigDecimal fullAttendanceBonus) {
        this.fullAttendanceBonus = fullAttendanceBonus;
    }

    public BigDecimal getPersonalTax() {
        return personalTax;
    }

    public void setPersonalTax(BigDecimal personalTax) {
        this.personalTax = personalTax;
    }

    public BigDecimal getNetSalary() {
        return netSalary;
    }

    public void setNetSalary(BigDecimal netSalary) {
        this.netSalary = netSalary;
    }

    public BigDecimal calculatePersonalTax() {
        BigDecimal totalIncome = basicSalary.add(overtimePay).add(fullAttendanceBonus);

        SpecialDeductionDao deductionDao = new SpecialDeductionDao();
        BigDecimal monthlySpecialDeduction = deductionDao.getSpecialDeduction(empNo,year).divide(BigDecimal.valueOf(12), 2, RoundingMode.HALF_UP);
        BigDecimal basicDeduction = BigDecimal.valueOf(5000);
        BigDecimal taxableIncome = totalIncome.subtract(monthlySpecialDeduction).subtract(basicDeduction);

        if (taxableIncome.compareTo(BigDecimal.ZERO) <= 0) {
            return BigDecimal.ZERO;
        }

        BigDecimal tax = calculateTax(taxableIncome);

        return tax;
    }

    private BigDecimal calculateTax(BigDecimal monthlyTaxableIncome) {
        BigDecimal tax = BigDecimal.ZERO;

        if (monthlyTaxableIncome.compareTo(BigDecimal.valueOf(3000)) <= 0) {
            tax = monthlyTaxableIncome.multiply(BigDecimal.valueOf(0.03));
        } else if (monthlyTaxableIncome.compareTo(BigDecimal.valueOf(12000)) <= 0) {
            tax = monthlyTaxableIncome.subtract(BigDecimal.valueOf(3000)).multiply(BigDecimal.valueOf(0.10)).add(BigDecimal.valueOf(3000).multiply(BigDecimal.valueOf(0.03)));
        } else if (monthlyTaxableIncome.compareTo(BigDecimal.valueOf(25000)) <= 0) {
            tax = monthlyTaxableIncome.subtract(BigDecimal.valueOf(12000)).multiply(BigDecimal.valueOf(0.20)).add(BigDecimal.valueOf(12000).subtract(BigDecimal.valueOf(3000)).multiply(BigDecimal.valueOf(0.10))).add(BigDecimal.valueOf(3000).multiply(BigDecimal.valueOf(0.03)));
        } else if (monthlyTaxableIncome.compareTo(BigDecimal.valueOf(35000)) <= 0) {
            tax = monthlyTaxableIncome.subtract(BigDecimal.valueOf(25000)).multiply(BigDecimal.valueOf(0.25)).add(BigDecimal.valueOf(25000).subtract(BigDecimal.valueOf(12000)).multiply(BigDecimal.valueOf(0.20))).add(BigDecimal.valueOf(12000).subtract(BigDecimal.valueOf(3000)).multiply(BigDecimal.valueOf(0.10))).add(BigDecimal.valueOf(3000).multiply(BigDecimal.valueOf(0.03)));
        } else if (monthlyTaxableIncome.compareTo(BigDecimal.valueOf(55000)) <= 0) {
            tax = monthlyTaxableIncome.subtract(BigDecimal.valueOf(35000)).multiply(BigDecimal.valueOf(0.30)).add(BigDecimal.valueOf(35000).subtract(BigDecimal.valueOf(25000)).multiply(BigDecimal.valueOf(0.25))).add(BigDecimal.valueOf(25000).subtract(BigDecimal.valueOf(12000)).multiply(BigDecimal.valueOf(0.20))).add(BigDecimal.valueOf(12000).subtract(BigDecimal.valueOf(3000)).multiply(BigDecimal.valueOf(0.10))).add(BigDecimal.valueOf(3000).multiply(BigDecimal.valueOf(0.03)));
        } else if (monthlyTaxableIncome.compareTo(BigDecimal.valueOf(80000)) <= 0) {
            tax = monthlyTaxableIncome.subtract(BigDecimal.valueOf(55000)).multiply(BigDecimal.valueOf(0.35)).add(BigDecimal.valueOf(55000).subtract(BigDecimal.valueOf(35000)).multiply(BigDecimal.valueOf(0.30))).add(BigDecimal.valueOf(35000).subtract(BigDecimal.valueOf(25000)).multiply(BigDecimal.valueOf(0.25))).add(BigDecimal.valueOf(25000).subtract(BigDecimal.valueOf(12000)).multiply(BigDecimal.valueOf(0.20))).add(BigDecimal.valueOf(12000).subtract(BigDecimal.valueOf(3000)).multiply(BigDecimal.valueOf(0.10))).add(BigDecimal.valueOf(3000).multiply(BigDecimal.valueOf(0.03)));
        } else {
            tax = monthlyTaxableIncome.subtract(BigDecimal.valueOf(80000)).multiply(BigDecimal.valueOf(0.45)).add(BigDecimal.valueOf(80000).subtract(BigDecimal.valueOf(55000)).multiply(BigDecimal.valueOf(0.35))).add(BigDecimal.valueOf(55000).subtract(BigDecimal.valueOf(35000)).multiply(BigDecimal.valueOf(0.30))).add(BigDecimal.valueOf(35000).subtract(BigDecimal.valueOf(25000)).multiply(BigDecimal.valueOf(0.25))).add(BigDecimal.valueOf(25000).subtract(BigDecimal.valueOf(12000)).multiply(BigDecimal.valueOf(0.20))).add(BigDecimal.valueOf(12000).subtract(BigDecimal.valueOf(3000)).multiply(BigDecimal.valueOf(0.10))).add(BigDecimal.valueOf(3000).multiply(BigDecimal.valueOf(0.03)));
        }

        return tax.setScale(2, RoundingMode.HALF_UP);
    }

    public BigDecimal calculateNetSalary()
    {
        BigDecimal ans = basicSalary.add(overtimePay).add(fullAttendanceBonus).subtract(personalTax);
        return ans.setScale(2, RoundingMode.HALF_UP);
    }
}