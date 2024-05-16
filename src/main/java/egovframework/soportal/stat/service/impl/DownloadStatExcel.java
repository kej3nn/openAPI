package egovframework.soportal.stat.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.dao.DataAccessException;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Encodehelper;


/**
 * 통계 시트 셀 제한시 다운로드(대용량)
 * 
 * @author 	김정호
 * @version	1.0
 * @since	2018/04/02
 */
public class DownloadStatExcel {
	
	public static void downloadStatDataXls(HttpServletResponse response, HttpServletRequest request, 
			Params params, Map<String, Object> headMap, List<Record> dataMap)  {
		try {
			
			SXSSFRow row = null;
			int iRow = 0;			// 엑셀 행 index
			int iCol = 0;			// 엑셀 열 index
			int dtadvsLoc = 0;		// 증감분석 갯수
			int cellIdx = 0;		// 컬럼 셀의 위치
			String value = "";		// 데이터 값
			String saveName = "";	// 헤더정보 키(saveName)
			LinkedList<String> headDataCols = new LinkedList<String>();	//헤더 데이터 컬럼 정보의 위치 저장하는 리스트
			
			// 워크북을 생성한다.
			SXSSFWorkbook workbook = new SXSSFWorkbook();
			
			// 시트를 생성한다.
			SXSSFSheet worksheet = (SXSSFSheet) workbook.createSheet("excel");
			
			// 셀의 기본 넓이와 높이를 설정한다.
			worksheet.setDefaultColumnWidth(13);
			worksheet.setDefaultRowHeightInPoints(20);
			
			// 셀 스타일 맵을 생성한다.
			Map<String, CellStyle> styleMap = initCellStyle(workbook);	
			
			/**
			 * 헤더 컬럼 정보를 확인한다.
			 * 	헤더 컬럼 갯수만큼 LinkedList에 컬럼 key를 순서대로 저장해 둔다.
			 *    => 나중에 데이터 조회후 셀에 입력할때 컬럼 key의 순서를 확인하고 그 index 위치에 셀데이터 입력을 위해서.
			 */
			List<HashMap<String, Object>> headCols = (List<HashMap<String, Object>>) headMap.get("Cols");	// 헤더 Col 정보들
			
			// 컬럼 전체 사이즈(seq는 엑셀에 입력안하여서 빠짐)
			int headColLen = headCols.size() -1;	
			
			// 헤더 컬럼 for loop [시작]
			for ( int i=0; i < headCols.size(); i++ ) {
				
				Map<String, Object> col = (Map<String, Object>) headCols.get(i);
				saveName = String.valueOf(col.get("SaveName"));		// 컬럼의 saveName 키
				
				// 데이터 컬럼인 경우
				if ( saveName.indexOf("COL_") > -1 ) {
					headDataCols.add(saveName);
				} else if ( saveName.equals("seq") ) {
					// coutinue(No는 엑셀에서 제회)
				} else {
					// 데이터 컬럼이 아닌 시계열, 항목, 분류 컬럼인 경우
					dtadvsLoc++;
				}
				
			}	// 헤더 컬럼 for loop [종료]
			
			
			/**
			 * 셀 텍스트 정보 확인
			 */
			ArrayList<Object> headArr = (ArrayList<Object>) headMap.get("Text");
			
			// 헤더 정보를 엑셀에 입력한다.
			for ( int i=0; i < headArr.size(); i++ ) {
				ArrayList<String> head = (ArrayList<String>) headArr.get(i);
				row = (SXSSFRow) worksheet.createRow(iRow++);		// 행 추가
				iCol = 0;
				
				for ( String val : head ) {
					if ( "No".equals(val) )	continue;	// No는 넘김
					row.createCell(iCol).setCellValue(val);
					row.getCell(iCol).setCellStyle(styleMap.get("def"));
					iCol++;
				}
			}
			
			// 통계기호
			//List<Record> statMarkList = statListDao.selectOption(new Params().set("grpCd", "S1011"));
			
			// 증감분석 정보확인
			/*
		Map<String, Object> dtadvsMap = (Map<String, Object>) headMap.get("dtadvsLoc");
		if ( dtadvsMap.size() > 0 ) {
			int itmLocCnt = 0;
			if ( "HEAD".equals(String.valueOf(dtadvsMap.get("LOC"))) ) {
				itmLocCnt = -1;
			}
			dtadvsLoc = Integer.parseInt(String.valueOf(dtadvsMap.get("CNT"))) + itmLocCnt;
		} 
			 */
			
			/**
			 * 엑셀에 셀 데이터 입력
			 * 	headColLen 만큼 미리 셀을 생성해두고 데이터 키를 이용해 셀 데이터를 입력
			 */
			if ( dataMap.size() > 0 ) {
				
				// Row for loop [시작]
				for ( Record record : dataMap ) {
					
					row = (SXSSFRow) worksheet.createRow(iRow++);	// row 추가
					
					iCol = 0;
					// 컬럼 셀을 미리 생성해 둔다.
					for ( int i = 0; i < headColLen; i++ ) {
						
						row.createCell(iCol);
						row.getCell(iCol).setCellStyle(styleMap.get("def"));
						iCol++;
					}
					
					iCol = 0;
					
					// Column for loop [시작]
					for ( Entry<Object, Object> entry : record.entrySet() ) {
						
						// 데이터 시작 위치부터
						if ( dtadvsLoc <= iCol ) {	
							
							String key = (String) entry.getKey();		// 데이터 키 값
							int colIdx = headDataCols.indexOf(key);		// 컬럼키의 위치
							
							// 헤더 컬럼 정보에 데이터 키가 있을경우 셀에 데이터를 입력한다.
							if ( colIdx > -1 ) {		
								
								value = entry.getValue().toString().replaceAll(",", "");
								cellIdx = dtadvsLoc + colIdx;
								row.getCell(cellIdx).setCellValue(value);
								/* 셀 서식에 맞게 엑셀 설정해주는 부분인데 소수점에 대한 보완필요..
							if ( "".equals(value) )	 {
								row.getCell(iCol).setCellValue(value);
							} else if ( value.indexOf(".") > -1 ) {
								row.getCell(iCol).setCellValue(Long.parseLong(value));
								row.getCell(iCol).setCellStyle(styleMap.get("decimal"));
								row.getCell(iCol).setCellType(HSSFCell.CELL_TYPE_FORMULA);
							} else {
								row.getCell(iCol).setCellValue(Double.parseDouble(value));
								row.getCell(iCol).setCellStyle(styleMap.get("int"));
								//row.getCell(iCol).setCellType(HSSFCell.CELL_TYPE_NUMERIC);
							}
								 */
							}
							
						} else {
							// 시계열, 항목, 분류는 else 구문에서 찍음.
							row.getCell(iCol).setCellValue(entry.getValue().toString());
						}
						
						iCol++;
						
					}	// Column for loop [시작]
				}	// Row for loop [종료]
			}
			
			
			response.setHeader("Access-Control-Allow-Origin", "*");
			response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			if(params.getString("langGb").equals("ENG")){
				response.setHeader("Content-Disposition", Encodehelper.getDisposition("StatsData.xlsx", Encodehelper.getBrowser(request)));
			}else{
//				response.setHeader("Content-Disposition", Encodehelper.getDisposition("통계대용량데이터.xlsx", Encodehelper.getBrowser(request)));
				response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, "통계대용량데이터.xlsx"));
			}
			
