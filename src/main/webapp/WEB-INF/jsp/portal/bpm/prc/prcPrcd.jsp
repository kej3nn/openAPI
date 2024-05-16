<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 의정활동별 공개 - 본회의 안건처리 - 본회의 회의록
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/11/05
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<form id="prcdForm" method="post">
<h4 class="hide">본회의 회의록</h4>
	<input type="hidden" name="page" value="${ param.page }"  title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="PC" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	
	<div class="theme_select_box layout_auto active_top">
		<h4 class="blind">본회의 회의록</h4>
		<table>
            <caption>본회의회의록:대수, 일자, 회의명, 안건명</caption>
            <tbody>
            <tr>
                <th scope="row">대수</th>
                <td>
                	<input type="text" title="대수" name="unitCd" value="">
                	<%-- <input type="hidden" name="unitCd" value="${unitCd }" title="대수"> --%>
                </td>
                <th scope="row">일자</th>
                 <td>
	                <ul>
	                	<li>
			                <span class="ipt_calendar">
					  			<input type="text" id="frConfDate" name="frConfDate" title="시작날짜(입력예:YYYY-MM-DD)">
					  			<i>날짜입력 형식 : 2019-12-25</i>
					  		</span>
				  		</li>
				  		<li>
					  		<span class="ipt_calendar">
					  			<input type="text" id="toConfDate" name="toConfDate" title="종료날짜(입력예:YYYY-MM-DD)">
					  			<i>날짜입력 형식 : 2019-12-25</i>
					  		</span>
				  		</li>
				  	</ul>	
                </td>
            </tr>
            <tr>
                <th scope="row">회의명</th>
                <td>
					<input type="text" id="title" name="title" title="회의명">
                </td>
                <th scope="row">안건명</th>
                <td><input type="text" id="subName" name="subName" title="안건명"></td>
            </tr>
           
            </tbody>
        </table>		
		
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" name="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" name="btnDownload">다운로드</a></li>
		</ul>
	</div>
	<div class="themeBscrollx">
		<h4 class="blind">본회의 회의록</h4>
		<table>
		<caption>본회의 회의록:번호, 대수, 회의날짜, 회의명, 안건명, 회의록영상, 회의록</caption>
		<colgroup>
		<col style="">
		</colgroup>
		<thead>
			<tr>
				<th scope="row">번호</th>
				<th scope="row">대수</th>
				<th scope="row">회의날짜</th>
				<th scope="row">회의명</th>
				<th scope="row">안건명</th>
				<th scope="row">회의록영상</th>
				<th scope="row">회의록</th>
			</tr>
		</thead>
		<tbody id="prcd-result-sect">
			<!-- <tr>
				<td>2019-09-30</td>
				<td>제20대국회 제371회 제5차 국회본회의(2019년 10월 01일)</td>
				<td>교육사회문화에관한 질문(계속)</td>
				<td><a href="#"><img src="/images/icon_hwp.png" alt="HWP"></a></td>
				<td><a href="#"><img src="/images/btn_movie.png" alt="영상보기"></a></td>
				<td><a href="#" class="assm_view">요약정보</a></td>
			</tr> -->
		</tbody>
		</table>
	</div>
	<div id="prcd-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/bpm/prc/prcPrcd.js" />"></script>