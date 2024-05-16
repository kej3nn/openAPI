/*
 * @(#)PoiExcelView.java 1.0 2015/06/01
 *
 * COPYRIGHT (C) 2013 WISEITECH CO., LTD. ALL RIGHTS RESERVED.
 */
package egovframework.common.base.view;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.constants.ModelAttribute;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Encodehelper;

/**
 * POI 엑셀 뷰 클래스이다.
 *
 * @author 김은삼
 * @version 1.0 2015/06/01
 */
public class PoiExcelView extends BaseView {
    /**
     * 파일
     */
    public static final String FILE = "file";

    /**
     * 컬럼
     */
    public static final String COLUMNS = "columns";

    /**
     * 데이터
     */
    public static final String DATA = "data";

    /**
     * 데이터 구조
     */
    public static final String DATA_STRUCT = "dataStruct";

    /**
     * 로우 기반 데이터 구조
     */
    public static final int DATA_STRUCT_ROW_BASE = 1;

    /**
     * 셀 기반 데이터 구조
     */
    public static final int DATA_STRUCT_CELL_BASE = 2;

    /**
     * 파일 이름
     */
    public static final String FILE_NAME = "fileName";

    /**
     * 시트 이름
     */
    public static final String SHEET_NAME = "sheetName";

    /**
     * 컬럼 이름
     */
    public static final String COLUMN_NAME = "columnName";

    /**
     * 헤더 이름
     */
    public static final String HEADER_NAME = "headerName";

    /**
     * 데이터 형식
     */
    public static final String DATA_TYPE = "dataType";

    /**
     * 데이터 정렬
     */
    public static final String DATA_ALIGN = "dataAlign";

    /**
     * 데이터 형식
     */
    public static final String DATA_FORMAT = "dataFormat";

    /**
     * 로우 인덱스
     */
    public static final String ROW_INDEX = "rowIndex";

    /**
     * 컬럼 인덱스
     */
    public static final String COLUMN_INDEX = "columnIndex";

    /**
     * 데이터 값
     */
    public static final String DATA_VALUE = "dataValue";

    /**
     * 유효성 여부
     */
    public static final String IS_VALID = "isValid";

    /**
     * 정수 데이터 형식
     */
    public static final String DATA_TYPE_INTEGER = "INTEGER";

    /**
     * 실수 데이터 형식
     */
    public static final String DATA_TYPE_DECIMAL = "DECIMAL";

    /**
     * 고정 문자열 데이터 형식
     */
    public static final String DATA_TYPE_CHAR = "CHAR";

    /**
     * 가변 문자열 데이터 형식
     */
    public static final String DATA_TYPE_VARCHAR = "VARCHAR";

    /**
     * 데이터 좌측 정렬
     */
    public static final String DATA_ALIGN_LEFT = "LEFT";

    /**
     * 데이터 우측 정렬
     */
    public static final String DATA_ALIGN_RIGHT = "RIGHT";

    /**
     * 데이터 중앙 정렬
     */
    public static final String DATA_ALIGN_CNETER = "CENTER";

    /**
     * 데이터 형식 매핑
     */
    public static final Map<String, Integer> dataType = new HashMap<String, Integer>();

    /**
     * 데이터 정렬 매핑
     */
    public static final Map<String, Short> dataAlign = new HashMap<String, Short>();

    /*
     * 클래스 변수를 초기화한다.
     */
    static {
        // 데이터 형식을 초기화한다.
        dataType.put(DATA_TYPE_INTEGER, Cell.CELL_TYPE_NUMERIC);
        dataType.put(DATA_TYPE_DECIMAL, Cell.CELL_TYPE_NUMERIC);
        dataType.put(DATA_TYPE_CHAR, Cell.CELL_TYPE_STRING);
        dataType.put(DATA_TYPE_VARCHAR, Cell.CELL_TYPE_STRING);

        // 데이터 정렬을 초기화한다.
        dataAlign.put(DATA_ALIGN_LEFT, CellStyle.ALIGN_LEFT);
        dataAlign.put(DATA_ALIGN_RIGHT, CellStyle.ALIGN_RIGHT);
        dataAlign.put(DATA_ALIGN_CNETER, CellStyle.ALIGN_CENTER);
    }

    /**
     * 디폴트 생성자이다.
     */
    public PoiExcelView() {
        super();
    }

