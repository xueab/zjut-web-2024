package model;

public class Dependent {
    private int dependentId; // 子女和老人信息ID
    private int empId; // 员工ID
    private String name; // 子女或老人姓名
    private String idNumber; // 身份证号
    private String relationship; // 关系（如子女、老人）

    // Getters and Setters
    public int getDependentId() {
        return dependentId;
    }

    public void setDependentId(int dependentId) {
        this.dependentId = dependentId;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
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