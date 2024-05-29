package model;

import java.math.BigDecimal;

public class Salary {
    private int empNo; // 员工编号
    private int year; // 工资所属年份
    private int month; // 工资所属月份
    private BigDecimal basicSalary; // 基本工资
    private BigDecimal positionAllowance; // 岗位津贴
    private BigDecimal lunchAllowance; // 午餐补贴
    private BigDecimal overtimePay; // 加班工资
    private BigDecimal fullAttendanceBonus; // 全勤奖
    private BigDecimal socialSecurity; // 社保
    private BigDecimal housingFund; // 公积金
    private BigDecimal personalTax; // 个人所得税
    private BigDecimal deduction; // 其他扣除项
    private BigDecimal netSalary; // 实发工资

    public Salary() {
    }

    public Salary(int empNo, int year, int month, BigDecimal basicSalary, BigDecimal positionAllowance,
                  BigDecimal lunchAllowance, BigDecimal overtimePay, BigDecimal fullAttendanceBonus, BigDecimal socialSecurity,
                  BigDecimal housingFund, BigDecimal personalTax, BigDecimal deduction, BigDecimal netSalary)
    {
        this.empNo = empNo;
        this.year = year;
        this.month = month;
        this.basicSalary = basicSalary;
        this.positionAllowance = positionAllowance;
        this.lunchAllowance = lunchAllowance;
        this.overtimePay = overtimePay;
        this.fullAttendanceBonus = fullAttendanceBonus;
        this.socialSecurity = socialSecurity;
        this.housingFund = housingFund;
        this.personalTax = personalTax;
        this.deduction = deduction;
        this.netSalary = netSalary;
    }


    // Getters and Setters

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

    public BigDecimal getPositionAllowance() {
        return positionAllowance;
    }

    public void setPositionAllowance(BigDecimal positionAllowance) {
        this.positionAllowance = positionAllowance;
    }

    public BigDecimal getLunchAllowance() {
        return lunchAllowance;
    }

    public void setLunchAllowance(BigDecimal lunchAllowance) {
        this.lunchAllowance = lunchAllowance;
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

    public BigDecimal getSocialSecurity() {
        return socialSecurity;
    }

    public void setSocialSecurity(BigDecimal socialSecurity) {
        this.socialSecurity = socialSecurity;
    }

    public BigDecimal getHousingFund() {
        return housingFund;
    }

    public void setHousingFund(BigDecimal housingFund) {
        this.housingFund = housingFund;
    }

    public BigDecimal getPersonalTax() {
        return personalTax;
    }

    public void setPersonalTax(BigDecimal personalTax) {
        this.personalTax = personalTax;
    }

    public BigDecimal getDeduction() {
        return deduction;
    }

    public void setDeduction(BigDecimal deduction) {
        this.deduction = deduction;
    }

    public BigDecimal getNetSalary() {
        return netSalary;
    }

    public void setNetSalary(BigDecimal netSalary) {
        this.netSalary = netSalary;
    }
}