    /**
     * 파일 이름을 반환한다.
     *
     * @param request HTTP 요청
     * @param model   모델
     * @return 파일 이름
     */
    @SuppressWarnings("unchecked")
    protected String getFileName(HttpServletRequest request, Map<String, Object> model) {
        Map<String, Object> data = (Map<String, Object>) model.get(ModelAttribute.DATA);

        Record file = (Record) data.get(FILE);

        String name = file.getString(FILE_NAME);

        // try {
        //     if (UtilString.getBrowser(request).equals("I")) {
        //         name = URLEncoder.encode(name, "UTF-8").replaceAll("\\+", "%20");
        //     }
        //     else {
        //         name = new String(name.getBytes("UTF-8"), "ISO-8859-1");
        //     }
        //     
        //     return name;
        // }
        // catch (UnsupportedEncodingException uee) {
        //     warn("Detected exception: ", uee);
        //     
        //     return name;
        // }
        return name;
    }

    /**
     * 시트 이름을 반환한다.
     *
     * @param model 모델
     * @return 시트 이름
     */
    @SuppressWarnings("unchecked")
    protected String getSheetName(Map<String, Object> model) {
        Map<String, Object> data = (Map<String, Object>) model.get(ModelAttribute.DATA);

        Record file = (Record) data.get(FILE);

        return file.getString(SHEET_NAME);
    }

    /**
     * 컬럼을 반환한다.
     *
     * @param model 모델
     * @return 컬럼
     */

    @SuppressWarnings("unchecked")
    protected List<Record> getColumns(Map<String, Object> model) {
        Map<Object, Object> data = (Map<Object, Object>) model.get(ModelAttribute.DATA);

        return (List<Record>) data.get(COLUMNS);
    }

    /**
     * 헤더를 반환한다.
     *
     * @param model 모델
     * @return 헤더
     */
    @SuppressWarnings("unchecked")
    protected List<Record> getHeaders(Map<String, Object> model) {
        Map<Object, Object> data = (Map<Object, Object>) model.get(ModelAttribute.DATA);

        return (List<Record>) data.get(COLUMNS);
    }

    /**
     * 데이터를 반환한다.
     *
     * @param model 모델
     * @return 데이터
     */
    @SuppressWarnings("unchecked")
    protected List<Record> getData(Map<String, Object> model) {
        Map<Object, Object> data = (Map<Object, Object>) model.get(ModelAttribute.DATA);

        return (List<Record>) data.get(DATA);
    }

    /**
     * 데이터 구조를 반환한다.
     *
     * @param model 모델
     * @return 데이터 구조
     */
    @SuppressWarnings("unchecked")
    protected int getDataStruct(Map<String, Object> model) {
        Map<Object, Object> data = (Map<Object, Object>) model.get(ModelAttribute.DATA);

        Object struct = data.get(DATA_STRUCT);

        if (struct instanceof Integer) {
            return (Integer) struct;
        } else {
            return DATA_STRUCT_ROW_BASE;
        }
    }

    /**
     * 워크북을 생성한다.
     *
     * @return 워크북
     */
    @SuppressWarnings("unchecked")
    protected Workbook createWorkbook(Map<String, Object> model) {
        Map<Object, Object> data = (Map<Object, Object>) model.get(ModelAttribute.DATA);

        Record file = (Record) data.get(FILE);

        String name = file.getString(FILE_NAME);

        if (name.endsWith(".xls")) {
            return new HSSFWorkbook();
        } else {
            return new XSSFWorkbook();
        }
    }

    /**
     * 시트를 생성한다.
     *
     * @param workbook 워크북
     * @return 시트
     */
    protected Sheet createSheet(Workbook workbook) {
        return workbook.createSheet();
    }

    /**
     * 시트를 생성한다.
     *
     * @param workbook 워크북
     * @param name     이름
     * @return 시트
     */
    protected Sheet createSheet(Workbook workbook, String name) {
        return workbook.createSheet(name);
    }

    /**
     * 데이터 포맷을 생성한다.
     *
     * @param workbook 워크북
     * @return 데이터 포맷
     */
    protected DataFormat createDataFormat(Workbook workbook) {
        return workbook.createDataFormat();
    }

    /**
     * 셀 스타일을 생성한다.
     *
     * @param workbook 워크북
     * @return 셀 스타일
     */
    protected CellStyle createCellStyle(Workbook workbook) {
        return workbook.createCellStyle();
    }

    /**
     * 폰트를 생성한다.
     *
     * @param workbook 워크북
     * @param weight   볼드
     * @return 폰트
     */
    protected Font createFont(Workbook workbook, short weight) {
        Font font = workbook.createFont();

        font.setBoldweight(weight);
        font.setFontName("돋움체");
        font.setFontHeightInPoints((short) 10);

        return font;
    }

    /**
     * 로우를 생성한다.
     *
     * @param sheet 시트
     * @param index 인덱스
     * @return 로우
     */
    protected Row createRow(Sheet sheet, int index) {
        return sheet.createRow(index);
    }

    /**
     * 셀을 생성한다.
     *
     * @param row   로우
     * @param index 인덱스
     * @return 셀
     */
    protected Cell createCell(Row row, int index) {
        return row.createCell(index);
    }

