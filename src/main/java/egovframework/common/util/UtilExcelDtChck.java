package egovframework.common.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.springframework.dao.DataAccessException;

import egovframework.com.cmm.EgovWebUtil;

public class UtilExcelDtChck {

    /**
     * 엑셀의 Cell 값 가져오기
     *
     * @param cell
     * @return String
     */
    public static String getHSSFCellValue(HSSFCell cell) {

        String cellValue = "";
        Short shortDataFormat = 0;
        String strDataFormat = "";

        DecimalFormat df = new DecimalFormat("#.#################");

        switch (cell.getCellType()) {
            case 0: // CELL_TYPE_NUMERIC
                if (DateUtil.isCellDateFormatted(cell)) {
                    Date date = cell.getDateCellValue();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    cellValue = sdf.format(date);
                } else {
                    cellValue = "" + cell.getNumericCellValue();
                    HSSFCellStyle style = cell.getCellStyle();
                    shortDataFormat = style.getDataFormat();
                    if (shortDataFormat == 0 || shortDataFormat == 49) { // 0 :
                        // General(일반타입),
                        // 49 :
                        // 텍스트타입
                        cellValue = "" + (int) cell.getNumericCellValue(); // 정수로
                        // 가져온다
                    } else {
                        // 정수형 데이터는 소수점 표기 안하기 위해 FormatString 가져온다.
                        // 셀서식이 숫자이고 소수자릿수가 0인경우 : #,##0_ ;[Red]\-#,##0\
                        // 셀서식이 숫자이고 소수자릿수가 1인경우 : #,##0.0_ ;[Red]\-#,##0.0\
                        strDataFormat = style.getDataFormatString();
                        // 숫자형식일경우 소수점표기 0인경우 .0 붙이지 않고 정수로 표현
                        if (strDataFormat.substring(0, strDataFormat.indexOf("_")).indexOf(".") > -1) { // 소수점이 없으면 -1
                            cellValue = "" + cell.getNumericCellValue(); // 전체 가져온다
                        } else {
                            if (cell.getNumericCellValue() > 2147483647) {
                                cellValue = "" + (double) cell.getNumericCellValue(); // 정수로 가져온다
                            } else {
                                cellValue = "" + (int) cell.getNumericCellValue(); // 정수로 가져온다
                            }
                        }
                    }

                    if (cellValue.indexOf("E") > -1) { // Double
                        cellValue = df.format(Double.parseDouble(cellValue));
                    } else if (cellValue.indexOf(".") > -1) {
                        int n = cellValue.length() - cellValue.indexOf(".") - 1;
                        if (n > 5) { // double
                            cellValue = df.format(Double.parseDouble(cellValue));
                        } else { // float
                            float floatValue = (float) cell.getNumericCellValue();
                            cellValue = "" + floatValue;
                        }
                    } else if (Double.parseDouble(cellValue) > 2147483647) {
                        cellValue = df.format(Double.parseDouble(cellValue));
                    } else { // Int
                        int intValue = (int) cell.getNumericCellValue();
                        cellValue = "" + intValue;
                    }

                }
                break;
            case 2: // CELL_TYPE_FORMULA
                cellValue = cell.getCellFormula();
                break;
            case 1: // CELL_TYPE_STRING
            case 3: // CELL_TYPE_BLANK
                cellValue = "";
                try {
                    cellValue = cell.getStringCellValue();
                } catch (IllegalStateException e) {
                    try {
                        cell.setCellType(1);
                        cellValue = cell.getStringCellValue();
                        if (cellValue.length() > 4 && cellValue.indexOf("E") > -1
                                && ((cellValue + " ").substring(1, 2).equals("."))
                                && (cellValue.substring(cellValue.length() - 4, cellValue.length()).indexOf("E") > -1)) {
                            cellValue = df.format(Double.parseDouble(cellValue));
                        }
                    } catch (DataAccessException e2) {
                        cellValue = "";
                        EgovWebUtil.exLogging(e2);
                    } catch (Exception e2) {
                        cellValue = "";
                        EgovWebUtil.exLogging(e2);
                    }
                }
                break;
            case 5: // CELL_TYPE_ERROR
                cellValue = "";
                break;
            case 4:
                cellValue = Boolean.toString(cell.getBooleanCellValue());
                break;
            default:
                cellValue = "";
                break;
        }

        return cellValue;
    }

