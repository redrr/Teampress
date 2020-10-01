package hu.playmaker.common.factory.excel;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.io.File;
import java.util.ArrayList;
import java.util.Objects;

public class ExcelBuilder {

    String sheetName;
    String fileName;
    String[] titleRow;
    ArrayList<String[]> dataRows = new ArrayList<>();

    public ExcelBuilder setFileName(String name) {
        this.fileName = name;
        return this;
    }

    public ExcelBuilder setSheetName(String name) {
        this.sheetName = name;
        return this;
    }

    public ExcelBuilder addTitle(String... titles) {
        this.titleRow = ArrayUtils.addAll(titleRow, titles);
        return this;
    }

    public ExcelBuilder addData(String... data) {
        this.dataRows.add(data);
        return this;
    }

    public File build() {
        if(Objects.isNull(this.fileName) || this.fileName.trim().equals("")) {
            return null;
        }
        if(Objects.isNull(this.sheetName) || this.sheetName.trim().equals("")) {
            return null;
        }
        if(Objects.isNull(this.titleRow) || this.titleRow.length == 0) {
            return null;
        }
        if(Objects.isNull(this.dataRows) || this.dataRows.size() == 0) {
            return null;
        }
        try {
            String filename = this.fileName ;
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet(this.sheetName);

            HSSFRow rowhead = sheet.createRow((short)0);
            for(int i = 0; i < titleRow.length; i++) {
                rowhead.createCell(i).setCellValue(titleRow[i]);
            }

            for(int i = 0; i < dataRows.size(); i++) {
                HSSFRow row = sheet.createRow((short)i+1);
                for(int j = 0; j < dataRows.get(i).length; j++) {
                    row.createCell(j).setCellValue(dataRows.get(i)[j]);
                }
            }

            File fileOut = new File(filename);
            workbook.write(fileOut);
            workbook.close();
            return fileOut;
        } catch ( Exception ex ) {
            System.out.println(ex);
        }
        return null;
    }
}
