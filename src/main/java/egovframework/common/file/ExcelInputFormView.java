package egovframework.common.file;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
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

import egovframework.admin.stat.service.StatInputService;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Messages;
import egovframework.common.base.model.Params;
import egovframework.common.base.service.BaseService;
import egovframework.common.helper.Encodehelper;

/**
 * 통계표 입력의 엑셀 양식 다운로드 및 등록(BEAN 등록)
 *
 * @version 1.0
 * @author 김정호
 * @since 2015/06/15
 */
public class ExcelInputFormView extends AbstractExcelView {

    @Resource(name = "egovMessageSource")
    protected EgovMessageSource egovMessageSource;

    /**
     * 기본 확장자
     */
    private static final String DEF_EXT_XLS = ".xls";
    /**
     * 기본 폰트
     */
    private static final String DEF_EXCEL_FONT = "Malgun Gothic";
    /**
     * 엑셀 숨김컬럼 - 자료시점 코드
     */
    private static final String HDN_COL_CD_WRTTIME_IDTFR_CD = "wrttimeIdtfrId";
    /**
     * 엑셀 숨김컬럼 - 비교자료 구분코드
     */
    private static final String HDN_COL_CD_DTADVS_CD = "dtadvsCd";
    /**
     * 엑셀 숨김컬럼 - 분류 데이터번호
     */
    private static final String HDN_COL_CD_CLS_DATANO = "clsDatano";
    /**
     * 엑셀 숨김컬럼 - 그룹 데이터번호
     */
    private static final String HDN_COL_CD_GRP_DATANO = "grpDatano";
    /**
     * 엑셀 컬럼 - 순번
     */
    private static final String HDN_COL_CD_NO = "No";
    /**
     * 엑셀 항목 데이터 번호 row no
     */
    private static final int HDN_ROW_NO_ITM_DATANO = 0;
    /**
     * 엑셀 자료시점 구분코드 번호 column no
     */
    private static final int HDN_COL_NO_WRTTIME_IDTFR_CD = 0;
    /**
     * 엑셀 비교자료 구분코드 번호 column no
     */
    private static final int HDN_COL_NO_DVADVS_CD = 1;
    /**
     * 엑셀 분류 데이터 번호 column no
     */
    private static final int HDN_COL_NO_CLS_DATANO = 2;
    /**
     * 엑셀 그룹 데이터 번호 column no
     */
    private static final int HDN_COL_NO_GRP_DATANO = 3;
    /**
     * 단위 row 카운트
     */
    private static final int UI_ROW_CNT = 1;

    public ExcelInputFormView() {
    }