    /**
     * 컬럼을 설정한다.
     *
     * @param workbook 워크북
     * @param sheet    시트
     * @param column   컬럼
     */
    protected void setColumn(Workbook workbook, Sheet sheet, List<Record> column) {
        for (int c = 0; c < column.size(); c++) {
            setColumn(workbook, sheet, c, column.get(c));
        }
    }

    /**
     * 컬럼을 설정한다.
     *
     * @param workbook 워크북
     * @param sheet    시트
     * @param index    인덱스
     * @param column   컬럼
     */
    protected void setColumn(Workbook workbook, Sheet sheet, int index, Record column) {
        String align = column.getString(DATA_ALIGN, DATA_ALIGN_LEFT).toUpperCase();
        String format = column.getString(DATA_FORMAT);

        CellStyle style = createCellStyle(workbook);

        style.setAlignment(dataAlign.get(align));
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setBorderTop(CellStyle.BORDER_THIN);

        if (!"".equals(format)) {
            style.setDataFormat(createDataFormat(workbook).getFormat(format));
        }

        style.setFont(createFont(workbook, Font.BOLDWEIGHT_NORMAL));
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

        sheet.setDefaultColumnStyle(index, style);
    }

    /**
     * 헤더를 추가한다.
     *
     * @param workbook 워크북
     * @param sheet    시트
     * @param header   헤더
     */
    protected void addHeader(Workbook workbook, Sheet sheet, List<Record> header) {
        Row row = createRow(sheet, 0);

        for (int c = 0; c < header.size(); c++) {
            addHeader(workbook, sheet, row, c, header.get(c));
        }
    }

    /**
     * 헤더를 추가한다.
     *
     * @param workbook 워크북
     * @param sheet    시트
     * @param row      로우
     * @param index    인덱스
     * @param header   헤더
     */
    protected void addHeader(Workbook workbook, Sheet sheet, Row row, int index, Record header) {
        String name = header.getString(HEADER_NAME);

        CellStyle style = createCellStyle(workbook);

        style.setAlignment(CellStyle.ALIGN_CENTER);
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        style.setFont(createFont(workbook, Font.BOLDWEIGHT_BOLD));
        style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

        Cell cell = createCell(row, index);

        cell.setCellStyle(style);
        cell.setCellValue(workbook.getCreationHelper().createRichTextString(name));

        sheet.setColumnWidth(index, (name.length() + 2) * 256 * 2);
    }

    /**
     * 데이터를 추가한다.
     *
     * @param workbook 워크북
     * @param sheet    시트
     * @param column   컬럼
     * @param data     데이터
     * @param struct   데이터 구조
     */
    protected void addData(Workbook workbook, Sheet sheet, List<Record> column, List<Record> data, int struct) {
        List<CellStyle> valid = new ArrayList<CellStyle>();
        List<CellStyle> error = new ArrayList<CellStyle>();

        CellStyle style = null;

        for (int i = 0; i < column.size(); i++) {
            String align = column.get(i).getString(DATA_ALIGN, DATA_ALIGN_LEFT).toUpperCase();
            String format = column.get(i).getString(DATA_FORMAT);

            style = workbook.createCellStyle();

            style.setAlignment(dataAlign.get(align));
            style.setBorderBottom(CellStyle.BORDER_THIN);
            style.setBorderLeft(CellStyle.BORDER_THIN);
            style.setBorderRight(CellStyle.BORDER_THIN);
            style.setBorderTop(CellStyle.BORDER_THIN);

            if (!"".equals(format)) {
                style.setDataFormat(createDataFormat(workbook).getFormat(format));
            }

            style.setFont(createFont(workbook, Font.BOLDWEIGHT_NORMAL));
            style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

            valid.add(style);

            style = workbook.createCellStyle();

            style.setAlignment(dataAlign.get(align));
            style.setBorderBottom(CellStyle.BORDER_THIN);
            style.setBorderLeft(CellStyle.BORDER_THIN);
            style.setBorderRight(CellStyle.BORDER_THIN);
            style.setBorderTop(CellStyle.BORDER_THIN);
            style.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
            style.setFillPattern(CellStyle.SOLID_FOREGROUND);

            if (!"".equals(format)) {
                style.setDataFormat(createDataFormat(workbook).getFormat(format));
            }

            style.setFont(createFont(workbook, Font.BOLDWEIGHT_NORMAL));
            style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);

            error.add(style);
        }

        Row row = null;

