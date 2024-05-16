package egovframework.soportal.stat.service.impl;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.codehaus.jackson.map.ObjectMapper;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.XMLWriter;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.ibleaders.ibsheet7.ibsheet.excel.Down2Excel;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Encodehelper;
import egovframework.soportal.stat.service.MultiStatListService;
import egovframework.soportal.stat.service.StatListService;
import egovframework.soportal.stat.service.StatPortalDownService;
/**
 * 포털에서 시트 데이터 파일 다운로드 하는 서비스
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2017/11/14
 */
@Service(value="statPortalDownService")
public class StatPortalDownServiceImpl implements StatPortalDownService {
	
	@Resource(name="statListDao")
	protected StatListDao statListDao;
	
	@Resource(name="statListService")
	protected StatListService statListService;

	@Resource(name="multiStatListDao")
	protected MultiStatListDao multiStatListDao;
	
	@Resource(name="multiStatListService")
	protected MultiStatListService multiStatListService;
	
	// 기준시점대비 변동분석 화면 - 시트의 기준시점 색상
	private static final String BPOINT_IB_COLOR_DTA = "d3d3d3";
	
	/**
	 * ibsheet의 data에서 해당 propertie 값(xml 구조로 되어있는)을 가져온다.
	 * @param Header	ibsheet 데이터 값
	 * @param prop		추출 할 프로퍼티 값
	 * @return
	 * @throws Exception
	 */
	public String getPropValue(String Header, String prop) {
        int findS = 0;
        int findE = 0;
        findS = Header.indexOf((new StringBuilder("<")).append(prop).append(">").toString());
        findE = Header.indexOf((new StringBuilder("</")).append(prop).append(">").toString());
        if(findS != -1 && findE != -1)
            return Header.substring(findS + prop.length() + 2, findE);
        else
            return "";
    }
	
	/**
	 * 파일 출력(저장)
	 * @param response
	 * @param object
	 * @throws Exception
	 */
	private void outFile(HttpServletResponse response, Object object) {
		
		
		ByteArrayInputStream bis = null;
		ServletOutputStream out = null;
		try {
			out = response.getOutputStream();
			//InputStream in = null;
			byte data[] = object.toString().getBytes("UTF-8");
			bis = new ByteArrayInputStream(data);
			//in = bis;
			byte outputByte[] = new byte[4096];
			for(int bytesRead = 0; (bytesRead = bis.read(outputByte, 0, 4096)) != -1;) {
				out.write(outputByte, 0, bytesRead);
			}
			out.flush();
			
		} catch(IOException ioe) {
			EgovWebUtil.exLogging(ioe);
		} catch(Exception e) {
			EgovWebUtil.exLogging(e);
		} finally {
			try {
				if ( bis != null )	bis.close();
				if ( out != null )	out.close();
			} catch (DataAccessException e) {
	    		EgovWebUtil.exLogging(e);
	    	} catch (Exception e) {
	    		EgovWebUtil.exLogging(e);
	    	}
		}
	}
	
	/**
	 * 엑셀 헤더 스타일 정의
	 * @param workbook
	 * @return
	 */
	public CellStyle setExcelHeadRowStyle (Workbook workbook) { 
		//HSSFCellStyle style = (HSSFCellStyle) workbook.createCellStyle();
		XSSFCellStyle style = (XSSFCellStyle) workbook.createCellStyle();
		//폰트
		Font font = workbook.createFont();
		font.setFontName("Malgun Gothic");
		font.setBoldweight(Font.BOLDWEIGHT_BOLD);
		//정렬
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		//배경색
		style.setFillForegroundColor(HSSFColor.LIGHT_CORNFLOWER_BLUE.index);
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
	    
	    return style;
	}
	
	/**
	 * 엑셀 데이터 스타일 정의
	 * @param workbook
	 * @return
	 */
	public CellStyle setExcelDataRowStyle (Workbook workbook) { 
		//HSSFCellStyle style = (HSSFCellStyle) workbook.createCellStyle();
		XSSFCellStyle style = (XSSFCellStyle) workbook.createCellStyle();
		
		//폰트
		Font font = workbook.createFont();
		font.setFontName("Malgun Gothic");
		font.setBoldweight(Font.BOLDWEIGHT_NORMAL);
		//정렬
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		//배경색
		style.setFont(font);
	    style.setBorderTop(CellStyle.BORDER_THIN);
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBorderRight(CellStyle.BORDER_THIN);
	    //style.setLocked(true);
	    
	    return style;
	}
	
	/**
	 * ibsheet에 있는 시트 데이터 가져오는 서비스
	 * 	=> js에서 Down2Excel로 요청했을 경우 ibExcel.getData() 했을 경우 
	 * 	   sheet 데이터를 xml 구조로 가져 올수 있다.
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	private Record getSheetData(HttpServletRequest request, HttpServletResponse response) {
		Record sheetDataMap = new Record();
		
		Down2Excel ibExcel = new Down2Excel();
		ibExcel.setService(request, response);
		response.reset();
		
		/* String으로 ibsheet 엑셀 시트 구조(설정정보 포함) 가져온다. */
		String dataStr = "";
		try {
			dataStr = ibExcel.getData();
			
		}  catch (DataAccessException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		}
		dataStr = dataStr.replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("&quot;", "\"").replaceAll("&apos;", "\'");
		
