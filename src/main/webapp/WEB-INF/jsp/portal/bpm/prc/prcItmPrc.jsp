<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 본회의 안건처리 - 본회의 안건처리
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="itmPrcForm" method="post">
<h4 class="hide">본회의 정보</h4>
	<input type="hidden" name="page" value="${ param.page }" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="currentDate" value="10">
	<input type="hidden" name="gubunId" value="PB" title="구분코드">
	<input type="hidden" name="gubun" value="LAW" title="법구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	
	<div class="theme_select_box layout_auto active_top">
		<h4 class="blind">본회의 처리안건</h4>
		<table>
            <caption>본회의 처리안건 : 의안구분,심의결과,의결일자,의안명</caption>
            <tbody>
            <tr>
                <th scope="row">의안구분</th>
                <td colspan="3" class="col3" id="td-gubun-sect">
                	<input type="radio" id="billKindLaw" name="billKind" checked="checked" value="법률안">
                	<label for="billKindLaw">법률안</label>
                	<input type="radio" class="ml10" id="billKindBudget" name="billKind" value="예산안">
                	<label for="billKindBudget">예산안</label>
                	<input type="radio" class="ml10" id="billKindCls" name="billKind" value="결산">
                	<label for="billKindCls">결산</label>
                	<input type="radio" class="ml10" id="billKindEtc" name="billKind" value="기타">
                	<label for="billKindEtc">기타</label>
                </td>
            </tr>
            <tr>
                <th scope="row">심의결과</th>
                <td>
                	<select name="procResultCd" title="심의결과 선택">
                		<option value="">전체</option>
                		<c:forEach var="code" items="${codeProcResult }">
                		<option value="${code.code }">${code.name }</option>
                		</c:forEach>
                	</select>
                </td>
                <th scope="row">의결일자</th>
                <td>
	                <ul>
	                	<li>
			                <span class="ipt_calendar">
					  			<input type="text" id="frRgsProcDt" name="frRgsProcDt" title="시작날짜(입력예:YYYY-MM-DD)">
					  			<i>날짜입력 형식 : 2019-12-25</i>
					  		</span>
				  		</li>
				  		<li>
					  		<span class="ipt_calendar">
					  			<input type="text" id="toRgsProcDt" name="toRgsProcDt" title="종료날짜(입력예:YYYY-MM-DD)">
					  			<i>날짜입력 형식 : 2019-12-25</i>
					  		</span>
				  		</li>
				  	</ul>	
                </td>
            </tr>
            <tr>
                <th scope="row">의안명</th>
                <td colspan="3" class="col3"><input type="text" title="의안명" name="billName"></td>
            </tr>
            </tbody>
        </table>			
		
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" name="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" name="btnDownload">다운로드</a></li>
		</ul>
	</div>
	<div class="themeCscrollx hline" id="div-gubun-law">
		<h4 class="blind">본회의 처리안건</h4>
		<table>
		<caption>본회의처리안건:번호, 의안구분, 의안번호, 의안명, 제안자구분, 제안자, 소관위원회, 의결결과, 표결현황, 찬성, 반대, 기권, 제안일, 소관위 심사정보, 회부일, 상정일, 처리일, 법사위 체계자구심사정보, 회부일, 상정일, 처리일, 본회의, 상정일, 의결일, 정부이송일, 공포일자</caption>
		<colgroup>
		<col style="width:60px;">
		<col style="width:80px;">
		<col style="width:90px;">		
		</colgroup>
		<thead>
		  <tr>
		  	<th rowspan="2" scope="col" class="w1">번호</th>
		    <th rowspan="2" scope="col" class="w2">의안구분</th>
		    <th rowspan="2" scope="col" class="w3">의안번호</th>
		    <th rowspan="2" scope="col" class="w4">의안명</th>
		    <th rowspan="2" scope="col" class="w5">제안자구분</th>
		    <th rowspan="2" scope="col" class="w6">제안자</th>
		    <th rowspan="2" scope="col" class="w7">소관위원회</th>
		    <th rowspan="2" scope="col">의결결과</th>
		    <th colspan="3" scope="col">표결현황</th>
		    <th rowspan="2" scope="col">제안일</th>
		    <th colspan="3" scope="col">소관위 심사정보</th>
		    <th colspan="3" scope="col">법사위 체계자구심사정보</th>
		    <th colspan="2" scope="col">본회의</th>
		    <th rowspan="2" scope="col">정부이송일</th>
		    <th rowspan="2" scope="col">공포일자</th>
	      </tr>
		  <tr>
		    <th scope="col">찬성</th>
		    <th scope="col">반대</th>
		    <th scope="col">기권</th>
		    <th scope="col">회부일</th>
		    <th scope="col">상정일</th>
		    <th scope="col">처리일</th>
		    <th scope="col">회부일</th>
		    <th scope="col">상정일</th>
		    <th scope="col">처리일</th>
		    <th scope="col">상정일</th>
		    <th scope="col">의결일</th>
	      </tr>
		  </thead>
		  <tbody id="itmPrc-law-result-sect">
		  </tbody>
		</table>
	</div>
	<div class="themeCscrollx hline" id="div-gubun-bdg" style="display: none;">
		<table>
		<caption>공포일자, 의안번호, 의안명, 의결결과, 표결현황, 찬성, 반대, 기권, 예결위 심사정보, 회부일, 상정일, 처리일, 본회의 심의정보, 상정일, 의결일, 정부이송일</caption>
		<colgroup>
		<col style="">
		</colgroup>
		  <thead id="thead-gubun-budget">
		    <tr>
		      <th rowspan="2" scope="col">번호</th>
		      <th rowspan="2" scope="col">의안구분</th>
		      <th rowspan="2" scope="col">의안번호</th>
		      <th rowspan="2" scope="col">의안명</th>
		      <th rowspan="2" scope="col">의결결과</th>
		      <th colspan="3" scope="col">표결현황</th>
		      <th rowspan="2" scope="col">제안일</th>
		      <th colspan="3" scope="col">예결위 심사정보</th>
		      <th colspan="2" scope="col">본회의 심의정보</th>
		      <th rowspan="2" scope="col">정부이송일</th>
	        </tr>
		    <tr>
		      <th scope="col">찬성</th>
		      <th scope="col">반대</th>
		      <th scope="col">기권</th>
		      <th scope="col">회부일</th>
		      <th scope="col">상정일</th>
		      <th scope="col">처리일</th>
		      <th scope="col">상정일</th>
		      <th scope="col">의결일</th>
	        </tr>
	      </thead>
	      <tbody id="itmPrc-bdg-result-sect">
		  </tbody>
		</table>
	</div>
	<div id="itmPrc-law-pager-sect"></div>
	<div id="itmPrc-bdg-pager-sect" style="display: none;"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/bpm/prc/prcItmPrc.js" />"></script>