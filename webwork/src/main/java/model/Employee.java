package model;

public class Employee {
    private int empNo; // 员工编号
    private String name; // 员工姓名
    private String depName;//部门名称
    private String position; // 岗位
    private String idNumber; // 身份证号
    private String phone; // 手机号
    private String address; // 住址

    public Employee() {
    }

    public Employee(int empNo, String name, String depName, String position, String idNumber, String phone, String address) {
        this.empNo = empNo;
        this.name = name;
        this.depName = depName;
        this.position = position;
        this.idNumber = idNumber;
        this.phone = phone;
        this.address = address;
    }

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

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