    /**
     * 엑셀의 Cell 값 가져오기 (수정함)
     *
     * @param cell
     * @return String
     */
    public static String getCellValue(Cell cell) {

        String cellValue = "";
        Short shortDataFormat = 0;
        String strDataFormat = "";

        DecimalFormat df = new DecimalFormat("#.#################");
        // );
        switch (cell.getCellType()) {
            case 0: // CELL_TYPE_NUMERIC
                // ----------------------------------------------------------------------------------------------
                if (DateUtil.isCellDateFormatted(cell)) { // 날짜 타입 (년월일만 적용됨, 시간은 반영
                    // 안됨)
                    Date date = cell.getDateCellValue();
                    // 년도와 시간을 읽어서 포맷 설정
                    SimpleDateFormat yyyySdf = new SimpleDateFormat("yyyy");
                    int yyyy = Integer.parseInt(yyyySdf.format(date));
                    SimpleDateFormat hhSdf = new SimpleDateFormat("HHmm");
                    int hh = Integer.parseInt(hhSdf.format(date));

                    if (yyyy < 1900) { // 시간 일 때 처리 ( 1900년 이하면 시간만 표시
                        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
                        cellValue = sdf.format(date);
                    } else { // 날짜로 표시
                        if (hh > 0) { // 시간도 표시
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm ");
                            cellValue = sdf.format(date);
                        } else { // 날짜만 표시
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            cellValue = sdf.format(date);
                        }
                    }
                } else { // 날짜 타입이 아닌 숫자. 처리
                    // cellValue = "" + cell.getNumericCellValue();
                    CellStyle style = cell.getCellStyle();
                    shortDataFormat = style.getDataFormat();
                    strDataFormat = style.getDataFormatString();
                    // cell.setCellType(Cell.CELL_TYPE_STRING); // 문자 타잎으로 변환
                    cellValue = String.valueOf(new Double(cell.getNumericCellValue())); // 숫자 그대로 읽음 (0이 따라옴.)

                    // 숫자 형식 보정
                    if (cellValue.indexOf("E") > -1 || Double.parseDouble(cellValue) > 2147483647) { // Double
                        cellValue = df.format(Double.parseDouble(cellValue));
                    } else if (cellValue.indexOf(".") > -1) { // 실수
                        // 소수점 아래를 잘라서 0이 아니면 실수로 다시 가져옴
                        if (Integer.parseInt(cellValue.substring(cellValue.indexOf(".") + 1)) != 0) {
                            cellValue = String.valueOf(new Double(cell.getNumericCellValue())); // 그냥 그대로 가져온다. (실수로 처리 하면 소수점이 조정됨)
                        } else { // 아니면 정수
                            cellValue = String.valueOf(new Double(cell.getNumericCellValue()).intValue()); // 정수로 가져온다
                        }
                    } else { // Int
                        cellValue = String.valueOf(new Double(cell.getNumericCellValue()).intValue()); // 정수로 가져온다
                    }
                }
                // ----------------------------------------------------------------------------------------------
                break;
            case 2: // CELL_TYPE_FORMULA
                cellValue = cell.getCellFormula();
                break;
            case 1: // CELL_TYPE_STRING
            case 3: // CELL_TYPE_BLANK
                cellValue = "";
                try {
                    cellValue = cell.getStringCellValue();
                } catch (IllegalStateException e) {
                    try {
                        cell.setCellType(1);
                        cellValue = cell.getStringCellValue();
                        if (cellValue.length() > 4 && cellValue.indexOf("E") > -1
                                && ((cellValue + " ").substring(1, 2).equals("."))
                                && (cellValue.substring(cellValue.length() - 4, cellValue.length()).indexOf("E") > -1)) {
                            cellValue = df.format(Double.parseDouble(cellValue));
                        }
                    } catch (DataAccessException e2) {
                        cellValue = "";
                        EgovWebUtil.exLogging(e);
                    } catch (Exception e2) {
                        cellValue = "";
                        EgovWebUtil.exLogging(e);
                    }
                }
                break;
            case 5: // CELL_TYPE_ERROR
                cellValue = "";
                break;
            case 4:
                cellValue = Boolean.toString(cell.getBooleanCellValue());
                break;
            default:
                cellValue = "";
                break;
        }

        return cellValue;
    }
}
