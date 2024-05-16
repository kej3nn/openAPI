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
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
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

import egovframework.admin.service.service.OpenInfCcol;
import egovframework.admin.service.service.OpenInfScol;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.exception.ServiceException;
import egovframework.common.util.UtilString;

@Component
public class Exceldownheler implements InitializingBean {

    protected static final Log logger = LogFactory.getLog(Exceldownheler.class);

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
    public Map<String, Object> download(List<LinkedHashMap<String, ?>> result, LinkedHashMap<String, ?> head, String infNm, int i, Map<String, Object> retMap, List<OpenInfScol> type) {
        // 2015.09.23 김은삼 [1] 시트명 버그 수정 BEGIN
        // return  excelParsing(result,infNm,retMap,i,head,type);
        Map<String, Object> result2 = new HashMap<String, Object>();
        String fileNm = infNm.replaceAll("[\\\\\\/\\?\\*\\[\\]]", "");

        try {
            result2 = (Map<String, Object>) excelParsing(result, fileNm, retMap, i, head, type);
        } catch (ServiceException sve) {
            EgovWebUtil.exLogging(sve);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        return result2;

        // 2015.09.23 김은삼 [1] 시트명 버그 수정 END
    }

    /**
     * 엑셀형태로 파싱을 한다.
     * @param result
     * @param fileNm
     * @return
     * @throws Exception
     */
    private Map<String, Object> excelParsing(List<LinkedHashMap<String, ?>> result, String fileNm, Map<String, Object> retMap, int i, LinkedHashMap<String, ?> head, List<OpenInfScol> type) {
        HSSFRow row = null;
        HSSFSheet worksheet = null;

        int rowCnt = (Integer) retMap.get("rowCnt");
        int sheetCnt = (Integer) retMap.get("sheetCnt");

        HSSFWorkbook workbook = (HSSFWorkbook) retMap.get("workbook");

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


        if (i == 0) {
            worksheet = workbook.createSheet(UtilString.replace(UtilString.replace(fileNm, "/", ""), ",", ""));
        } else {
            if (rowCnt % maxCnt != 0) {
                if (sheetCnt == 0) {
                    worksheet = workbook.getSheet(UtilString.replace(UtilString.replace(fileNm, "/", ""), ",", ""));
                } else {
                    worksheet = workbook.getSheet(UtilString.replace(UtilString.replace(fileNm, "/", ""), ",", "") + sheetCnt);
                }
            }
        }
        int colCnt = 0;


        if (i == 0) {
            headCreate(head, worksheet, workbook); //헤더 생성
        }
        for (LinkedHashMap<String, ?> map : result) {
            int dataTypeCnt = 0;
            colCnt = 0;

            if (rowCnt % maxCnt == 0) { //헤더 생성, 다시순번
                worksheet = workbook.createSheet(UtilString.replace(fileNm, "/", "") + (++sheetCnt));
                headCreate(head, worksheet, workbook); //헤더 생성
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
                    dataTypeCnt++;
                    continue;
                }
                String align = type.get(dataTypeCnt).getAlignTag();

                //엑셀은 100입력시 0.2정도
                worksheet.setColumnWidth(colCnt, Integer.parseInt(type.get(dataTypeCnt).getViewSize()) * 38);
                String dataType = type.get(dataTypeCnt++).getViewCd();

                HSSFCell dataCell = row.createCell(colCnt++);

                if (entry.getValue() == null) {
                    dataCell.setCellValue("");
                } else if (dataType.equals("Float") || dataType.equals("Int")) {
                    if ((entry.getValue() + "").indexOf(".") > -1) {
                        dataCell.setCellValue(Double.parseDouble(entry.getValue() + ""));
                    } else {
                        dataCell.setCellValue(Long.parseLong(entry.getValue() + ""));
                    }
                } else {
                    dataCell.setCellValue(entry.getValue() + "");
                }

                if (align.equals("C")) {
                    if (dataType.equals("Float") || dataType.equals("Int")) {
                        if ((entry.getValue() + "").indexOf(".") > -1) {
                            dataCell.setCellStyle(styleCenter1);
                        } else {
                            dataCell.setCellStyle(styleCenter2);
                        }
                    } else {
                        dataCell.setCellStyle(styleCenter3);
                    }
                } else if (align.equals("R")) {
                    if (dataType.equals("Float") || dataType.equals("Int")) {
                        if ((entry.getValue() + "").indexOf(".") > -1) {
                            dataCell.setCellStyle(styleRight1);
                        } else {
                            dataCell.setCellStyle(styleRight2);
                        }
                    } else {
                        dataCell.setCellStyle(styleRight3);
                    }
                } else {
                    if (dataType.equals("Float") || dataType.equals("Int")) {
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

        retMap.put("workbook", workbook);
        retMap.put("rowCnt", rowCnt);
        retMap.put("sheetCnt", sheetCnt);
        return retMap;
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
        HSSFCellStyle style = workbook.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        int colCnt = 0;
        for (Entry<String, ?> entry : headMap.entrySet()) { //헤더정보
            HSSFCell dataCell = row.createCell(colCnt++);
            dataCell.setCellStyle(style);
            dataCell.setCellValue(entry.getValue() + "");
        }
    }


    public void dataPrintln(String infNm, HttpServletResponse response, HttpServletRequest request, HSSFWorkbook workbook) {
        String fileNm = UtilString.replace(infNm, " ", "") + ".xls";
        // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 BEGIN
        // if(UtilString.getBrowser(requset).equals("I")){
        // 	fileNm = URLEncoder.encode(fileNm,"UTF-8").replaceAll("\\|", "%20").replaceAll("\\+", "%20");
        // }else{
        // 	fileNm = new String(fileNm.getBytes("UTF-8"),"ISO-8859-1");
        // }
        // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 END

        //*|\:"<>/? 에러남
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 BEGIN
        // response.setHeader("Content-Disposition", "attachment;filename="+"\""+UtilString.replace(fileNm,"/","")+"\"");
        try {
            response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, fileNm));
        } catch (UnsupportedEncodingException e) {
            EgovWebUtil.exLogging(e);
        }
        // 2015.09.05 김은삼 [1] 한글파일 다운로드 인코딩 변경 END
        // 2015.12 장홍식 파일 다운로드 lib 관련
        Cookie fileDownload = new Cookie("fileDownload", "true");
        fileDownload.setPath("/");
        fileDownload.setSecure(true);
        response.addCookie(fileDownload);
        // -- 2015.12 장홍식 파일 다운로드 lib 관련


        ServletOutputStream out = null;

        try {
            out = response.getOutputStream();
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
     * 차트 다운로드
     * @param result
     * @param head
     * @param infNm
     * @param i
     * @param retMap
     * @param type
     * @return
     * @throws Exception
     */
    public Map<String, Object> cDownload(List<LinkedHashMap<String, ?>> result, LinkedHashMap<String, ?> head, String infNm, int i, Map<String, Object> retMap, List<OpenInfCcol> type) {
        // 2015.09.23 김은삼 [1] 시트명 버그 수정 BEGIN
        // return  cExcelParsing(result,infNm,retMap,i,head,type);
        String fileNm = infNm.replaceAll("[\\\\\\/\\?\\*\\[\\]]", "");
        Map<String, Object> result2 = new HashMap<String, Object>();

        try {
            result2 = cExcelParsing(result, fileNm, retMap, i, head, type);
        } catch (DataAccessException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }
        // 2015.09.23 김은삼 [1] 시트명 버그 수정 END
        return result2;
    }

    /**
     * 차트 엑셀파싱
     * @param result
     * @param fileNm
     * @param retMap
     * @param i
     * @param head
     * @param type
     * @return
     * @throws Exception
     */
    private Map<String, Object> cExcelParsing(List<LinkedHashMap<String, ?>> result, String fileNm, Map<String, Object> retMap, int i, LinkedHashMap<String, ?> head, List<OpenInfCcol> type) {
        HSSFRow row = null;
        HSSFSheet worksheet = null;
        int rowCnt = (Integer) retMap.get("rowCnt");
        int sheetCnt = (Integer) retMap.get("sheetCnt");

        HSSFWorkbook workbook = (HSSFWorkbook) retMap.get("workbook");

        HSSFDataFormat format = workbook.createDataFormat();

        HSSFCellStyle styleLeft = workbook.createCellStyle();
        styleLeft.setAlignment(HSSFCellStyle.ALIGN_LEFT);

        HSSFCellStyle styleLeft1 = workbook.createCellStyle();
        styleLeft1.setDataFormat(format.getFormat("#,##0.########"));
        styleLeft1.setAlignment(HSSFCellStyle.ALIGN_LEFT);

        HSSFCellStyle styleLeft2 = workbook.createCellStyle();
        styleLeft2.setDataFormat(format.getFormat("#,###"));
        styleLeft2.setAlignment(HSSFCellStyle.ALIGN_LEFT);


        if (i == 0) {
            worksheet = workbook.createSheet(UtilString.replace(UtilString.replace(fileNm, "/", ""), ",", ""));
        } else {
            if (rowCnt % maxCnt != 0) {
                if (sheetCnt == 0) {
                    worksheet = workbook.getSheet(UtilString.replace(UtilString.replace(fileNm, "/", ""), ",", ""));
                } else {
                    worksheet = workbook.getSheet(UtilString.replace(UtilString.replace(fileNm, "/", ""), ",", "") + sheetCnt);
                }
            }
        }
        int colCnt = 0;


        if (i == 0) {
            headCreate(head, worksheet, workbook); //헤더 생성
        }
        for (LinkedHashMap<String, ?> map : result) {
            colCnt = 0;

            if (rowCnt % maxCnt == 0) { //헤더 생성, 다시순번
                worksheet = workbook.createSheet(UtilString.replace(fileNm, "/", "") + (++sheetCnt));
                headCreate(head, worksheet, workbook); //헤더 생성
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
                } else {
                    if (((String) entry.getKey()).equals("OJ_YY") || ((String) entry.getKey()).equals("FSCL_YY")) {
                        dataCell.setCellValue(entry.getValue() + "");
                    } else {
                        if ((entry.getValue()) instanceof String) {
                            dataCell.setCellValue(entry.getValue() + "");
                        } else {
                            if ((entry.getValue() + "").indexOf(".") > -1) {
                                dataCell.setCellValue(Double.parseDouble(entry.getValue() + ""));
                            } else {
                                dataCell.setCellValue(Long.parseLong(entry.getValue() + ""));
                            }
                        }
                    }
                }

                if ((entry.getValue()) instanceof String) {
                    dataCell.setCellStyle(styleLeft);
                } else {
                    if ((entry.getValue() + "").indexOf(".") > -1) {
                        dataCell.setCellStyle(styleLeft1);
                    } else {
                        dataCell.setCellStyle(styleLeft2);
                    }
                }
            }
            rowCnt++;
        }

        retMap.put("workbook", workbook);
        retMap.put("rowCnt", rowCnt);
        retMap.put("sheetCnt", sheetCnt);
        return retMap;
    }
}
