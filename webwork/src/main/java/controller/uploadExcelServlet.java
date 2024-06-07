package controller;

import org.apache.tomcat.util.http.fileupload.FileItemIterator;
import org.apache.tomcat.util.http.fileupload.FileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import service.SalaryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;


// 上传excel
@WebServlet("/uploadExcelServlet")
@MultipartConfig    // 处理文件上传
public class uploadExcelServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SalaryService s = new SalaryService();
        // 从HTTP请求中获取名为 "file" 的 Part 对象。 Part 对象代表上传的文件或表单字段。
        // req.getPart("file") 是从 HttpServletRequest 对象 req 中获取 file 字段对应的 Part
        // file 是前端表单中文件上传控件的名称
        Part filePart = req.getPart("file");

        // 从上传文件的Part中获取输入流
        InputStream file = filePart.getInputStream();

        s.uploadExcel(file);

        resp.sendRedirect(req.getContextPath() + "/financialManager.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private String getFileName(Part part) {
        // 从上传文件的Part中提取文件名。它通过解析HTTP请求头中的content-disposition字段来获取文件名。
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
