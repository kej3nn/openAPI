<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동 - 표결현황	                   
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/21
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<div id="div-vote-sect" style="display: none;">	
	<h4 class="hide">표결현황</h4>
	<form id="voteForm" method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호" >
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="AR" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
		<div class="vote">
			<ul>
				<li>
					<div>
						<strong>표결 건수</strong>
						<span id="voteTotalCnt"></span>
					</div>
				</li>
				<li class="box_agree">
					<div>
						<strong>찬성</strong>
						<span id="voteAgrCnt"></span>
					</div>
				</li>
				<li class="box_oppose">
					<div>
						<strong>반대</strong>
						<span id="voteDisCnt"></span>
					</div>
				</li>
				<li class="box_abstained">
					<div>
						<strong>기권</strong>
						<span id="voteAbsCnt"></span>
					</div>
				</li>
				<!-- <li class="box_absence">
					<div>
						<strong>불참</strong>
						<span id="voteNonAtanCnt"></span>
					</div>
				</li> -->
			</ul>
		</div>
		<div class="theme_select_box"> 
			<table>
				<caption>표결현황 : 대수, 본회의 처리결과, 의결일자, 표결정보, 의안명 등 정보제공</caption>
				<tbody>
				<tr>
					<th scope="row">
	                   <label for="voteBillName">대수</label>
	                </th>
	                <td>
	                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
	                </td>
	                <th scope="row">
				    	<label for="procResult">본회의 처리결과</label>
				    </th>
				    <td>
				    	<select name="procResult" id="procResult"></select>
				    </td>
				</tr>
				<tr>
				    <th scope="row">
				    	<label for="voteendDt">의결일자</label>
				    </th>
				    <td>
				    	<span class="ipt_calendar">
					    	<input type="text" name="voteendDt" id="voteendDt" title="의결일자" >
					    	<i>날짜입력 형식 : 2019-12-25</i>
					    </span>
				    </td>
				    <th scope="row">
				    	<label for="resultVoteCd">표결정보</label>
				    </th>
				    <td>
				     <select name="resultVoteCd" id="resultVoteCd"></select>
				    </td>
				</tr>
				<tr>
				    <th scope="row">
				    	<label for="billName">의안명</label>
				    </th>
				    <td colspan="3">
				  		<input type="text" name="billName" id="billName">
				    </td>
				</tr>
				</tbody>
			</table>
			<ul>
				<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
				<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
				<li><a href="javascript:;" class="btn_checkchart" id="btnChartsch">차트조회</a></li>
			</ul>
		</div>
		<div id="chartPieArea" style="display:none;">
			<div id="chartPieContainer"></div>
		</div>
		<div class="themeB mt10 layoutFx">
			<table>
			<caption>표결현황 : 연번, 대수, 의결일자, 의안명, 소관위원회, 표결정보, 표결결과 등 정보제공</caption>
			<colgroup>
			<col style="width:60px;">
			<col style="width:80px;">
			<col style="width:100px;">
			<col style="">
			<col style="width:160px;">
			<col style="width:80px;">
			<col style="width:90px;">
			</colgroup>
			<thead>
				<tr>
					<th scope="row">연번</th>
					<th scope="row">대수</th>
					<th scope="row">의결일자</th>
					<th scope="row">의안명</th>
					<th scope="row">소관위원회</th>
					<th scope="row">표결정보</th>
					<th scope="row">표결결과</th>
				</tr>
			</thead>
			<tbody id="vote-list-sect">
			</tbody>
			</table>
			<div id="vote-pager-sect"></div>
		</div>	
	</form>
</div>
<script type="text/javascript" src="<c:url value="/js/portal/assm/lawm/lawmVoteCond.js" />"></script>