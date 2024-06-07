package model;

import java.util.Date;

public class Log {
    // private int id;     // 主键，唯一标识每条日志记录，自动递增。
    private Date time;   // 记录日志生成的时间。
    private String level;  // 记录日志的级别（如 INFO、ERROR、WARN 等）
    private String message;  // 具体的日志信息内容

    private String username;   // 生成日志的用户

    private String ipAddress;  // 生成日志的用户的 IP 地址

    public Log() {
    }

    public Log(Date time, String level, String message, String username, String ipAddress) {
        this.time = time;
        this.level = level;
        this.message = message;
        this.username = username;
        this.ipAddress = ipAddress;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }
}
