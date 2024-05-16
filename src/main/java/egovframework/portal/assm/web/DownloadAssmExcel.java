package egovframework.portal.assm.web;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.channels.UnresolvedAddressException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.xssf.streaming.SXSSFRow;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFShape;

import com.mortennobel.imagescaling.AdvancedResizeOp.UnsharpenMask;
import com.mortennobel.imagescaling.MultiStepRescaleOp;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.common.base.model.Params;
import egovframework.common.base.model.Record;
import egovframework.common.helper.Encodehelper;
import egovframework.portal.bpm.web.BpmMstController;

/**
 * 국회의원 데이터 엑셀 다운로드 공통 클래스
 * 
 * @author	JHKIM
 * @version 1.0
 * @since   2019/10/25
 */
public class DownloadAssmExcel {
	
	public static final ArrayList<String> EXIST_IMG_EXT = new ArrayList<String>(Arrays.asList("jpg", "jpeg", "png", "gif"));
	
	private static final int CONN_TIMEOUT_VALUE = 3000;	// URL CONNECTION TIMEOUT TIME(milli second) 
	private static final int EXCEL_FLUSH_ROW = -1;
	private static final String EXCEL_FILE_EXT = ".xlsx";
	private static final int ROWNUM_COL = 0;	// 번호
	private static final int APPEND_COL = 1;	// 기본적으로 추가되는 컬럼갯수(번호)

	public static void downloadXls(HttpServletResponse response, HttpServletRequest request, 
			Params params, List<String> header, List<ArrayList<Object>> datas) {
		
		SXSSFWorkbook workbook = null;
		ServletOutputStream out = null;
		
		SXSSFRow row = null;
		int iRow = 0;
		String value = "";
		
		try {
			// 워크북을 생성한다.
			workbook = new SXSSFWorkbook(EXCEL_FLUSH_ROW);
			
			// 시트를 생성한다.
			SXSSFSheet sheet = (SXSSFSheet) workbook.createSheet("excel");
			
			// 셀의 기본 넓이와 높이를 설정한다.
			sheet.setDefaultColumnWidth(18);
			sheet.setDefaultRowHeightInPoints(23);
			
			// 헤더 입력
			row = (SXSSFRow) sheet.createRow(iRow++);
			
			// 번호 기본으로 입력
			row.createCell(ROWNUM_COL).setCellValue("번호");
			row.getCell(ROWNUM_COL).setCellStyle(setHeadStyle(workbook));
			
			for ( int i=0; i < header.size(); i++ ) {
				row.createCell(i+APPEND_COL).setCellValue(header.get(i));
				row.getCell(i+APPEND_COL).setCellStyle(setHeadStyle(workbook));
			}	
			
			// 데이터 입력
			for ( int i=0; i < datas.size(); i++ ) {
				row = (SXSSFRow) sheet.createRow(iRow++);
				ArrayList<Object> rd = (ArrayList<Object>) datas.get(i);
				
				int iCol = 0;
				row.createCell(iCol).setCellValue((i+1));
				row.getCell(iCol).setCellStyle(setDataStyle(workbook));
				iCol = iCol + APPEND_COL;
				
				for ( int j=0; j < rd.size(); j++ ) {
					
					value = String.valueOf(rd.get(j));
					if ( StringUtils.startsWith(value, "http") || StringUtils.startsWith(value, "https") ) {
						row.createCell(iCol);
						sheet.setColumnWidth(iCol, 3000);	// width 1당 = 1.2mm
						
						// 이미지 파일인지 체크
						String fileExt = value.substring(value.lastIndexOf(".")+1, value.length());
						if ( EXIST_IMG_EXT.contains(fileExt) ) {
							row.setHeight((short) 1700);	// short 1당 = 1.76mm
							setCellUrlImage(workbook, sheet, value, iRow, iCol);
						}
					}
					else {
						row.createCell(iCol).setCellValue(value);
					}
					
					row.getCell(iCol).setCellStyle(setDataStyle(workbook));
					iCol++;
				}
			}
			
			// 글자 컬럼길이 자동정렬
			row = (SXSSFRow) sheet.getRow(0);
			for(int colNum = 0; colNum<row.getLastCellNum();colNum++) {
				if ( StringUtils.equals(StringUtils.defaultIfEmpty(row.getCell(colNum).getStringCellValue(), ""), "사진") ) {
					continue;
				}
				//sheet.autoSizeColumn(colNum); //autoSizeColumn 사용시 내용이 많은 경우 오류발생 표준사이즈로 서비스 제공				
				sheet.setColumnWidth(colNum, sheet.getColumnWidth(colNum)+500);	// 컬럼 auto 사이즈 이후 추가로 500 늘려준다.
			}
			
			response.setHeader("Access-Control-Allow-Origin", "*");
			response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			response.setHeader("set-cookie", "fileDownload=true; path=/");

			// 다운로드 파일명
			StringBuffer fileNmBuff = new StringBuffer();
			if (params.get("GUBUN_ASSM_BPM").equals("ASSM")) {
				fileNmBuff.append(StringUtils.defaultIfEmpty(AssmMemberController.GUBUN_NAMES_TXT.get(params.getString("gubunId")), ""));
			} else {
				fileNmBuff.append(StringUtils.defaultIfEmpty(BpmMstController.GUBUN_NAMES_TXT.get(params.getString("gubunId")), ""));
				
			}
			fileNmBuff.append(StringUtils.isBlank(params.getString("excelNm", "")) ? "" : "_");
			fileNmBuff.append(params.getString("excelNm", ""));
			fileNmBuff.append(EXCEL_FILE_EXT);
			
//			response.setHeader("Content-Disposition", Encodehelper.getDisposition(StringUtils.defaultIfEmpty(fileNmBuff.toString(), "data"+EXCEL_FILE_EXT), Encodehelper.getBrowser(request)));
			response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, StringUtils.defaultIfEmpty(fileNmBuff.toString(), "data"+EXCEL_FILE_EXT)));
			
