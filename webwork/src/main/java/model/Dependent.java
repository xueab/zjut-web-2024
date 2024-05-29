package model;

public class Dependent {
    private int empNo; // 员工编号
    private String name; // 子女或老人姓名
    private String idNumber; // 身份证号
    private String relationship; // 关系（如子女、老人）


    public Dependent() {
    }

    public Dependent(int empNo, String name, String idNumber, String relationship) {
        this.empNo = empNo;
        this.name = name;
        this.idNumber = idNumber;
        this.relationship = relationship;
    }

    // Getters and Setters

    public int getEmpNo() {
        return empNo;
    }

    public void setEmpNo(int empNo) {
        this.empNo = empNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }
}