        for (int r = 0, i = 0; r < data.size(); r++) {
            if (struct == DATA_STRUCT_CELL_BASE) {
                int c = data.get(r).getInt(COLUMN_INDEX);

                if (c == 0) {
                    row = createRow(sheet, i + 1);
                    i++;
                }

                if (data.get(r).getBoolean(IS_VALID, true)) {
                    if (valid != null)
                        addData(workbook, sheet, row, c, column.get(c), valid.get(c), data.get(r), struct);
                } else {
                    addData(workbook, sheet, row, c, column.get(c), error.get(c), data.get(r), struct);
                }
            } else {
                row = createRow(sheet, r + 1);

                for (int c = 0; c < column.size(); c++) {
                    if (valid != null)
                        addData(workbook, sheet, row, c, column.get(c), valid.get(c), data.get(r), struct);
                }
            }
        }
    }

    /**
     * 데이터를 추가한다.
     *
     * @param workbook 워크북
     * @param sheet    시트
     * @param row      로우
     * @param index    인덱스
     * @param column   컬럼
     * @param style    스타일
     * @param data     데이터
     * @param struct   데이터 구조
     */
    protected void addData(Workbook workbook, Sheet sheet, Row row, int index, Record column, CellStyle style, Record data, int struct) {
        String type = column.getString(DATA_TYPE, DATA_TYPE_VARCHAR);

        if (StringUtils.isNotBlank(type)) {
            type = type.toUpperCase();
        }

        Object value = null;

        if (struct == DATA_STRUCT_CELL_BASE) {
            value = data.get(DATA_VALUE);
        } else {
            value = data.get(column.getString(COLUMN_NAME));
        }

        if (value != null) {
            switch (dataType.get(type)) {
                case Cell.CELL_TYPE_NUMERIC:
                    try {
                        value = Double.valueOf(value.toString());
                    } catch (NumberFormatException nfe) {
                        EgovWebUtil.exLogging(nfe);
                    }
                    break;
            }
        }

        Cell cell = createCell(row, index);

        cell.setCellStyle(style);

        if (value instanceof Boolean) {
            cell.setCellValue(((Boolean) value).booleanValue());
        } else if (value instanceof Calendar) {
            cell.setCellValue((Calendar) value);
        } else if (value instanceof Date) {
            cell.setCellValue((Date) value);
        } else if (value instanceof Number) {
            cell.setCellValue(((Number) value).doubleValue());
        } else if (value instanceof String) {
            cell.setCellValue(workbook.getCreationHelper().createRichTextString((String) value));
        } else {
            if (value != null) {
                cell.setCellValue(workbook.getCreationHelper().createRichTextString(value.toString()));
            } else {
                cell.setCellValue("");
            }
        }
    }

    /**
     * 오류 메시지를 처리한다.
     *
     * @param response HTTP 응답
     * @param message  메시지
     */
    protected void handleErrorMessage(HttpServletResponse response, String message) {
        try {
            // setContentType("text/html; charset=UTF-8");

            response.reset();

            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);
            // response.setContentType(getContentType());
            response.setContentType("text/html; charset=UTF-8");

            PrintWriter writer = response.getWriter();

            writer.println("<script type=\"text/javascript\">");
            writer.println("(function() {");
            writer.println("    alert(\"" + message + "\");");
            writer.println("})();");
            writer.println("</script>");
        } catch (IOException ioe) {
            warn("Detected exception: ", ioe);
        }
    }

    /*
     * (non-Javadoc)
     * @see org.springframework.web.servlet.view.AbstractView#renderMergedOutputModel(java.util.Map, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) {
        try {
            // 워크북을 생성한다.
            Workbook workbook = createWorkbook(model);

            // 시트를 생성한다.
            Sheet sheet = createSheet(workbook, getSheetName(model));

            // 컬럼을 설정한다.
            setColumn(workbook, sheet, getColumns(model));

            // 헤더를 추가한다.
            addHeader(workbook, sheet, getHeaders(model));

            // 데이터를 추가한다.
            addData(workbook, sheet, getColumns(model), getData(model), getDataStruct(model));

            // setContentType("application/octet-stream; charset=UTF-8");

            // response.setContentType(getContentType());
            response.setContentType("application/octet-stream; charset=UTF-8");
            response.setHeader("Content-Transfer-Encoding", "binary");
            // response.setHeader("Content-Disposition", "attachment; filename=\"" + getFileName(request, model) + "\";");
            response.setHeader("Content-Disposition", Encodehelper.getDisposition(getFileName(request, model), Encodehelper.getBrowser(request)));

            OutputStream os = response.getOutputStream();

            workbook.write(os);

        } catch (IOException ioe) {
            error("Detected exception: ", ioe);
            handleErrorMessage(response, getMessage("portal.error.000002"));
        } catch (Exception e) {
            error("Detected exception: ", e);
            handleErrorMessage(response, getMessage("portal.error.000002"));
        }
    }
}