			out = response.getOutputStream();
			workbook.write(out);
		} catch (UnsupportedEncodingException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
			response.setHeader("Set-Cookie", "fileDownload=false; path=/");
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			response.setHeader("Content-Type","text/html; charset=utf-8");
			OutputStream catchOut = null;
			try {
				
				catchOut = response.getOutputStream();
				byte[] data = new String("fail..").getBytes();
				catchOut.write(data, 0, data.length);
			} catch(IOException ee) {
				EgovWebUtil.exLogging(ee);
			} finally {
				if(out != null) try { out.close(); } 
				catch(Exception ee) {
					EgovWebUtil.exLogging(ee);  
				}
			}
		} finally {
			if ( workbook != null ) {
				try{
					((SXSSFWorkbook) workbook).dispose();
				} catch (Exception e) {
					EgovWebUtil.exLogging(e);
				}
			}
			if ( out != null ) {
				try {
					out.close();
				} catch(IOException ioe){
					EgovWebUtil.exLogging(ioe);
				} catch(Exception e) {
					EgovWebUtil.exLogging(e);
				}
			}
		}
	}
	
	public static void downloadInfoXls(HttpServletResponse response, HttpServletRequest request, 
			Params params, List<String> header, List<ArrayList<Object>> datas, Map<String, Object> svcMap) {
		
		SXSSFWorkbook workbook = null;
		ServletOutputStream out = null;
		
		SXSSFRow row = null;
		int iRow = 0;
		String value = "";
		String infoColTxt = "";	// 다운로드 컬럼명
		
		try {
			// 워크북을 생성한다.
			workbook = new SXSSFWorkbook(EXCEL_FLUSH_ROW);
			
			// 시트를 생성한다.
			SXSSFSheet sheet = (SXSSFSheet) workbook.createSheet("excel");
			
			// 셀의 기본 넓이와 높이를 설정한다.
			sheet.setDefaultColumnWidth(18);
			sheet.setDefaultRowHeightInPoints(23);
			
			// 헤더 입력
			row = (SXSSFRow) sheet.createRow(iRow++);
			
			// 번호 기본으로 입력
			row.createCell(ROWNUM_COL).setCellValue("번호");
			row.getCell(ROWNUM_COL).setCellStyle(setHeadStyle(workbook));
			
			for ( int i=0; i < header.size(); i++ ) {
				row.createCell(i+APPEND_COL).setCellValue(header.get(i));
				row.getCell(i+APPEND_COL).setCellStyle(setHeadStyle(workbook));
			}
			
			// 데이터 입력
			for ( int i=0; i < datas.size(); i++ ) {
				row = (SXSSFRow) sheet.createRow(iRow++);
				ArrayList<Object> rd = (ArrayList<Object>) datas.get(i);
				
				int iCol = 0;
				row.createCell(iCol).setCellValue((i+1));
				row.getCell(iCol).setCellStyle(setDataStyle(workbook));
				iCol = iCol + APPEND_COL;
				
				for ( int j=0; j < rd.size(); j++ ) {
					
					value = String.valueOf(rd.get(j));
					if ( StringUtils.startsWith(value, "http") || StringUtils.startsWith(value, "https") ) {
						row.createCell(iCol);
						sheet.setColumnWidth(iCol, 3000);	// width 1당 = 1.2mm
						
						// 이미지 파일인지 체크
						String fileExt = value.substring(value.lastIndexOf(".")+1, value.length());
						if ( EXIST_IMG_EXT.contains(fileExt) ) {
							row.setHeight((short) 1700);	// short 1당 = 1.76mm
							setCellUrlImage(workbook, sheet, value, iRow, iCol);
						}
					}
					else {
						row.createCell(iCol).setCellValue(value);
					}
					
					row.getCell(iCol).setCellStyle(setDataStyle(workbook));
					iCol++;
				}
			}
			
			StringBuffer sb = new StringBuffer();
			List<Record> info = (List<Record>) svcMap.get("data2");
			
			if ( info.size() > 0 ) {
				
				int lastRowNum = sheet.getLastRowNum();
				SXSSFRow lastRow = (SXSSFRow) sheet.getRow(lastRowNum);
				int lastColNum = lastRow.getLastCellNum();
				
				for ( Record rec : info ) {
					// 약력(P01)
					if ( StringUtils.equals(rec.getString("profileCd"), "P01") && StringUtils.equals(params.getString("profileCd"), "P01") ) {
						infoColTxt = "약력";
						sb.append(rec.getString("profileSj"));
					}	// 국회의원 이력
					else if ( StringUtils.equals(rec.getString("profileCd"), "P10") && StringUtils.equals(params.getString("profileCd"), "P10") ) {
						infoColTxt = "국회의원 이력";
						sb.append(rec.getString("frtoDate"));
						sb.append("   ");
						sb.append(rec.getString("profileSj"));
						sb.append(System.getProperty("line.separator"));
					}	// 학력
					else if ( StringUtils.equals(rec.getString("profileCd"), "P04") && StringUtils.equals(params.getString("profileCd"), "P04") ) {
						infoColTxt = "학력";
						sb.append(rec.getString("frtoDate"));
						sb.append("   ");
						sb.append(rec.getString("profileSj"));
						sb.append(System.getProperty("line.separator"));
					}	// 위원회 경력
					else if ( StringUtils.equals(rec.getString("profileCd"), "P13") && StringUtils.equals(params.getString("profileCd"), "P13") ) {
						infoColTxt = "위원회 경력";
						sb.append(rec.getString("frtoDate"));
						sb.append("   ");
						sb.append(rec.getString("profileSj"));
						sb.append(System.getProperty("line.separator"));
					}
					else if ( StringUtils.equals(rec.getString("profileCd"), "P98") && StringUtils.equals(params.getString("profileCd"), "P98") ) {
						infoColTxt = "선거이력";
						sb.append(rec.getString("sgtypename"));
						sb.append("/");
						sb.append(rec.getString("sggname"));
						sb.append("/");
						sb.append(rec.getString("jdname"));
						sb.append("/");
						sb.append(rec.getString("dugyul"));
						sb.append(System.getProperty("line.separator"));
					}
					else if ( StringUtils.equals(rec.getString("profileCd"), "P99") && StringUtils.equals(params.getString("profileCd"), "P99") ) {
						infoColTxt = "SNS";
						sb.append(rec.getString("gubun"));
						sb.append(" : ");
						sb.append(rec.getString("url"));
						sb.append(System.getProperty("line.separator"));
					}
					
				}
				
				if ( sb.length() > 0 ) {
					row.createCell(lastColNum).setCellValue(sb.toString());
					row.getCell(lastColNum).setCellStyle(setDataStyle(workbook));
				}
				
				sheet.getRow(0).createCell(lastColNum).setCellValue(infoColTxt);
				sheet.getRow(0).getCell(lastColNum).setCellStyle(setHeadStyle(workbook));
				
			}
			
			
			// 글자 컬럼길이 자동정렬
			for(int colNum = 0; colNum<row.getLastCellNum();colNum++) {
				if ( StringUtils.equals(sheet.getRow(0).getCell(colNum).getStringCellValue(), "사진") ) {
					continue;
				}
				sheet.autoSizeColumn(colNum);
				sheet.setColumnWidth(colNum, sheet.getColumnWidth(colNum)+500);	// 컬럼 auto 사이즈 이후 추가로 500 늘려준다.
			}
			
			response.setHeader("Access-Control-Allow-Origin", "*");
			response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			response.setHeader("set-cookie", "fileDownload=true; path=/");
			
			// 다운로드 파일명
			StringBuffer fileNmBuff = new StringBuffer();
			fileNmBuff.append(StringUtils.defaultIfEmpty(infoColTxt, "data"));
			fileNmBuff.append(StringUtils.isBlank(params.getString("excelNm", "")) ? "" : "_");
			fileNmBuff.append(params.getString("excelNm", ""));
			fileNmBuff.append(EXCEL_FILE_EXT);
			
			//response.setHeader("Content-Disposition", Encodehelper.getDisposition(StringUtils.defaultIfEmpty(fileNmBuff.toString(), "data"+EXCEL_FILE_EXT), Encodehelper.getBrowser(request)));
			response.setHeader("Content-Disposition", Encodehelper.getDispositionCompatibility(request, StringUtils.defaultIfEmpty(fileNmBuff.toString(), "data"+EXCEL_FILE_EXT)));  
			out = response.getOutputStream();
			workbook.write(out);
		} catch (IOException ioe) {
			EgovWebUtil.exLogging(ioe);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
			response.setHeader("Set-Cookie", "fileDownload=false; path=/");
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
			response.setHeader("Content-Type","text/html; charset=utf-8");
			OutputStream catchOut = null;
			try {
				catchOut = response.getOutputStream();
				byte[] data = new String("fail..").getBytes();
				catchOut.write(data, 0, data.length);
			} catch (IOException ioe) {
				EgovWebUtil.exLogging(ioe);	
			} catch(Exception ee) {
				EgovWebUtil.exLogging(ee);
			} finally {
				if(out != null) try { out.close(); } 
			    catch (IOException ioe) {
				EgovWebUtil.exLogging(ioe);
			    }
				catch(Exception ee) {
					EgovWebUtil.exLogging(ee);  
				}
			}
		} finally {
			if ( workbook != null ) {
				try{
					((SXSSFWorkbook) workbook).dispose();
				} catch(Exception e){
					EgovWebUtil.exLogging(e);
				}
			}
			if ( out != null ) {
				try {
					out.close();
				} catch (UnsupportedEncodingException e) {
					EgovWebUtil.exLogging(e);
				} catch(Exception e) {
					EgovWebUtil.exLogging(e);
				}
			}
		}
	}
	
	/**
	 * 이미지 파일이 URL로 들어있는경우 이미지로 변환하여 엑셀에 입력
	 * @param workbook	엑셀
	 * @param sheet		시트
	 * @param strUrl	URL
	 * @param row		이미지가 삽입될 행
	 * @param col		이미지가 삽입될 열
	 */
	@SuppressWarnings("unused")
	private static void setCellUrlImage(SXSSFWorkbook workbook, SXSSFSheet sheet, String strUrl, int row, int col) {
		URL url = null;
		HttpURLConnection connection = null;
		ByteArrayOutputStream bos = null;
		BufferedImage img = null;
		BufferedImage resizedImage = null;
		
		try {
			url = new URL(strUrl);
			connection = (HttpURLConnection) url.openConnection();
			connection.setConnectTimeout(CONN_TIMEOUT_VALUE);
			connection.setReadTimeout(CONN_TIMEOUT_VALUE);
			
			if ( connection.getResponseCode() == HttpURLConnection.HTTP_OK ) {
				img = ImageIO.read(connection.getInputStream());
				
				// 이미지 리사이징
				MultiStepRescaleOp rescale = new MultiStepRescaleOp(120, 150);
				rescale.setUnsharpenMask(UnsharpenMask.Soft);
				resizedImage = rescale.filter(img, null);
				
				bos = new ByteArrayOutputStream();
				ImageIO.write(resizedImage, "jpg", bos );
				byte [] image = bos.toByteArray();
				
				int pictureIdx = workbook.addPicture(image, img.getType());
				
				CreationHelper helper = workbook.getCreationHelper();
				
				Drawing drawing = sheet.createDrawingPatriarch();
				
				ClientAnchor anchor = new XSSFClientAnchor();
				
				// 그림이 삽입될 셀의 꼭지점 마진
				anchor.setDx1(2 * XSSFShape.EMU_PER_PIXEL);
				anchor.setDx2(-2 * XSSFShape.EMU_PER_PIXEL);
				anchor.setDy1(2 * XSSFShape.EMU_PER_PIXEL);
				anchor.setDy2(-2 * XSSFShape.EMU_PER_PIXEL);
				
				// 삽입될 셀의 위치
				anchor.setRow1(row-1);
				anchor.setRow2(row);
				anchor.setCol1(col);
				anchor.setCol2(col+1);
				
				Picture pict = drawing.createPicture(anchor, pictureIdx);
//	        pict.resize();
			}
	        
		} catch (UnresolvedAddressException e) {
			EgovWebUtil.exLogging(e);
		} catch (Exception e) {
			EgovWebUtil.exLogging(e);
		} finally {
			if ( connection != null ) {
				connection.disconnect();
			}
			if ( img != null ) {
				img.flush();
			}
			if ( resizedImage != null ) {
				resizedImage.flush();
			}
			
			if ( bos != null ) {
				try {
					bos.close();
				} catch (UnsupportedEncodingException e) {
					EgovWebUtil.exLogging(e);
				} catch(Exception e) {
					EgovWebUtil.exLogging(e);
				}
			}
		}
	}
	
	/**
	 * 엑셀시트 셀의 데이터 기본스타일을 적용한다.
	 */
	private static CellStyle setDataStyle(SXSSFWorkbook workbook) { 
		CellStyle style = (CellStyle) workbook.createCellStyle();
		
		//폰트
		Font font = workbook.createFont();
		font.setFontName("Malgun Gothic");
		font.setBoldweight(Font.BOLDWEIGHT_NORMAL);
		font.setFontHeightInPoints((short) 10);

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
	 * 엑셀시트 셀의 헤더 기본스타일을 적용한다.
	 */
	private static CellStyle setHeadStyle(SXSSFWorkbook workbook) { 
		CellStyle style = (CellStyle) workbook.createCellStyle();
		
		//폰트
		Font font = workbook.createFont();
		font.setFontName("Malgun Gothic");
		font.setBoldweight(Font.BOLDWEIGHT_BOLD);
		font.setFontHeightInPoints((short) 10);
		//정렬	1
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		//배경색
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		style.setFont(font);
		//테두리 설정
	    style.setBorderTop(CellStyle.BORDER_THIN);
	    style.setBorderRight(CellStyle.BORDER_THIN);
	    style.setBorderBottom(CellStyle.BORDER_THIN);
	    style.setBorderLeft(CellStyle.BORDER_THIN);
	    
	    return style;
	}

}
