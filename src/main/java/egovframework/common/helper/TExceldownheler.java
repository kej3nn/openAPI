package egovframework.common.helper;

/**
 * 엑셀형태로 다운로드하는 Class
 *
 * @author wiseopen
 * @version 1.0
 * @see
 * @since 2014.04.17
 */

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
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.util.UtilString;

@Component
public class TExceldownheler implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(TExceldownheler.class);

    private final int maxCnt = 30000;


    public void afterPropertiesSet() {


    }

    /**
     * 엑셀 형태로 다운로드 한다.
     * @param result
     * @param head
     * @param infNm
     * @param response
     * @param requset
     * @throws Exception
     */
    public void download(List<LinkedHashMap<String, ?>> result, LinkedHashMap<String, ?> head, String infNm, HttpServletResponse response, HttpServletRequest requset) {
        try {

            if (head != null) {
                result.add(0, head);
            }
            String fileNm = UtilString.replace(infNm, " ", "") + ".xls";
            HSSFWorkbook workbook = excelParsing(result, infNm);        //mapper가 없나???
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
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * 엑셀형태로 파싱을 한다.
     * @param result
     * @param fileNm
     * @return
     * @throws Exception
     */
    private HSSFWorkbook excelParsing(List<LinkedHashMap<String, ?>> result, String fileNm) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFRow row = null;
        HSSFSheet worksheet = null;
        worksheet = workbook.createSheet(UtilString.replace(fileNm, "/", ""));

        HSSFDataFormat format = workbook.createDataFormat();
        HSSFCellStyle styleRight1 = workbook.createCellStyle();
        styleRight1.setDataFormat(format.getFormat("#,##0.########"));
        styleRight1.setAlignment(HSSFCellStyle.ALIGN_RIGHT);

        HSSFCellStyle styleRight2 = workbook.createCellStyle();
        styleRight2.setDataFormat(format.getFormat("#,##0"));
        styleRight2.setAlignment(HSSFCellStyle.ALIGN_RIGHT);

        HSSFCellStyle styleRight3 = workbook.createCellStyle();
        styleRight3.setAlignment(HSSFCellStyle.ALIGN_RIGHT);

        HSSFCellStyle styleLeft1 = workbook.createCellStyle();
        styleLeft1.setDataFormat(format.getFormat("#,##0.########"));
        styleLeft1.setAlignment(HSSFCellStyle.ALIGN_LEFT);

        HSSFCellStyle styleLeft2 = workbook.createCellStyle();
        styleLeft2.setDataFormat(format.getFormat("#,##0"));
        styleLeft2.setAlignment(HSSFCellStyle.ALIGN_LEFT);

        HSSFCellStyle styleLeft3 = workbook.createCellStyle();
        styleLeft3.setAlignment(HSSFCellStyle.ALIGN_LEFT);

        HSSFCellStyle styleCenter1 = workbook.createCellStyle();
        styleCenter1.setDataFormat(format.getFormat("#,##0.########"));
        styleCenter1.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        HSSFCellStyle styleCenter2 = workbook.createCellStyle();
        styleCenter2.setDataFormat(format.getFormat("#,##0"));
        styleCenter2.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        HSSFCellStyle styleCenter3 = workbook.createCellStyle();
        styleCenter3.setAlignment(HSSFCellStyle.ALIGN_CENTER);

        LinkedHashMap<String, ?> headMap = result.get(0); //head정보
        int colCnt = 0;
        int rowCnt = 1;
        int sheetCnt = 1;
        boolean firstYn = true;
        headCreate(headMap, worksheet, workbook); //헤더 생성

        for (LinkedHashMap<String, ?> map : result) {
            colCnt = 0;
            if (firstYn) {
                firstYn = false;
                continue;
            }
            if (rowCnt % maxCnt == 0) { //헤더 생성, 다시순번
                worksheet = workbook.createSheet(fileNm + sheetCnt++);
                headCreate(headMap, worksheet, workbook); //헤더 생성
                rowCnt = 1;
            }
            row = worksheet.createRow(rowCnt);
            for (Entry<String, ?> entry : map.entrySet()) {
                if (((String) entry.getKey()).equals("ITEM_CD1") ||
                        ((String) entry.getKey()).equals("ITEM_CD2") ||
                        ((String) entry.getKey()).equals("V_ORDER") ||
                        ((String) entry.getKey()).equals("YYYYMQ") ||
                        ((String) entry.getKey()).equals("RN") ||
                        ((String) entry.getKey()).equals("CONV_CD_1") ||
                        ((String) entry.getKey()).equals("WISEOPEN_CNT")) {
                    continue;
                }

                HSSFCell dataCell = row.createCell(colCnt++);
                if (entry.getValue() == null) {
                    dataCell.setCellValue("");
                } else if (isNumeric((String) entry.getValue())) {
                    String value = ((String) entry.getValue()).replaceAll(",", "");
                    if ((entry.getValue() + "").indexOf(".") > -1) {
                        dataCell.setCellValue(Double.parseDouble(value));
                    } else {
                        dataCell.setCellValue(Long.parseLong(value));
                    }
                } else {
                    dataCell.setCellValue(entry.getValue() + "");
                }


                String align = "R";
                if (((String) entry.getKey()).equals("UNIT_CD") || ((String) entry.getKey()).equals("CONV_CD") || ((String) entry.getKey()).equals("WEIGHT")) {
                    align = "C";
                } else if (((String) entry.getKey()).equals("ITEM_CD1") || ((String) entry.getKey()).equals("ITEM_CD2") || ((String) entry.getKey()).equals("ITEM_NM1") || ((String) entry.getKey()).equals("ITEM_NM2")) {
                    align = "L";
                }

                if (align.equals("C")) {
                    if (isNumeric((String) entry.getValue())) {
                        if ((entry.getValue() + "").indexOf(".") > -1) {
                            dataCell.setCellStyle(styleCenter1);
                        } else {
                            dataCell.setCellStyle(styleCenter2);
                        }
                    } else {
                        dataCell.setCellStyle(styleCenter3);
                    }
                } else if (align.equals("R")) {
                    if (isNumeric((String) entry.getValue())) {
                        if ((entry.getValue() + "").indexOf(".") > -1) {
                            dataCell.setCellStyle(styleRight1);
                        } else {
                            dataCell.setCellStyle(styleRight2);
                        }
                    } else {
                        dataCell.setCellStyle(styleRight3);
                    }
                } else {
                    if (isNumeric((String) entry.getValue())) {
                        if ((entry.getValue() + "").indexOf(".") > -1) {
                            dataCell.setCellStyle(styleLeft1);
                        } else {
                            dataCell.setCellStyle(styleLeft2);
                        }
                    } else {
                        dataCell.setCellStyle(styleLeft3);
                    }
                }
            }
            rowCnt++;
        }
        int dataLenght = 0;
        int dataSize = 0;
        for (Entry<String, ?> entry : headMap.entrySet()) { //헤더정보
            worksheet.autoSizeColumn(dataLenght);
            dataSize = worksheet.getColumnWidth(dataLenght);
            worksheet.setColumnWidth(dataLenght++, dataSize + 512);
        }
        return workbook;
    }

    /**
     * 엑셀 헤더를 생성한다.
     * @param headMap
     * @param worksheet
     */
    private void headCreate(LinkedHashMap<String, ?> headMap, HSSFSheet worksheet, HSSFWorkbook workbook) {
        HSSFRow row = null;
        row = worksheet.createRow(0);
		/*int colCnt = 0;
		for(Entry<String,?> entry: headMap.entrySet()){ //헤더정보
			row.createCell(colCnt++).setCellValue(entry.getKey());
		}
		row = worksheet.createRow(1);*/
        int colCnt = 0;
        HSSFCellStyle style = workbook.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        for (Entry<String, ?> entry : headMap.entrySet()) { //헤더정보

            HSSFCell dataCell = row.createCell(colCnt++);
            dataCell.setCellStyle(style);
            dataCell.setCellValue(entry.getValue() + "");
        }
    }

    private boolean isNumeric(String s) {
        return s.replaceAll("[0-9,.]", "").equals("") ? true : false;
    }
}