		//<UserMerge> 뒤부터 실제 데이터 있음
		String data = dataStr.substring(dataStr.lastIndexOf("</UserMerge>")).replaceAll("</UserMerge>", "") ;
		
		//실제 데이터(String[] 타입)
		sheetDataMap.put("data", data.split(""));
		
		//헤더 로우행 숫자(갯수)
		int headRows = Integer.parseInt(getPropValue(dataStr, "HeaderRows"));	
		sheetDataMap.put("headRows", headRows);
		
		//컬럼 갯수
		int colAllCnt = getPropValue(dataStr, "SaveNames").split("\\|").length;
		sheetDataMap.put("colAllCnt", colAllCnt);
		
		//엑셀 머지하는 셀 정의(엑셀에서만 사용)
		String merge = getPropValue(dataStr, "Merge");
		sheetDataMap.put("merge", merge);
		
		// 파일명
		String fileName = getPropValue(dataStr, "FileName");
		sheetDataMap.put("fileName", fileName);
		
		return sheetDataMap;
	}
	
	/**
	 * 엑셀을 다운로드 한다.
	 */
	@Override
	public void portalDown2Excel(HttpServletRequest request, HttpServletResponse response, Params params) {
		//파일명
		//String fileNm = params.getString("statTitle").replaceAll("\\s+$","") + ".xlsx";	//뒤 공백 제거
		
		
		// 엑셀 워크북을 생성
		//Workbook workbook = new HSSFWorkbook();
		XSSFWorkbook workbook = new XSSFWorkbook();
		
		Sheet sheet = workbook.createSheet("excel");
		sheet.setDefaultColumnWidth(15);	//시트 기본 너비
		
		CellStyle headRowStyle = setExcelHeadRowStyle(workbook);	//헤더 스타일
		CellStyle dataRowStyle = setExcelDataRowStyle(workbook);	//데이터 스타일
		
		//HSSFFont cmmtFont = (HSSFFont) workbook.createFont();
		XSSFFont cmmtFont = (XSSFFont) workbook.createFont();
		cmmtFont.setColor(IndexedColors.BLUE.index);
		cmmtFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		
		Record sheetDataMap = getSheetData(request, response);		//ibsheet 데이터 가져온다.
		String fileNm = sheetDataMap.getString("fileName");	//파일명
		int headRows = sheetDataMap.getInt("headRows");		//전체 헤더 로우
		int colAllCnt = sheetDataMap.getInt("colAllCnt");	//전체 컬럼갯수
		
		Row row = null;
		String[] dataRows = sheetDataMap.getStringArray("data");
		try {
			//ROW for start
			for ( int i=0; i < dataRows.length-1; i++ ) {	
				row = sheet.createRow(i);
				row.setHeight((short) 500);
				String[] dataCols = dataRows[i].split("\177");
				
				//COL for start
				for ( int j=0; j < colAllCnt; j++ ) {
					String value = "";
					String cmmt = "";
					if ( dataCols.length > j ) {
						value = dataCols[j];
					}
					Cell cell = row.createCell(j); 
					
					if ( !"".equals(value) ) {
						value = value.replaceAll("ededed", "").replaceAll(BPOINT_IB_COLOR_DTA, "");	//필요 없이 붙어있는 값 제거, 기준시점에서 기준시점 색상데이터 제거
						if ( value.indexOf("<span style='color: blue;font-weight: bold;font-size:x-small;'>") > -1 ) {
							//데이터에 주석이 있는 경우 주석만 추출하여 표시
							cmmt = value.substring(value.indexOf(";'>"), value.lastIndexOf("</span>")).replaceAll(";'>", "");
							value = value.substring(0, value.lastIndexOf("<span style=")).replaceAll("&nbsp;", "") + " ";	//데이터와 주석 사이에 공백 한칸 줌
						}
						
						if ( !"".equals(cmmt) ) {
							//정의된 스타일로 주석 표시
							//HSSFRichTextString rich = new HSSFRichTextString(value + cmmt);
							XSSFRichTextString rich = new XSSFRichTextString(value + cmmt);
							rich.applyFont(value.length(), value.length() + cmmt.length(), cmmtFont);
							cell.setCellValue(rich);
						} else {
							cell.setCellValue(value);
						}
					}
					
					if ( i < headRows ) {
						row.getCell(j).setCellStyle(headRowStyle);
					} else {
						row.getCell(j).setCellStyle(dataRowStyle);
					}
				}
			}			
			
			//엑셀 머지 설정
			String merge = sheetDataMap.getString("merge");
			if( !merge.equals("") ) {
				String merges[] = merge.split(" ");
				int i = 0;
				for(int maxLen = merges.length; i < maxLen; i++)
				{
					String mergeData[] = merges[i].split(",", 4);
					int mStartRow = Integer.parseInt(mergeData[0]);	// + sheetInfo.startRow;
					int mStartCol = Integer.parseInt(mergeData[1]);	// + sheetInfo.startCol;
					int mEndRow = Integer.parseInt(mergeData[2]);	// + sheetInfo.startRow;
					int mEndCol = Integer.parseInt(mergeData[3]);	// + sheetInfo.startCol;
					if(mStartCol <= mEndCol)
						sheet.addMergedRegion(new CellRangeAddress(mStartRow, mEndRow, mStartCol, mEndCol));
				}
				
			}
			
			//[복수통계] 일 경우를 위해 추가
			if(params.getString("statMulti") == null) params.set("statMulti", "N");
			if(params.getString("statMulti") != null){
				if(params.getString("statMulti").equals("Y")){ //복수통계일 경우 parmas의 데이터를 가공한다. //<--------- UNCHECKED NULL(처리완료)
					//복수통계 넘어온 시계열 통계 데이터를 변수 할당
					multiStatListService.makeStatTabMVal(params);
					//복수통계는 파일명을 별도로 세팅한다.
					//fileNm = params.getString("tabTitle").replaceAll("\\s+$","") + ".xlsx";	//뒤 공백 제거
				}
			}
			
			Map<String, Object> statTblItm = new HashMap<String, Object>();
			if(params.getString("statMulti") != null){
				if(params.getString("statMulti").equals("Y")){//[복수통계] 일 경우를 위해 추가 //<--------- UNCHECKED NULL(처리완료)
					statTblItm = multiStatListService.multiTblItm(params);
				}else{
					statTblItm = statListService.statTblItm(params);
				}
			}
			
			int cmmtStartRow = sheet.getLastRowNum()+1;
			List<Map<String, Object>> cmmtList = new ArrayList<Map<String, Object>>();
			if(params.getString("statMulti").equals("Y")){//[복수통계] 일 경우를 위해 추가
				cmmtList = (List<Map<String, Object>>) multiStatListDao.selectMultiStatCmmtList(params);
			}else{
				cmmtList = (List<Map<String, Object>>) statListDao.selectStatCmmtList(params);
			}
			
			/**
			 * 2018.04.27 김정호
			 * 통계자료(원자료)만 있을경우 시트에서 데이터 숨기는데 
			 * 다운받을경우는 숨기는 데이터는 ibsheet에서 array 로 가져오지 못하여서 null point 발생할 수 있음
			 * 원자료 한개만 조회하고 항목이 표측에 있을경우 주석 column -1 처리
			 */
			int dtadvsCol = 0;
			Map<String, Object> dtadvsLoc = (Map<String, Object>) statTblItm.get("dtadvsLoc");
			if ( dtadvsLoc != null ) {
				if ( "LEFT".equals(String.valueOf(dtadvsLoc.get("LOC"))) ) {
					dtadvsCol = -1;
				}
			}
			
			for ( Map<String, Object> cmmt : cmmtList ) {
				row = sheet.createRow(cmmtStartRow++);
				row.setHeight((short) 500);
				row.createCell(0).setCellValue(String.valueOf(cmmt.get("cmmtIdtfr")).replaceAll("null",  "") + "    " + String.valueOf(cmmt.get("cmmtCont")).replaceAll("null", ""));
			}
			
			//헤더 주석 데이터
			List<Record> cmmtRowCol = (List<Record>) statTblItm.get("cmmtRowCol");
			String cmmtVal = "";
			String preCmmtVal = "";
			//row와 col을 엑셀에서 확인하여 데이터를 입력하는 방식
			for ( Record r : cmmtRowCol ) {
				Cell cell = sheet.getRow(r.getInt("row")).getCell(r.getInt("col") + dtadvsCol);
				cmmtVal = r.getString("cmmt").replaceAll("&nbsp;<span style='color: blue;font-weight: bold;font-size:x-small;'>", "  ").replaceAll("</span>", "");
				//if ( !cmmtVal.equals(preCmmtVal) ) {
				String cellVal = getCellValue(cell);	//현재 입력되어 있는 셀 가져온다(length 필요)
				//정의된 스타일로 주석 표시
				//HSSFRichTextString rich = new HSSFRichTextString(cmmtVal);
				XSSFRichTextString rich = new XSSFRichTextString(cmmtVal);
				rich.applyFont(cellVal.length(), cmmtVal.length(), cmmtFont);
				cell.setCellValue(rich);
				//}
				//preCmmtVal = cmmtVal;
			}
			
//			String browser = getBrowser(request);
			
			try {
				response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
//				response.setHeader("Content-Disposition", getDisposition(fileNm, browser));
				response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, fileNm));
				response.setHeader("Content-Transfer-Encoding","binary;");
				response.setHeader("pragma","no-cache;" );
				
				// 다운로드 1. 생성된 엑셀 문서를 바로 다운로드 받음
				ServletOutputStream out = response.getOutputStream();
				workbook.write(out);
				out.flush();
				
				//간편통계 및 복수통계 모두 적용을 위해 통계표 ID를 배열형태로 받아 처리한다.
				if(params.getString("statMulti").equals("Y")){
					String[] arrStatblId = params.getStringArray("multiStatblId");
					
					for(int i=0; i<arrStatblId.length; i++){
						params.set("statblId", arrStatblId[i]);
						
						/* 통계표 변환저장 로그 기록 */
						params.set("saveExt", "XLS");
						insertPortalDownLog(params);
					}
				}else{
					/* 통계표 변환저장 로그 기록 */
					params.set("saveExt", "XLS");
					insertPortalDownLog(params);
				}
				
			}  catch (DataAccessException e) {
				EgovWebUtil.exTransactionLogging(e);
			} catch (Exception e) {
				EgovWebUtil.exTransactionLogging(e);
			}
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}

	}
	
	/**
	 * CSV 파일을 다운로드 한다.
	 */
	@Override
	public void portalDown2Csv(HttpServletRequest request, HttpServletResponse response, Params params) {
		String fileNm = params.getString("statTitle").replaceAll("\\s+$","") + ".csv";	//뒤 공백 제거
		
		// 엑셀 워크북을 생성
		//Workbook workbook = new HSSFWorkbook();
		XSSFWorkbook workbook = new XSSFWorkbook();
		
		Sheet sheet = workbook.createSheet("csv");
		
		Record sheetDataMap = getSheetData(request, response);
		int headRows = sheetDataMap.getInt("headRows");
		int colAllCnt = sheetDataMap.getInt("colAllCnt");
		
		Row row = null;
		
		String[] dataRows = sheetDataMap.getStringArray("data");
		try {
			for ( int i=0; i < dataRows.length-1; i++ ) {
				row = sheet.createRow(i);
				String[] dataCols = dataRows[i].split("\177");
				
				for ( int j=0; j < colAllCnt; j++ ) {
					String value = "";
					if ( dataCols.length > j ) {
						value = dataCols[j];
					}
					Cell cell = row.createCell(j); 
					
					if ( !"".equals(value) ) {
						value = value.replaceAll("ededed", "");
						if ( value.indexOf("<span style='color: blue;font-weight: bold;font-size:x-small;'>") > -1 ) {
							value = value.replaceAll("<span style='color: blue;font-weight: bold;font-size:x-small;'>", "  ").replaceAll("</span>", "").replaceAll("&nbsp;", "");
						}
						cell.setCellValue(value);
					}
					
				}
			}			
			
			//복수통계 일 경우를 위해 추가
			if(params.getString("statMulti") == null) params.set("statMulti", "N");
			if(params.getString("statMulti") != null){
				if(params.getString("statMulti").equals("Y")){ //복수통계일 경우 parmas의 데이터를 가공한다. //<--------- UNCHECKED NULL(예외처리)
					//복수통계 넘어온 시계열 통계 데이터를 변수 할당
					multiStatListService.makeStatTabMVal(params);
					//복수통계는 파일명을 별도로 세팅한다.
					fileNm = params.getString("tabTitle").replaceAll("\\s+$","") + ".csv";	//뒤 공백 제거
				}
			}
			
			Map<String, Object> statTblItm = new HashMap<String, Object>();
			if(params.getString("statMulti") != null){
				if(params.getString("statMulti").equals("Y")){//[복수통계] 일 경우를 위해 추가 //<--------- UNCHECKED NULL(예외처리)
					statTblItm = multiStatListService.multiTblItm(params);
				}else{
					statTblItm = statListService.statTblItm(params);
				}
			}
			
			int cmmtStartRow = sheet.getLastRowNum()+1;
			List<Map<String, Object>> cmmtList = new ArrayList<Map<String, Object>>();
			if(params.getString("statMulti").equals("Y")){//[복수통계] 일 경우를 위해 추가
				cmmtList = (List<Map<String, Object>>) multiStatListDao.selectMultiStatCmmtList(params);
			}else{
				cmmtList = (List<Map<String, Object>>) statListDao.selectStatCmmtList(params);
			}
			for ( Map<String, Object> cmmt : cmmtList ) {
				row = sheet.createRow(cmmtStartRow++);
				row.createCell(0).setCellValue(String.valueOf(cmmt.get("cmmtIdtfr")).replaceAll("null",  "") + "    " + String.valueOf(cmmt.get("cmmtCont")).replaceAll("null", ""));
			}
			
			List<Record> cmmtRowCol = (List<Record>) statTblItm.get("cmmtRowCol");
			String cmmtVal = "";
			for ( Record r : cmmtRowCol ) {
				Cell cell = sheet.getRow(r.getInt("row")).getCell(r.getInt("col"));
				cmmtVal = r.getString("cmmt").replaceAll("&nbsp;<span style='color: blue;font-weight: bold;font-size:x-small;'>", "  ").replaceAll("</span>", "");
				cell.setCellValue(cmmtVal);
			}
			
			String browser = getBrowser(request);
			
			try {
				response.setCharacterEncoding("UTF-8");
//				response.setHeader("Content-Disposition", getDisposition(fileNm, browser));
				response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, fileNm));
				response.setHeader("Content-Transfer-Encoding","binary;");
				response.setHeader("pragma","no-cache;" );
				response.setHeader("Content-Type", "text/csv");
				ServletOutputStream out = response.getOutputStream();
				workbook.write(out);
				out.flush();
				
			}  catch (DataAccessException e) {
				EgovWebUtil.exLogging(e);
			} catch (Exception e) {
				EgovWebUtil.exLogging(e);
			}
			
			//간편통계 및 복수통계 모두 적용을 위해 통계표 ID를 배열형태로 받아 처리한다.
			if(params.getString("statMulti").equals("Y")){
				String[] arrStatblId = params.getStringArray("multiStatblId");
				
				for(int i=0; i<arrStatblId.length; i++){
					params.set("statblId", arrStatblId[i]);
					
					/* 통계표 변환저장 로그 기록 */
					params.set("saveExt", "CSV");
					insertPortalDownLog(params);
				}
			}else{
				/* 통계표 변환저장 로그 기록 */
				params.set("saveExt", "CSV");
				insertPortalDownLog(params);
			}
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}

	}
	
	/**
	 * 텍스트 파일을 다운로드 한다.
	 */
	@Override
	public void portalDown2Text(HttpServletRequest request, HttpServletResponse response, Params params) {
		String fileNm = params.getString("statTitle").replaceAll("\\s+$","") + ".txt";	//뒤 공백 제거
		
		StringBuffer sb = new StringBuffer();
		
		Record sheetDataMap = getSheetData(request, response);
		int headRows = sheetDataMap.getInt("headRows");
		int colAllCnt = sheetDataMap.getInt("colAllCnt");

		//복수통계 일 경우를 위해 추가
		if(params.getString("statMulti") == null) params.set("statMulti", "N");
		if(params.getString("statMulti") != null){
			if(params.getString("statMulti").equals("Y")){ //복수통계일 경우 parmas의 데이터를 가공한다. //<--------- UNCHECKED NULL(예외처리)
				//복수통계 넘어온 시계열 통계 데이터를 변수 할당
				multiStatListService.makeStatTabMVal(params);
				//복수통계는 파일명을 별도로 세팅한다.
				fileNm = params.getString("tabTitle").replaceAll("\\s+$","") + ".txt";	//뒤 공백 제거
			}
		}
		
		Map<String, Object> statTblItm = new HashMap<String, Object>();
		try {
			if(params.getString("statMulti") != null){
				if(params.getString("statMulti").equals("Y")){//[복수통계] 일 경우를 위해 추가 //<--------- UNCHECKED NULL(예외처리)
					statTblItm = multiStatListService.multiTblItm(params);
				}else{
					statTblItm = statListService.statTblItm(params);
				}
			}
			
			List<Record> cmmtRowCol = (List<Record>) statTblItm.get("cmmtRowCol");
			String cmmtVal = "";
			
			String[] dataRows = sheetDataMap.getStringArray("data");
			for ( int i=0; i < dataRows.length-1; i++ ) {
				sb.append("\r\n");
				String[] dataCols = dataRows[i].split("\177");
				
				for ( int j=0; j < colAllCnt; j++ ) {
					String value = "";
					boolean isCmmtYn = false;
					if ( dataCols.length > j ) {
						value = dataCols[j];
					}
					
					if ( !"".equals(value) ) {
						value = value.replaceAll("ededed", "");
						if ( value.indexOf("<span style='color: blue;font-weight: bold;font-size:x-small;'>") > -1 ) {
							value = value.replaceAll("<span style='color: blue;font-weight: bold;font-size:x-small;'>", "  ").replaceAll("</span>", "").replaceAll("&nbsp;", "");
						}
						
						for ( Record r : cmmtRowCol ) {
							int row = r.getInt("row");
							int col = r.getInt("col");
							if ( i == row && j == col ) {
								cmmtVal = r.getString("cmmt").replaceAll("&nbsp;<span style='color: blue;font-weight: bold;font-size:x-small;'>", "  ").replaceAll("</span>", "");
								sb.append(cmmtVal);
								isCmmtYn = true;
							}
						}
						
						if ( isCmmtYn ) {
							sb.append("    ");
						} else {
							sb.append(value + "    ");
						}
						
					}
				}
			}	
			
			sb.append("\r\n \r\n");
			List<Map<String, Object>> cmmtList = new ArrayList<Map<String, Object>>();
			if(params.getString("statMulti").equals("Y")){//[복수통계] 일 경우를 위해 추가
				cmmtList = (List<Map<String, Object>>) multiStatListDao.selectMultiStatCmmtList(params);
			}else{
				cmmtList = (List<Map<String, Object>>) statListDao.selectStatCmmtList(params);
			}
			for ( Map<String, Object> cmmt : cmmtList ) {
				sb.append("\r\n");
				sb.append(String.valueOf(cmmt.get("cmmtIdtfr")).replaceAll("null",  "") + "    " + String.valueOf(cmmt.get("cmmtCont")).replaceAll("null", ""));
			}
			
			String browser = getBrowser(request);
			try {
				
				response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
//				response.setHeader("Content-Disposition", getDisposition(fileNm, browser));
				response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, fileNm));
				response.setHeader("Content-Transfer-Encoding","binary;");
				response.setHeader("pragma","no-cache;" );
				/*
		ServletOutputStream out = response.getOutputStream();
		
		byte data[] = sb.toString().getBytes("UTF-8");
		InputStream in = new ByteArrayInputStream(data);
        byte outputByte[] = new byte[4096];
        for(int bytesRead = 0; (bytesRead = in.read(outputByte, 0, 4096)) != -1;)
            out.write(outputByte, 0, bytesRead);

        in.close();
        out.flush();
        out.close();
				 */
				outFile(response, sb);	// 파일 출력
				
				//간편통계 및 복수통계 모두 적용을 위해 통계표 ID를 배열형태로 받아 처리한다.
				if(params.getString("statMulti").equals("Y")){
					String[] arrStatblId = params.getStringArray("multiStatblId");
					
					for(int i=0; i<arrStatblId.length; i++){
						params.set("statblId", arrStatblId[i]);
						
						/* 통계표 변환저장 로그 기록 */
						params.set("saveExt", "TXT");
						insertPortalDownLog(params);
					}
				}else{
					/* 통계표 변환저장 로그 기록 */
					params.set("saveExt", "TXT");
					insertPortalDownLog(params);
				}
				
			}  catch (DataAccessException e) {
				EgovWebUtil.exTransactionLogging(e);
			} catch (Exception e) {
				EgovWebUtil.exTransactionLogging(e);
			}
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
	}

	/**
	 * XML 파일을 다운로드 한다.
	 */
	@Override
	public void portalDown2Xml(HttpServletRequest request, HttpServletResponse response, Params params) {
		String fileNm = params.getString("statTitle").replaceAll("\\s+$","") + ".xml";	//뒤 공백 제거
		
		Record sheetDataMap = getSheetData(request, response);
		int headRows = sheetDataMap.getInt("headRows");
		int colAllCnt = sheetDataMap.getInt("colAllCnt");

		//복수통계 일 경우를 위해 추가
		if(params.getString("statMulti") == null) params.set("statMulti", "N");
		if(params.getString("statMulti") != null){
			if(params.getString("statMulti").equals("Y")){ //복수통계일 경우 parmas의 데이터를 가공한다. //<--------- UNCHECKED NULL(예외처리)
				//복수통계 넘어온 시계열 통계 데이터를 변수 할당
				multiStatListService.makeStatTabMVal(params);
				//복수통계는 파일명을 별도로 세팅한다.
				fileNm = params.getString("tabTitle").replaceAll("\\s+$","") + ".xml";	//뒤 공백 제거
			}
		}
		Map<String, Object> statTblItm = new HashMap<String, Object>();
		if(params.getString("statMulti") != null){
			if(params.getString("statMulti").equals("Y")){//[복수통계] 일 경우를 위해 추가 //<--------- UNCHECKED NULL(예외처리)
				statTblItm = multiStatListService.multiTblItm(params);
			}else{
				statTblItm = statListService.statTblItm(params);
			}
		}
		List<Record> cmmtRowCol = (List<Record>) statTblItm.get("cmmtRowCol");
		String cmmtVal = "";
		
		String[] dataRows = sheetDataMap.getStringArray("data");
		
		Document doc = DocumentHelper.createDocument();
		Element root = doc.addElement("xml");
		
		for ( int i=0; i < dataRows.length-1; i++ ) {
			Element elementRow = root.addElement("row" + (i+1));
			String[] dataCols = dataRows[i].split("\177");
			
			for ( int j=0; j < colAllCnt; j++ ) {
				String value = "";
				boolean isCmmtYn = false;
				if ( dataCols.length > j ) {
					value = dataCols[j];
				}
				
				if ( !"".equals(value) ) {
					value = value.replaceAll("ededed", "");
					if ( value.indexOf("<span style='color: blue;font-weight: bold;font-size:x-small;'>") > -1 ) {
						value = value.replaceAll("<span style='color: blue;font-weight: bold;font-size:x-small;'>", "  ").replaceAll("</span>", "").replaceAll("&nbsp;", "");
					}
					
					for ( Record r : cmmtRowCol ) {
						int row = r.getInt("row");
						int col = r.getInt("col");
						if ( i == row && j == col ) {
							cmmtVal = r.getString("cmmt").replaceAll("&nbsp;<span style='color: blue;font-weight: bold;font-size:x-small;'>", "  ").replaceAll("</span>", "");
							Element elementCol = elementRow.addElement("col" + (j+1)).addText(cmmtVal);
							isCmmtYn = true;
						}
					}
					
					if ( !isCmmtYn ) {
						Element elementCol = elementRow.addElement("col" + (j+1)).addText(value);
					}
				}
			}
		}	

		String browser = getBrowser(request);
		
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Type", "application/xml; charset=utf-8");
		
		try {
			
//			response.setHeader("Content-Disposition", getDisposition(fileNm, browser));
			response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, fileNm));
			response.setHeader("Content-Transfer-Encoding","binary;");
			response.setHeader("pragma","no-cache;" );
			
			OutputFormat format = OutputFormat.createPrettyPrint();
			StringWriter str = new StringWriter();
			XMLWriter w = new XMLWriter(str,format);
			w.write(doc);
			w.close();
			
			outFile(response, str);
			
			//간편통계 및 복수통계 모두 적용을 위해 통계표 ID를 배열형태로 받아 처리한다.
			if(params.getString("statMulti").equals("Y")){
				String[] arrStatblId = params.getStringArray("multiStatblId");
				
				for(int i=0; i<arrStatblId.length; i++){
					params.set("statblId", arrStatblId[i]);
					
					/* 통계표 변환저장 로그 기록 */
					params.set("saveExt", "XML");
					insertPortalDownLog(params);
				}
			}else{
				/* 통계표 변환저장 로그 기록 */
				params.set("saveExt", "XML");
				insertPortalDownLog(params);
			}
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}

	}
	
	/**
	 * JSON 파일을 다운로드 한다.
	 */
	@Override
	public void portalDown2Json(HttpServletRequest request, HttpServletResponse response, Params params) {
		String fileNm = params.getString("statTitle").replaceAll("\\s+$","") + ".json";	//뒤 공백 제거
		ObjectMapper objectMapper = new ObjectMapper();
		
		Record sheetDataMap = getSheetData(request, response);
		int headRows = sheetDataMap.getInt("headRows");
		int colAllCnt = sheetDataMap.getInt("colAllCnt");

		//복수통계 일 경우를 위해 추가
		if(params.getString("statMulti") == null) params.set("statMulti", "N");
		if(params.getString("statMulti") != null){
			if(params.getString("statMulti").equals("Y")){ //복수통계일 경우 parmas의 데이터를 가공한다. //<--------- UNCHECKED NULL(예외처리)
				//복수통계 넘어온 시계열 통계 데이터를 변수 할당
				multiStatListService.makeStatTabMVal(params);
				//복수통계는 파일명을 별도로 세팅한다.
				fileNm = params.getString("tabTitle").replaceAll("\\s+$","") + ".json";	//뒤 공백 제거
			}
		}
		
		Map<String, Object> statTblItm = new HashMap<String, Object>();
		if(params.getString("statMulti") != null){
			if(params.getString("statMulti").equals("Y")){//[복수통계] 일 경우를 위해 추가 //<--------- UNCHECKED NULL(예외처리)
				statTblItm = multiStatListService.multiTblItm(params);
			}else{
				statTblItm = statListService.statTblItm(params);
			}
		}
		
		List<Record> cmmtRowCol = (List<Record>) statTblItm.get("cmmtRowCol");
		String cmmtVal = "";
		
		String[] dataRows = sheetDataMap.getStringArray("data");
		
		List<LinkedHashMap<String, Object>> list = new LinkedList<LinkedHashMap<String, Object>>();
		
		for ( int i=0; i < dataRows.length-1; i++ ) {
			LinkedHashMap<String, Object> obj = new LinkedHashMap<String, Object>();
			String[] dataCols = dataRows[i].split("\177");
			
			for ( int j=0; j < colAllCnt; j++ ) {
				String value = "";
				boolean isCmmtYn = false;
				if ( dataCols.length > j ) {
					value = dataCols[j];
				}
				
				if ( !"".equals(value) ) {
					value = value.replaceAll("ededed", "");
					if ( value.indexOf("<span style='color: blue;font-weight: bold;font-size:x-small;'>") > -1 ) {
						value = value.replaceAll("<span style='color: blue;font-weight: bold;font-size:x-small;'>", "  ").replaceAll("</span>", "").replaceAll("&nbsp;", "");
					}
					
					for ( Record r : cmmtRowCol ) {
						int row = r.getInt("row");
						int col = r.getInt("col");
						if ( i == row && j == col ) {
							cmmtVal = r.getString("cmmt").replaceAll("&nbsp;<span style='color: blue;font-weight: bold;font-size:x-small;'>", "  ").replaceAll("</span>", "");
							obj.put("col" + (j+1), cmmtVal);
							isCmmtYn = true;
						}
					}
					
					if ( !isCmmtYn ) {
						obj.put("col" + (j+1), value);
					}
				}
			}
			list.add(obj);
		}	

		String browser = getBrowser(request);
		
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Type", "application/json; charset=utf-8");
		try {
			
//			response.setHeader("Content-Disposition", getDisposition(fileNm, browser));
			response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, fileNm));
			response.setHeader("Content-Transfer-Encoding","binary;");
			response.setHeader("pragma","no-cache;" );
			
			outFile(response, objectMapper.writeValueAsString(list));
			
			//간편통계 및 복수통계 모두 적용을 위해 통계표 ID를 배열형태로 받아 처리한다.
			if(params.getString("statMulti").equals("Y")){
				String[] arrStatblId = params.getStringArray("multiStatblId");
				
				for(int i=0; i<arrStatblId.length; i++){
					params.set("statblId", arrStatblId[i]);
					
					/* 통계표 변환저장 로그 기록 */
					params.set("saveExt", "JSON");
					insertPortalDownLog(params);
				}
			}else{
				/* 통계표 변환저장 로그 기록 */
				params.set("saveExt", "JSON");
				insertPortalDownLog(params);
			}
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}

	}

	/**
	 * 한글을 다운로드 한다.
	 */
	@Override
	public void portalDown2Hwp(HttpServletRequest request, Params params) {

		//간편통계 및 복수통계 모두 적용을 위해 통계표 ID를 배열형태로 받아 처리한다.
		if(params.getString("statMulti").equals("Y")){
			String[] arrStatblId = params.getStringArray("multiStatblId");
			
			for(int i=0; i<arrStatblId.length; i++){
				params.set("statblId", arrStatblId[i]);
				
				/* 통계표 변환저장 로그 기록 */
				params.set("saveExt", "HWP");
				insertPortalDownLog(params);
			}
		}else{
			/* 통계표 변환저장 로그 기록 */
			params.set("saveExt", "HWP");
			insertPortalDownLog(params);
		}

	}
	
	/**
	 * 셀 value 값을 추출한다.
	 * @param cell
	 * @return
	 */
	public static String getCellValue(Cell cell) {
		
		String cellValue = "";
		Short shortDataFormat = 0;
		String strDataFormat = "";
		
		DecimalFormat df = new DecimalFormat("#.#################");
		switch ( cell.getCellType() ) {
		case 0:	//CELL_TYPE_NUMERIC
			//----------------------------------------------------------------------------------------------
			if ( DateUtil.isCellDateFormatted( cell ) ) {  // 날짜 타입  (년월일만 적용됨, 시간은 반영 안됨)				
				Date date = cell.getDateCellValue();				
				//  년도와 시간을 읽어서 포맷 설정
				SimpleDateFormat yyyySdf = new SimpleDateFormat("yyyy");
				int yyyy  = Integer.parseInt( yyyySdf.format(date));
				SimpleDateFormat hhSdf = new SimpleDateFormat("HHmm");
				int hh  = Integer.parseInt( hhSdf.format(date));

				if ( yyyy < 1900  ) { // 시간 일 때 처리  ( 1900년 이하면 시간만 표시
					SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
					cellValue = sdf.format(date);
				} else {  //날짜로 표시 
					if (hh > 0 )  {  // 시간도 표시
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm ");
							cellValue = sdf.format(date);
					} else {  // 날짜만 표시
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							cellValue = sdf.format(date);
					}		
				}
			} else {   // 날짜 타입이 아닌 숫자.	 처리			
				// cellValue = "" + cell.getNumericCellValue();
				CellStyle style =  cell.getCellStyle();
				shortDataFormat = style.getDataFormat();
				strDataFormat = style.getDataFormatString();
				//cell.setCellType(Cell.CELL_TYPE_STRING);  // 문자 타잎으로 변환 
				cellValue  =     String.valueOf(new Double(cell.getNumericCellValue())); // 숫자 그대로 읽음		 ( .0 이 따라옴.

				//  숫자 형식 보정
				if ( cellValue.indexOf("E") > -1 || Double.parseDouble(cellValue) > 2147483647 ) {	//Double
						cellValue = df.format(Double.parseDouble(cellValue));
				} else if ( cellValue.indexOf(".") > -1 ) {  // 실수
					// 소수점 아래를 잘라서 0이 아니면 실수로 다시 가져옴					
					if (Integer.parseInt( cellValue.substring(cellValue.indexOf(".") +1) ) !=  0 ) { 						
							cellValue = String.valueOf ( new Double(cell.getNumericCellValue()) ); //  그냥 그대로 가져온다. ( 실수로 처리 하면 소수점이 조정됨)
					} else {  // 아니면 정수
						   cellValue  =     String.valueOf(new Double(cell.getNumericCellValue()).intValue());  //정수로 가져온다					
					}
				} else {	//Int
					cellValue = String.valueOf(new Double(cell.getNumericCellValue()).intValue()); //정수로 가져온다		
				}				
			}
			//----------------------------------------------------------------------------------------------
			break;
		case 2 : 	//CELL_TYPE_FORMULA
			cellValue = cell.getCellFormula();
			break;
		case 1 : 	//CELL_TYPE_STRING
		case 3 : 	//CELL_TYPE_BLANK
			cellValue = "";
			try {
				cellValue = cell.getStringCellValue();
			} catch (IllegalStateException e) {
				//try {
					cell.setCellType(1);
					cellValue = cell.getStringCellValue();
					if ( cellValue.length() > 4 &&
							cellValue.indexOf("E") > -1 &&
							((cellValue + " ").substring(1, 2).equals(".")) &&
							(cellValue.substring(cellValue.length() -4, cellValue.length()).indexOf("E") > -1)) {
						cellValue = df.format(Double.parseDouble(cellValue));
					}
				//} catch (Exception e2) { //<--------- IMPROPER CHECK FOR UNUSUAL OR EXCEPTIONAL CONDITION(예외처리)
				//	cellValue = "";
				//}
			}
			break;
		case 5 : 	//CELL_TYPE_ERROR
			cellValue = "";
			break;
		case 4 :
			cellValue = Boolean.toString(cell.getBooleanCellValue());
			break;
		default : 
			cellValue = "";
			break;
		}
		
		return cellValue;
	}
	
	/**
	 * 통계표 변환저장 로그 기록
	 * @param params
	 */
	private void insertPortalDownLog(Params params) {
		try {
			statListDao.insertLogSttsTblSave(params);
		}  catch (DataAccessException e) {
			EgovWebUtil.exTransactionLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exTransactionLogging(e);
		}
	}
	
	/**
	* 브라우저 종류
	* @param request
	* @return
	*/
	public String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1 || header.indexOf("TRIDENT") > -1 ) {
			return "MSIE";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Safari") > -1) {
			return "Safari";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}
	
	/**
	* 다국어 파일명 처리
	* @param filename
	* @param browser
	* @return
	* @throws UnsupportedEncodingException
	*/
	public String getDisposition(String filename, String browser) throws UnsupportedEncodingException {
		String dispositionPrefix = "attachment;filename=";
		String encodedFilename = null;
		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "utf-8").replace("+", "%20").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			StringBuffer sb = new StringBuffer();
			sb.append('"');
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				sb.append(c);
			}
			sb.append('"');
			encodedFilename = sb.toString();
		} else if (browser.equals("Opera")) {
			encodedFilename = "" + new String(filename.getBytes("UTF-8"), "8859_1") + "";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else if (browser.equals("Safari")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				sb.append(c);
			}
			encodedFilename = sb.toString();
		} else {
			throw new RuntimeException("Not supported browser");
		}
		return dispositionPrefix + encodedFilename;
	}
	
}