			// 파일 다운로드 라이브러리 onSuccess 호출하기 위해.
			Cookie fileDownload = new Cookie("fileDownload", "true");
			fileDownload.setPath("/");
			fileDownload.setSecure(true);
			response.addCookie(fileDownload);
			
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
	 * 셀 스타일을 초기화한다.
	 * @param workbook
	 * @return
	 */
	public static Map<String, CellStyle> initCellStyle(SXSSFWorkbook workbook) {
		Map<String, CellStyle> styleMap = new HashMap<String, CellStyle>();
		styleMap.put("def", setDataStyle(workbook)); 				// 기본 스타일
		styleMap.put("int", setDataStyleFormat(workbook, 1)); 		// 기본 스타일 + 숫자포맷
		styleMap.put("decimal", setDataStyleFormat(workbook, 2)); 	// 기본 스타일 + 소수점포맷
		return styleMap;
	}
	
	/**
	 * 통계표 대용량 다운로드 셀 스타일(기본)
	 * @param workbook
	 * @return
	 */
	public static CellStyle setDataStyle(SXSSFWorkbook workbook) { 
		CellStyle style = (CellStyle) workbook.createCellStyle();
		
		//폰트
		Font font = workbook.createFont();
		font.setFontName("Malgun Gothic");
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
	
	/**
	 * 셀 데이터의 포맷을 설정한다.
	 * @param workbook
	 * @param type
	 * @return
	 */
	public static CellStyle setDataStyleFormat(SXSSFWorkbook workbook, int type) {
		CellStyle style = setDataStyle(workbook);
		DataFormat format = workbook.createDataFormat();
		
		switch (type) {
		case 1:
			style.setDataFormat(format.getFormat("#,###"));
			style.setAlignment(CellStyle.ALIGN_RIGHT);
			break;
		case 2:
			style.setDataFormat(format.getFormat("#,##0.########"));
			style.setAlignment(CellStyle.ALIGN_RIGHT);
			break;
		}
		
		return style;
	}

}
