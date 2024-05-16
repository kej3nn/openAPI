<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 정책자료&보고서 - 의원저서             
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<h5>의원저서</h5>
<form id="amrForm" method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="PB" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		<table>
            <caption>검색</caption>
            <tbody>
            <tr>
                <th scope="row">
                   <label for="rptTit2">제목</label>
                </th>
                <td class="col3">
                  <input type="text" name="rptTit" id="rptTit2">
                </td>
            </tr>
            </tbody>
        </table>			
		
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" id="btnDownload">다운로드</a></li>
		</ul>
	</div>
	
	<div class="assemblyman_book" id="amr-result-sect">
		<!-- <div class="assemblyman_book_box">
			<div class="assemblyman_book_img">
				<img src="/images/img0200.png" alt="테스트이미지">
			</div>
			<div class="assemblyman_book_content">
				<dl>
					<dt>비망록 - 차마 말하지 못한 대선 패배의 진실</dt>
					<dd>저자 : 홍영표</dd>
					<dd>출판사 : 다산북스</dd>
					<dd>출판일 : 2013-01-01</dd>
				</dl>
				<span>비밍록 - 차마 말하지 못한 대선 패배의 진실</span>			
			</div>	
		</div>	 -->
	</div>	
	<div id="amr-pager-sect"></div>
</form>	
<%-- 	
<form method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	
	<div class="assemblyman_book">
		<div class="assemblyman_book_box">
			<div class="assemblyman_book_img">
				<img src="/images/img0200.png" alt="테스트이미지">
			</div>
			<div class="assemblyman_book_content">
				<dl>
					<dt>비망록 - 차마 말하지 못한 대선 패배의 진실</dt>
					<dd>저자 : 홍영표</dd>
					<dd>출판사 : 다산북스</dd>
					<dd>출판일 : 2013-01-01</dd>
				</dl>
				<span>비밍록 - 차마 말하지 못한 대선 패배의 진실</span>			
			</div>	
		</div>	
		<div class="assemblyman_book_box">
			<div class="assemblyman_book_img">
				<img src="/images/img0200.png" alt="테스트이미지">
			</div>
			<div class="assemblyman_book_content">
				<dl>
					<dt>비망록 - 차마 말하지 못한 대선 패배의 진실</dt>
					<dd>저자 : 홍영표</dd>
					<dd>출판사 : 다산북스</dd>
					<dd>출판일 : 2013-01-01</dd>
				</dl>
				<span>비밍록 - 차마 말하지 못한 대선 패배의 진실</span>			
			</div>	
		</div>	
	</div>
</form>  --%>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/pdta/combPdtaAssmMemReport.js" />"></script>