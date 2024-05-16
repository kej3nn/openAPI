package egovframework.common.helper;

/**
 * 엑셀형태로 다운로드하는 Class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;

@Component
public class MetaExceldownhelper implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(MetaExceldownhelper.class);

    private final int maxCnt = 30000;


    public void afterPropertiesSet() {


    }

    /**
     * 메타엑셀다운로드
     * @param result
     * @param head
     * @param infNm
     * @param response
     * @param requset
     * @throws Exception
     */
    public void download(List<LinkedHashMap<String, ?>> result, List<String> head, String infNm, HttpServletResponse response, HttpServletRequest requset) {
        String fileNm = UtilString.replace(infNm, " ", "") + ".xls";
        HSSFWorkbook workbook = excelParsing(result, head, infNm);
        try {
            if (UtilString.getBrowser(requset).equals("I")) {
                fileNm = URLEncoder.encode(fileNm, "UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
            } else {
                fileNm = new String(fileNm.getBytes("UTF-8"), "ISO-8859-1");
            }
            //*|\:"<>/? 에러남
            response.setHeader("Access-Control-Allow-Origin", "*");
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment;filename=" + "\"" + UtilString.replace(fileNm, "/", "") + "\"");
            ServletOutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            out.close();

        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }


    }

    /**
     * 엑셀파싱
     * @param result
     * @param head
     * @param fileNm
     * @return
     */
    private HSSFWorkbook excelParsing(List<LinkedHashMap<String, ?>> result, List<String> head, String fileNm) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFRow row = null;
        HSSFSheet worksheet = null;
        worksheet = workbook.createSheet(UtilString.replace(fileNm, "/", ""));

        int colCnt = 0;
        int rowCnt = 1;
        int sheetCnt = 1;
        headCreate(head, worksheet);

        for (LinkedHashMap<String, ?> map : result) {
            colCnt = 0;
            if (rowCnt % maxCnt == 0) { //헤더 생성, 다시순번
                worksheet = workbook.createSheet(fileNm + sheetCnt++);
                headCreate(head, worksheet); //헤더 생성
                rowCnt--;
            }
            row = worksheet.createRow(rowCnt);
            for (Entry<String, ?> entry : map.entrySet()) {
                if (entry.getValue() instanceof BigDecimal) {
                    if ((entry.getValue() + "").indexOf(".") > -1) {
                        row.createCell(colCnt++).setCellValue(Double.parseDouble(entry.getValue() + ""));
                    } else {
                        row.createCell(colCnt++).setCellValue(Long.parseLong(entry.getValue() + ""));
                    }

                } else {
                    if (entry.getValue() == null) {
                        row.createCell(colCnt++).setCellValue("");
                    } else {
                        row.createCell(colCnt++).setCellValue(entry.getValue() + "");
                    }
                }
            }
            rowCnt++;
        }

        return workbook;
    }


    /**
     * 헤더 생성
     * @param head
     * @param worksheet
     */
    private void headCreate(List<String> head, HSSFSheet worksheet) {
        HSSFRow row = null;
        row = worksheet.createRow(0);
        int colCnt = 0;
        for (int i = 0; i < head.size(); i++) {
            row.createCell(colCnt++).setCellValue(head.get(i));
        }

    }

}
