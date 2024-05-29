package model;

import java.util.Date;

public class OperationLog {
    private int userId; // 用户ID
    private Date operationTime; // 操作时间
    private String operationType; // 操作类型
    private String operationDescription; // 操作描述


    public OperationLog() {
    }

    public OperationLog(int userId, Date operationTime, String operationType, String operationDescription) {
        this.userId = userId;
        this.operationTime = operationTime;
        this.operationType = operationType;
        this.operationDescription = operationDescription;
    }

    // Getters and Setters

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getOperationTime() {
        return operationTime;
    }

    public void setOperationTime(Date operationTime) {
        this.operationTime = operationTime;
    }

    public String getOperationType() {
        return operationType;
    }

    public void setOperationType(String operationType) {
        this.operationType = operationType;
    }

    public String getOperationDescription() {
        return operationDescription;
    }

    public void setOperationDescription(String operationDescription) {
        this.operationDescription = operationDescription;
    }
}