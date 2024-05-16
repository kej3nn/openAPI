<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
<%-- 통합 - 의원실 알림 - 기자회견             
<%-- 
<%-- @author JHKIM
<%-- @version 1.0 2019/10/22
<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --%>
	
<h5>기자회견</h5>
<form id="intvForm" method="post">
	<input type="hidden" name="page" value="${param.page}" title="페이지번호">
	<input type="hidden" name="rows" value="10" title="행번호">
	<input type="hidden" name="gubunId" value="NI" title="구분코드">
	<input type="hidden" name="excelNm" value="" title="엑셀다운로드 명">
	<div class="theme_select_box layout_autoMt20 active_top">
		 <table>
            <caption>제목</caption>
            <tbody>
            <tr>
            	<th scope="row">
                   <label for="pressBillName">대수</label>
                </th>
                <td>
                  <%@ include file="/WEB-INF/jsp/portal/assm/sect/assmUnitCombobox.jsp" %>
                </td>
                <th scope="row">
                   <label for="pressTitleV">제목</label>
                </th>
                <td>
                  <input type="text" name="titleV" id="pressTitleV">
                </td>
            </tr>
            </tbody>
        </table>	
		
		<ul>
			<li><a href="javascript:;" class="btn_inquiries" id="btnSch">조회</a></li>
			<li><a href="javascript:;" class="btn_filedown" id="btnDownload">영상목록 다운로드</a></li>
		</ul>
	</div>
	<div class="press_intreview" id="press-result-sect" >
	</div>
	<div id="intv-pager-sect"></div>
</form>
<script type="text/javascript" src="<c:url value="/js/portal/assm/comb/noti/combNotiPressIntv.js" />"></script> 