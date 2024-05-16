<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${iopen_chairman.totalCount > 0}">
		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${iopen_chairman.colDisplayName}(<span><fmt:formatNumber value="${iopen_chairman.totalCount}" pattern="#,###"/>건</span>)</div>
                       <fmt:parseNumber var="cnt" type="number" value="${iopen_chairman.totalCount }"  />
                       <c:if test="${fn:contains(vo.collection, 'ALL') &&  cnt >3  }">
                        <a href="javascript:doCollection('${iopen_chairman.colIndexName}' , 'iopenT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                    <div>
                     <c:forEach var="data" items="${iopen_chairman.srchList }">
                    	<div class="ysearch_assembly">
	                    	<div>
	                    		<img src="${ data.DEPT_IMG_URL}" alt="${ data.HG_NM}의원 사진">
	                    	</div>
	                    	<dl>
	                    		<dt>
								<a href="${data.TOPIC}" target="_blank">${ data.HG_NM}(${ data.POLY_NM})</a>
								</dt>
	                    		<dd>
	                    			<strong>지역구</strong>
	                    			<span>${ data.ORIG_NM}</span>
	                    		</dd>
	                    		<dd>
	                    			<strong>당선횟수</strong>
	                    			<span>${ data.REELE_GBN_NM}(${ data.UNITS})</span>
	                    		</dd>
	                    		<dd>
	                    			<strong>소속위원회</strong>
	                    			<span>${ data.CMITS}</span>
	                    		</dd>
	                    		<dd>
	                    			<strong>홈페이지</strong>
	                    			<a href="${ data.HOMEPAGE}">${ data.HOMEPAGE}</a>
	                    		</dd>
	                    		<dd>                    		
	                    			<strong>이메일</strong>
	                    			<span>${ data.E_MAIL}</span>
	                    		</dd>
	                    	</dl>
	                    </div>
          		 </c:forEach>
          		 </div>
         </section>
         </c:if>
