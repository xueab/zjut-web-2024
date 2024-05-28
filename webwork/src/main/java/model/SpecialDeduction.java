package model;

import java.math.BigDecimal;

public class SpecialDeduction {
    private int deductionId; // 扣除ID
    private int empId; // 员工ID
    private int year; // 年份
    private BigDecimal educationDeduction; // 子女教育扣除
    private BigDecimal continuedEducationDeduction; // 继续教育扣除
    private BigDecimal seriousIllnessDeduction; // 大病医疗扣除
    private BigDecimal housingLoanInterestDeduction; // 住房贷款利息扣除
    private BigDecimal housingRentDeduction; // 住房租金扣除
    private BigDecimal elderlySupportDeduction; // 赡养老人扣除
    private BigDecimal childcareDeduction; // 婴幼儿照护扣除

    // Getters and Setters
    public int getDeductionId() {
        return deductionId;
    }

    public void setDeductionId(int deductionId) {
        this.deductionId = deductionId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public BigDecimal getEducationDeduction() {
        return educationDeduction;
    }

    public void setEducationDeduction(BigDecimal educationDeduction) {
        this.educationDeduction = educationDeduction;
    }

    public BigDecimal getContinuedEducationDeduction() {
        return continuedEducationDeduction;
    }

    public void setContinuedEducationDeduction(BigDecimal continuedEducationDeduction) {
        this.continuedEducationDeduction = continuedEducationDeduction;
    }

    public BigDecimal getSeriousIllnessDeduction() {
        return seriousIllnessDeduction;
    }

    public void setSeriousIllnessDeduction(BigDecimal seriousIllnessDeduction) {
        this.seriousIllnessDeduction = seriousIllnessDeduction;
    }

    public BigDecimal getHousingLoanInterestDeduction() {
        return housingLoanInterestDeduction;
    }

    public void setHousingLoanInterestDeduction(BigDecimal housingLoanInterestDeduction) {
        this.housingLoanInterestDeduction = housingLoanInterestDeduction;
    }

    public BigDecimal getHousingRentDeduction() {
        return housingRentDeduction;
    }

    public void setHousingRentDeduction(BigDecimal housingRentDeduction) {
        this.housingRentDeduction = housingRentDeduction;
    }

    public BigDecimal getElderlySupportDeduction() {
        return elderlySupportDeduction;
    }

    public void setElderlySupportDeduction(BigDecimal elderlySupportDeduction) {
        this.elderlySupportDeduction = elderlySupportDeduction;
    }

    public BigDecimal getChildcareDeduction() {
        return childcareDeduction;
    }

    public void setChildcareDeduction(BigDecimal childcareDeduction) {
        this.childcareDeduction = childcareDeduction;
    }
}