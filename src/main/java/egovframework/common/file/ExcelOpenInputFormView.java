package egovframework.common.file;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Params;
import egovframework.common.helper.Encodehelper;

/**
 * 공공데이터 입력의 엑셀 양식 다운로드
 *
 * @version 1.0
 * @author 김정호
 * @since 2017/10/18
 */
public class ExcelOpenInputFormView extends AbstractExcelView {

    /**
     * 기본 확장자
     */
    private static final String DEF_EXT_XLS = ".xls";
    /**
     * 기본 폰트
     */
    private static final String DEF_EXCEL_FONT = "Malgun Gothic";
    /**
     * 단위 row 카운트
     */
    private static final int HDN_COL_CODE_ROW = 0;

    public ExcelOpenInputFormView() {
    }

    /**
     * 통계표 양식을 다운로드 한다.
     */
    @Override
    protected void buildExcelDocument(Map<String, Object> model,
                                      HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) {

        Map<String, Object> map = (Map<String, Object>) model.get("map");

        Params params = (Params) map.get("params");    //파라미터
        LinkedList<LinkedList<String>> list = (LinkedList<LinkedList<String>>) map.get("list");
        ArrayList<ArrayList<String>> data = (ArrayList<ArrayList<String>>) map.get("data");    //내용 데이터

        //String ldlistSeq = String.valueOf(params.getString("ldlistSeq"));	//입력스케쥴 고유번호
        String dsId = params.getString("dsId");        //통계표 ID
        String dsNm = params.getString("dsNm");        //통계표 명

        //시트 생성
        HSSFSheet sheet = workbook.createSheet(dsId);
        sheet.setDefaultColumnWidth(15);
        sheet.setDefaultRowHeightInPoints(30);

        HSSFCellStyle headerStyle = setInputFormHeaderStyle(workbook);    //헤더 스타일

        HSSFRow row = null;

        for (int i = 0; i < list.size(); i++) {
            row = sheet.createRow(i);
            LinkedList<String> dataRow = list.get(i);
            for (int j = 0; j < dataRow.size(); j++) {
                String val = String.valueOf(dataRow.get(j));
                row.createCell(j).setCellValue(new HSSFRichTextString(val));
                row.getCell(j).setCellStyle(headerStyle);
            }

            if (i == HDN_COL_CODE_ROW) {
                row.setZeroHeight(true);    //행 숨김
            } else {
                //setZeroHeight 설정하면 sheet.setDefaultRowHeightInPoints 값 사라짐. 재 지정해준다.
                row.setHeightInPoints(30);
            }
        }

        response.setCharacterEncoding("UTF-8");
        try {
//			response.setHeader("Content-Disposition", Encodehelper.getDisposition((dsNm + DEF_EXT_XLS), Encodehelper.getBrowser(request)));
            response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, (dsNm + DEF_EXT_XLS)));

        } catch (UnsupportedEncodingException e) {
            EgovWebUtil.exLogging(e);
        } catch (IOException e) {
            EgovWebUtil.exLogging(e);
        }
    }

    /**
     * 통계표 입력 헤더 스타일을 지정한다.
     *
     * @param workbook 시트
     * @return
     */
    public HSSFCellStyle setInputFormHeaderStyle(HSSFWorkbook workbook) {
        HSSFCellStyle style = (HSSFCellStyle) workbook.createCellStyle();
        //폰트
        Font font = workbook.createFont();
        font.setFontName(DEF_EXCEL_FONT);
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        //정렬
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        //배경색
        style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setFont(font);
        //테두리 설정
        style.setBorderTop(CellStyle.BORDER_MEDIUM);
        style.setBorderRight(CellStyle.BORDER_MEDIUM);
        style.setBorderBottom(CellStyle.BORDER_MEDIUM);
        style.setBorderLeft(CellStyle.BORDER_MEDIUM);

        style.setLocked(true);

        return style;
    }

    /**
     * 통계표 입력 데이터 스타일을 지정한다.
     *
     * @param workbook
     * @return
     */
    public HSSFCellStyle setInputFormDataStyle(HSSFWorkbook workbook) {
        HSSFCellStyle style = (HSSFCellStyle) workbook.createCellStyle();
        //폰트
        Font font = workbook.createFont();
        font.setFontName(DEF_EXCEL_FONT);
        font.setBoldweight(Font.BOLDWEIGHT_NORMAL);
        //정렬
        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        //배경색
        style.setFillPattern(CellStyle.NO_FILL);
        style.setFont(font);
        //테두리 설정
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);

        return style;
    }

}
