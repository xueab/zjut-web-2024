package util;

import com.alibaba.druid.pool.DruidDataSource;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 基类
 * 1.创建连接对象
 * 2.关闭资源
 * 3.增加，删除，修改操作
 * 4.查询方法
 *
 */

public class BaseDao {

    // Druid连接池数据源
    private static DruidDataSource dataSource;

    static {
        dataSource = new DruidDataSource();
        dataSource.setUrl("jdbc:mysql://localhost:3306/db1");
        dataSource.setUsername("root");
        dataSource.setPassword("chx200466");
        //dataSource.setPassword("xyk200406");
        //dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
        dataSource.setInitialSize(5); // 初始化时建立物理连接的个数
        dataSource.setMaxActive(13); // 最大连接池数量
        dataSource.setMinIdle(5); // 最小连接池数量
        dataSource.setMaxWait(6000); // 获取连接时最大等待时间，单位毫秒
        // 可以根据需要设置其他配置
    }

    protected PreparedStatement pstmt = null;
    protected Connection conn = null;
    protected ResultSet rs = null;

    /**
     * 获取连接对象
     * @return
     */
    public Connection getConnection() {
        try {
            conn = dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * 关闭资源
     * @param conn
     * @param pstmt
     * @param rs
     */
    public void closeAll(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    /**
     * 增删改操作
     * @param sql
     * @param params
     * @return
     */
    public int executeUpdate(String sql, Object... params) {
        conn = this.getConnection();
        int result = -1;
        try {
            pstmt = conn.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i + 1, params[i]);
                }
            }
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeAll(conn, pstmt, rs);
        }
        return result;
    }

    /**
     * 查询方法
     * @param sql
     * @param params
     * @return
     */
    public ResultSet executQuery(String sql, Object... params) {
        conn = this.getConnection();
        try {
            pstmt = conn.prepareStatement(sql);
            if (params != null) {
                for (int i = 0; i < params.length; i++) {
                    pstmt.setObject(i + 1, params[i]);
                }
            }
            rs = pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
}
