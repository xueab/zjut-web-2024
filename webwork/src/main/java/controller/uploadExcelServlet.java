package controller;

import org.apache.tomcat.util.http.fileupload.FileItemIterator;
import org.apache.tomcat.util.http.fileupload.FileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import service.SalaryService;

import javax.servlet.ServletException;
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
@WebServlet("uploadExcelServlet")
public class uploadExcelServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SalaryService s = new SalaryService();

        Part filePart = req.getPart("file");
        String fileName = getFileName(filePart);
        // 保存路径
        // getServletContext().getRealPath("/")获取了应用程序的根目录，在其后追加了 "uploads" 文件夹和文件名
        // 使用了 File.separator 来保证路径在不同操作系统上的兼容性。
        String savePath = getServletContext().getRealPath("/") + "uploads" + File.separator + fileName;


        // 从上传文件的Part中获取输入流
        InputStream file = filePart.getInputStream();

        s.uploadExcel(file);

        resp.getWriter().println("File uploaded to: " + savePath);
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
