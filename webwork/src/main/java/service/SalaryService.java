package service;

import model.Salary;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class SalaryService {
    private SalaryDao salaryDao = new SalaryDao();
    public double show(int low, int high) {
        // 工资区间在low ,high之间的人数
        int n = salaryDao.selectSalary(low, high);
        // 总人数
        int count = salaryDao.count();

        return n / count;
    }
    public void uploadExcel(InputStream excelFileStream) throws IOException {
        // 读取Excel文件
        // 传入的excelFileStream创建了一个Workbook实例，这个实例代表了整个Excel工作簿（即Excel文件）
        // XSSFWorkbook是Apache POI中用于处理XLSX格式（Office Open XML Spreadsheet）的类
        Workbook workbook = new XSSFWorkbook(excelFileStream);

        // 这行代码从工作簿中获取第一个工作表（Sheet），索引从0开始
        Sheet sheet = workbook.getSheetAt(0);

        List<Salary> list = new ArrayList<>();


        for (Row row : sheet) {
            // Excel的列分别是工资ID,员工ID,工资所属年份,工资所属月份,基本工资,
            // 加班工资,全勤奖,社保,公积金,个人所得税,实发工资

            // 获取工资ID
            int salaryId = (int)row.getCell(0).getNumericCellValue();

            // 获取员工ID
            int empID = (int)row.getCell(1).getNumericCellValue();

            // 获取工资所属年份
            int year = (int)row.getCell(2).getNumericCellValue();

            // 获取月份
            int month = (int)row.getCell(3).getNumericCellValue();

            // 获取基本工资
            BigDecimal basicSalary = BigDecimal.valueOf(row.getCell(4).getNumericCellValue());


            // 加班工资
            BigDecimal overtimePay = BigDecimal.valueOf(row.getCell(5).getNumericCellValue());

            // 全勤奖
            BigDecimal fullAttendanceBonus = BigDecimal.valueOf(row.getCell(6).getNumericCellValue());

            // 社保
            BigDecimal socialSecurity = BigDecimal.valueOf(row.getCell(7).getNumericCellValue());

            // 公积金
            BigDecimal housingFund = BigDecimal.valueOf(row.getCell(8).getNumericCellValue());

            // 个人所得税
            BigDecimal personalTax = BigDecimal.valueOf(row.getCell(9).getNumericCellValue());

            // 实发工资
            BigDecimal netSalary = BigDecimal.valueOf(row.getCell(10).getNumericCellValue());


            Salary salary = new Salary(salaryId, empID, year, month, basicSalary
            , overtimePay, fullAttendanceBonus, socialSecurity, housingFund,
                    personalTax, netSalary);
            list.add(salary);

        }
        workbook.close();
        salaryDao.save(list);
    }
    public void exportExcel() throws IOException {
        List<Salary> list = salaryDao.selectAll();

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Salaries");

        // 添加表头
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("工资ID");
        headerRow.createCell(1).setCellValue("员工ID");
        headerRow.createCell(2).setCellValue("工资所属年份");
        headerRow.createCell(3).setCellValue("工资所属月份");
        headerRow.createCell(4).setCellValue("基本工资");
        headerRow.createCell(5).setCellValue("加班工资");
        headerRow.createCell(6).setCellValue("全勤奖");
        headerRow.createCell(7).setCellValue("社保");
        headerRow.createCell(8).setCellValue("公积金");
        headerRow.createCell(9).setCellValue("个人所得税");
        headerRow.createCell(10).setCellValue("实发工资");


        // 添加数据
        int rowNum = 1;
        for (Salary salary : list) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(salary.getSalaryId());
            row.createCell(1).setCellValue(salary.getEmpId());
            row.createCell(2).setCellValue(salary.getYear());
            row.createCell(3).setCellValue(salary.getMonth());
            row.createCell(4).setCellValue(String.valueOf(salary.getBasicSalary()));
            row.createCell(5).setCellValue(String.valueOf(salary.getOvertimePay()));
            row.createCell(6).setCellValue(String.valueOf(salary.getFullAttendanceBonus()));
            row.createCell(7).setCellValue(String.valueOf(salary.getSocialSecurity()));
            row.createCell(8).setCellValue(String.valueOf(salary.getHousingFund()));
            row.createCell(9).setCellValue(String.valueOf(salary.getPersonalTax()));
            row.createCell(10).setCellValue(String.valueOf(salary.getNetSalary()));

        }

        // 设置响应头信息
//        resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
//        resp.setHeader("Content-Disposition", "attachment; filename=salaries.xlsx");

        // 写入响应输出流
//        try (ServletOutputStream out = response.getOutputStream()) {
//            workbook.write(out);
//        }

        // 关闭工作簿资源
        workbook.close();
    }
}
