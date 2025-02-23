<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="com.ibleaders.ibsheet7.ibsheet.text.Down2Text" %>
<%
	Down2Text ibText = new Down2Text(request, response);

	//====================================================================================================
	// [ 사용자 환경 설정 #1 ]
	//====================================================================================================
	// Html 페이지의 엔코딩이 utf-8 로 구성되어 있으면 "ibText.setPageEncoding("utf-8");" 로 설정하십시오.
	// 엑셀 문서의 한글이 깨지면 이 값을 공백("")으로 바꿔 보십시오.
	// LoadExcel.jsp 도 동일한 값으로 바꿔 주십시오.
	//====================================================================================================
	ibText.setPageEncoding("utf-8");

	//====================================================================================================
	// [ 사용자 환경 설정 #2 ]
	//====================================================================================================
	// 트리 컬럼에서 레벨별로 … 를 덧붙여서 레벨별로 보기 좋게 만듭니다.
	// 만약 … 대신 다른 문자를 사용하기를 원하시면 아래 유니코드 \u2026 (16진수형태) 대신 다른 문자를 입력하십시오.
	// 트리 컬럼이 없으면 설정하지 마세요.
	//====================================================================================================
	//ibText.setTreeChar("\u2026");

	try {

		ibText.down2Text();

	} catch (IOException e) {
		out.println("<script>try{var targetWnd = null; if(opener!=null) {targetWnd = opener;} else {targetWnd = parent;} targetWnd.Grids[targetWnd.gTargetExcelSheetID].finishDownload(); targetWnd.Grids[targetWnd.gTargetExcelSheetID].ShowAlert('PDF 다운로드중 에러가 발생하였습니다.', 'U');}catch(e){}</script>");
	} catch (Exception e) {
		out.println("<script>try{var targetWnd = null; if(opener!=null) {targetWnd = opener;} else {targetWnd = parent;} targetWnd.Grids[targetWnd.gTargetExcelSheetID].finishDownload(); targetWnd.Grids[targetWnd.gTargetExcelSheetID].ShowAlert('PDF 다운로드중 에러가 발생하였습니다.', 'U');}catch(e){}</script>");
	} catch (Error e) {
		out.println("<script>alert('텍스트 다운로드중 에러가 발생하였습니다.'); history.back();</script>");

	}

%>