    /**
     * 통계표 양식을 다운로드 한다.
     */
    @Override
    protected void buildExcelDocument(Map<String, Object> model,
                                      HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) {

        Map<String, Object> map = (Map<String, Object>) model.get("map");

        Params params = (Params) map.get("params");    //파라미터
        Map<String, Object> head = (Map<String, Object>) map.get("head");    //헤더data
        ArrayList<ArrayList<String>> data = (ArrayList<ArrayList<String>>) map.get("data");    //내용 데이터

        String sStatblId = params.getString("statblId");    //통계표 id
        String sFileNm = params.getString("statblNm");        //통계표 명

        Map<String, Object> dataOptions = new HashMap<String, Object>();    //머지 옵션 map

        //헤더 data를 arrayList 형태로 가공한다.
        ArrayList<ArrayList<String>> arrHead = getExcelFormHeader(head);

        //시트 생성
        HSSFSheet sheet = workbook.createSheet(sStatblId);
        sheet.setDefaultColumnWidth(13);
        sheet.setDefaultRowHeightInPoints(20);

        HSSFCellStyle headerStyle = setInputFormHeaderStyle(workbook);    //헤더 스타일
        HSSFCellStyle dataStyle = setInputFormDataStyle(workbook);        //데이터 스타일

        HSSFRow row = null;
        //헤더 셀 입력
        for (int i = 0; i < arrHead.size(); i++) {
            ArrayList<String> arrCol = arrHead.get(i);
            row = sheet.createRow(i);

            for (int j = 0; j < arrCol.size(); j++) {
                String sVal = String.valueOf(arrCol.get(j));
                row.createCell(j).setCellValue(new HSSFRichTextString(sVal));
                row.getCell(j).setCellStyle(headerStyle);
            }

            if (i == HDN_ROW_NO_ITM_DATANO) {    //항목 데이터번호 행 숨김
                row.setZeroHeight(true);
            } else {
                //setZeroHeight 설정하면 sheet.setDefaultRowHeightInPoints 값 사라짐. 재 지정해준다.
                row.setHeightInPoints(20);
            }

        }

        //셀 을 머지한다.
        dataOptions.put("IS_HEADER", true);
        mergeInputCell(arrHead, sheet, null);

        int headRow = arrHead.size();            //헤더 row size
        int headCol = arrHead.get(0).size();    //헤더 column 갯수
        int dataRow = data.size();                //데이터 row 갯수
        int dataCol = data.get(0).size();        //데이터 column 갯수

        //데이터 셀 입력
        for (int i = 0; i < dataRow; i++) {
            ArrayList<String> arrCol = data.get(i);
            row = sheet.createRow(i + headRow);    //데이터 시작행 헤더 row만큼 plus
            for (int j = 0; j < arrCol.size(); j++) {
                //기준정보 및 분류정보 입력
                String sVal = String.valueOf(arrCol.get(j));
                row.createCell(j).setCellValue(new HSSFRichTextString(sVal));
                row.getCell(j).setCellStyle(dataStyle);
            }
            for (int z = dataCol; z < headCol; z++) {
                //실제 데이터 null값 적용 및 스타일 적용
                row.createCell(z).setCellValue("");
                row.getCell(z).setCellStyle(dataStyle);
            }
            row.setHeightInPoints(20);
        }

        //Map<String, Object> dataOptions = new HashMap<String, Object>();
        dataOptions.clear();
        dataOptions.put("EXCEL_START_ROW", headRow);
        mergeInputCell(data, sheet, dataOptions);    //셀 을 머지한다.(머지할 데이터, 시트, 시트옵션)

        sheet.setColumnHidden(HDN_COL_NO_WRTTIME_IDTFR_CD, true);    //wrttimeIdtfrId 컬럼 숨김
        sheet.setColumnHidden(HDN_COL_NO_DVADVS_CD, true);            //dtadvs 컬럼 숨김
        sheet.setColumnHidden(HDN_COL_NO_CLS_DATANO, true);            //clsDatano 컬럼 숨김
        sheet.setColumnHidden(HDN_COL_NO_GRP_DATANO, true);            //grpDatano 컬럼 숨김

        response.setCharacterEncoding("UTF-8");
        try {
            //response.setHeader("Content-Disposition", Encodehelper.getDisposition((sFileNm + DEF_EXT_XLS), Encodehelper.getBrowser(request)));
            response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, sFileNm + DEF_EXT_XLS));
        } catch (UnsupportedEncodingException e) {
            EgovWebUtil.exLogging(e);
        } catch (Exception e) {
            EgovWebUtil.exLogging(e);
        }

    }

    /**
     * map으로 되어있는 head 데이터를 arrayList로 변환한다.
     *
     * @param data
     * @return
     */
    public ArrayList<ArrayList<String>> getExcelFormHeader(Map<String, Object> data) {
        //항목 관련데이터
        List<Map<String, Object>> iData = (List<Map<String, Object>>) data.get("I_DATA");            //항목 데이터
        int iMaxLevel = (Integer) data.get("I_MAX_LEVEL");                                //항목 최대 레벨
        int cMaxLevel = (Integer) data.get("C_MAX_LEVEL");                                //분류 최대 레벨
        int gMaxLevel = (Integer) data.get("G_MAX_LEVEL");                                //그룹 최대 레벨

        ArrayList<ArrayList<String>> sArr = new ArrayList<ArrayList<String>>();
        ArrayList<String> arr = null;

        Locale locale = egovMessageSource.getSessionLocaleResolver().getLocale();
        String group = egovMessageSource.getReloadableResourceBundleMessageSource().getMessage("stat.ko.group", null, "그룹", locale);

        //첫번째 행 항목 기준정보 입력
        arr = new ArrayList<String>();
        arr.add(HDN_COL_CD_WRTTIME_IDTFR_CD);        // 자료 시점
        arr.add(HDN_COL_CD_DTADVS_CD);
        arr.add(HDN_COL_CD_CLS_DATANO);
        arr.add(HDN_COL_CD_GRP_DATANO);
        arr.add(HDN_COL_CD_NO);
        arr.add("자료시점");
        for (int j = 0; j < gMaxLevel; j++) {
//			arr.add("그룹");
            arr.add(group);
        }
        for (int j = 0; j < cMaxLevel; j++) {
            arr.add("분류");
        }
        arr.add("통계자료");
        for (Map<String, Object> r : iData) {
            //if ( ((BigDecimal) r.get("leaf")).intValue() == 1 ) {
            if ("N".equals(String.valueOf(r.get("dummyYn")))) {
                //엑셀에 항목번호 + 필수 입력 여부(Y/N) 입력(엑셀에선 숨김처리)
                arr.add(String.valueOf(r.get("datano")) + ("Y".equals(String.valueOf(r.get("inputNeedYn"))) ? "_Y" : "_N"));
            }
        }
        sArr.add(arr);

        //이후 헤더 정보 입력
        int forCnt = iMaxLevel + UI_ROW_CNT;
        for (int i = 0; i < forCnt; i++) {
            arr = new ArrayList<String>();
            arr.add(HDN_COL_CD_WRTTIME_IDTFR_CD);
            arr.add(HDN_COL_CD_DTADVS_CD);
            arr.add(HDN_COL_CD_CLS_DATANO);
            arr.add(HDN_COL_CD_GRP_DATANO);
            arr.add(HDN_COL_CD_NO);
            arr.add("자료시점");
            for (int j = 0; j < gMaxLevel; j++) {
                arr.add(group);
            }
            for (int j = 0; j < cMaxLevel; j++) {
                arr.add("분류");
            }
            arr.add("통계자료");
            for (Map<String, Object> r : iData) {
                //if ( ((BigDecimal) r.get("leaf")).intValue() == 1 ) {	//자식노드가 없는경우
                if ("N".equals(String.valueOf(r.get("dummyYn")))) {
                    if (i == forCnt - 1) {
                        arr.add(String.valueOf(r.get("uiNm")));
                    } else {
                        String[] itmNmArr = String.valueOf(r.get("itmFullNm")).split(">");
                        if (itmNmArr.length > 1) {            //레벨단위로 항목명 length보다 큰 경우(레벨로 된 항목인경우)
                            if ((i + 1) > itmNmArr.length) {    //항목레벨보다 max level이 항상 크지 않으므로 마지막 항목레벨 값 넣는다.
                                arr.add(itmNmArr[itmNmArr.length - 1]);
                            } else {
                                arr.add(itmNmArr[i]);
                            }
                        } else {
                            arr.add(String.valueOf(r.get("itmNm")));
                        }
                    }
                }
            }
            sArr.add(arr);
        }

        return sArr;
    }

    /**
     * 행과 열이 같은 셀을 머지한다
     *
     * @param data    엑셀 array data
     * @param sheet   sheet
     * @param options 엑셀 머지 옵션들
     *                options.EXCEL_START_ROW : 엑셀시트 시작 INDEX
     *                options.EXCEL_START_ROW : 엑셀시트 종료 INDEX
     *                options.IS_HEADER 		: 머지하려는게 시트 헤더인 경우
     */
    public void mergeInputCell(ArrayList<ArrayList<String>> data, HSSFSheet sheet, Map<String, Object> options) {
        boolean isHeader = false;
        int iExcelStartRow = 0;    //엑셀 시작 row(default 1행 -> 항목 데이터번호 값이지만 엑셀 설정값이 hidden이 아니라 사이즈 조절(0)으로 숨겨서 startRow에 포함되지 않음.)
        int iExcelStartCol = 2;    //엑셀 시작 Col(default 1열:비교자로구분코드, 2열:분류데이터번호)
        if (options != null && options.get("EXCEL_START_ROW") != null) {
            iExcelStartRow = iExcelStartRow + ((Integer) options.get("EXCEL_START_ROW"));
        }
        if (options != null && options.get("EXCEL_START_COL") != null) {
            iExcelStartCol = iExcelStartCol + ((Integer) options.get("EXCEL_START_COL"));
        }
        if (options != null && options.get("IS_HEADER") != null) {
            //헤더여부
            isHeader = (Boolean) options.get("IS_HEADER");
        }

        int headCellRowStart = 0;
        int iRowCnt = data.size();
        int iColCnt = data.get(0).size();
        int maxMergeYNum = iRowCnt - 1;
        String[][] headCell = new String[iRowCnt][iColCnt];    //row와 col 갯수로 2차원 배열 생성

        //배열에 순서대로 입력
        for (int i = 0; i < data.size(); i++) {
            ArrayList<String> arrCol = data.get(i);
            for (int j = 0; j < arrCol.size(); j++) {
                headCell[i][j] = String.valueOf(arrCol.get(j));
            }
        }

        List<Map<String, Integer>> mergeList = new ArrayList<Map<String, Integer>>();
        Map<String, Integer> mergeMap = null;
        int mergeXNum = 0;    //컬럼 같은text 갯수
        int mergeYNum = 0;    //행 같은 text 갯수

        if (isHeader) {    //헤더인 경우
            headCellRowStart = headCellRowStart + UI_ROW_CNT;    //헤더 비교row start idx(단위항목 row 추가)
            maxMergeYNum = maxMergeYNum - UI_ROW_CNT;            //최대 머지 갯수
        }

        for (int i = headCellRowStart; i < headCell.length; i++) {
            for (int j = iExcelStartCol; j < headCell[i].length; j++) {
                mergeXNum = 0;
                mergeYNum = 0;

                //focus 셀 부터 하위 row가 같은 text인지 확인
                rowChkLoop:
                for (int x = i + 1; x < headCell.length; x++) {
                    if (headCell[i][j] != null && headCell[x][j] != null && headCell[i][j].equals(headCell[x][j])) {
                        mergeYNum++;    //다음 row와 text 같으면 숫자 증가
                    } else {
                        break rowChkLoop;
                    }
                }

                //row merge가 시작부터 끝까지 되어있거나 되지 않았을경우
                if (mergeYNum == maxMergeYNum || mergeYNum == 0) {
                    //focus 셀 부터 이후 컬럼들이 같은 text인지 확인
                    colChkLoop:
                    for (int z = j + 1; z < headCell[i].length; z++) {
                        if (headCell[i][j] != null && headCell[i][z] != null && headCell[i][j].equals(headCell[i][z])) {
                            mergeXNum++;
                        } else {
                            break colChkLoop;    //아니면 for문 빠져나온다
                        }
                    }
                }

                //같은 행이나 컬럼값이 있는경우
                if (mergeXNum > 0 || mergeYNum > 0) {
                    mergeMap = new HashMap<String, Integer>();
                    mergeMap.put("beginRow", i + iExcelStartRow);
                    mergeMap.put("endRow", i + mergeYNum + iExcelStartRow);    //동일한 text갯수만큼 추가(row)
                    mergeMap.put("beginCol", j);
                    mergeMap.put("endCol", j + mergeXNum);    //동일한 text갯수만큼 추가(column)
                    mergeList.add(mergeMap);
                    j = j + mergeXNum;    //동일한 text는 갯수만큼 머지 했으므로 다음행은 체크할 필요가 없다.
                }
            }
        }

        for (Map<String, Integer> colMerge : mergeList) {
            //셀 머지수행
            sheet.addMergedRegion(new CellRangeAddress(colMerge.get("beginRow"), colMerge.get("endRow"), colMerge.get("beginCol"), colMerge.get("endCol")));
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
        style.setBorderTop(CellStyle.BORDER_THIN);
        style.setBorderRight(CellStyle.BORDER_THIN);
        style.setBorderBottom(CellStyle.BORDER_THIN);
        style.setBorderLeft(CellStyle.BORDER_THIN);

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


    /*
     * 가로형태로 나열되어 있는 headText를 세로형태로 피벗한다.(row 머지하기 위해서)
     * ex) 현재 : 자료시점|분류|통계자료|계
     * 	   변경 : 자료시점
     *            분류
     *            통계자료.....
     */
	    /*
		ArrayList<ArrayList<String>> transRow = new ArrayList<ArrayList<String>>();
		for ( int i=0; i < arrHead.size(); i++ ) {
			ArrayList<String> headCol = arrHead.get(i);
			for ( int j=0; j < headCol.size(); j++ ) {
				if ( i == 0 ) {
					ArrayList<String> headArr = new ArrayList<String>();
					headArr.add(i, headCol.get(j));
					transRow.add(j, headArr);
				} else {
					transRow.get(j).add(i, headCol.get(j));
				}
			}
		}
		*/

    /**
     * 같은 Text 끼리 셀을 머지한다.
     *
     * @param arrHead    헤더Text arraylist
     * @param sheet        sheet obj
     * @param gubun        Row, Col 구분
     */
	/*
	public void mergeHeaderCell(ArrayList<ArrayList<String>> arrHead, HSSFSheet sheet, String gubun) {
		
		int iMergeCnt = 0;		//머지할 셀의 갯수
		int iMergeCond = -1;	//머지 조건에 만족하는 상태인지
		List<Map<String, Integer>> mergeList = new ArrayList<Map<String, Integer>>();
		Map<String, Integer> mergeMap = null;
		
		if ( arrHead.size() > 0 && !gubun.equals("") ) {
			for ( int i=0; i < arrHead.size(); i++ ) {
				ArrayList<String> trans = arrHead.get(i);
				iMergeCond = -1;
				iMergeCnt = 0;
				for ( int j=0; j < trans.size(); j++ ) {
					if ( j < trans.size() - 1 ) {	//마지막행은 수행안함.
						String sVal = String.valueOf(trans.get(j));
						if ( sVal.equals(String.valueOf(trans.get(j+1))) && j > iMergeCond ) {
							//만약 다음에 올 값이 같은 text이면
							mergeMap = new HashMap<String, Integer>();
							breakLoop :
							for ( int z=j; z < trans.size()-1; z++ ) {
								//text값을 j부터 체크하고 맞으면 mergeCnt 증가한다.
								if ( String.valueOf(trans.get(z)).equals(String.valueOf(trans.get(z+1))) ) {
									iMergeCnt++;
								} else {
									//다른 text 값이 나오면 loop을 빠져나온다.
									break breakLoop;
								}
							}
							if ( gubun.equals("Col") ) {
								mergeMap.put("beginRow", i);
								mergeMap.put("endRow", i);
								mergeMap.put("beginCol", j);
								mergeMap.put("endCol", j+iMergeCnt);	//j부터 같은 텍스트 갯수만큼 endCol로 지정
							} else if ( gubun.equals("Row") ) {
								mergeMap.put("beginRow", j);
								mergeMap.put("endRow", j+iMergeCnt);
								mergeMap.put("beginCol", i);
								mergeMap.put("endCol", i);
							}
							iMergeCond = j+iMergeCnt;
							mergeList.add(mergeMap);
						}
					}
				}
			}
			for ( Map<String, Integer> colMerge : mergeList ) {
				sheet.addMergedRegion(new CellRangeAddress(colMerge.get("beginRow"), colMerge.get("endRow"), colMerge.get("beginCol"), colMerge.get("endCol")));
			}
		}
	}
	*/
}
