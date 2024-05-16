<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="url"  value="http://petitions.assembly.go.kr/"  />
<c:set var="url2"  value="/"  />
		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${petit.colDisplayName}(<span><fmt:formatNumber value="${petit.totalCount}" pattern="#,###"/>건</span>)</div>
                       <c:if test="${fn:contains(vo.collection, 'ALL') }">   
                        <a href="javascript:doCollection('${petit.colIndexName}' , 'petitTab')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                 <c:forEach var="data" items="${petit.srchList }">
                    <article>
                     <c:if test="${data.RESULT_CODE == '' && data.STTUS_CODE =='AGRE_PROGRS' }">
                    	<c:set var="url2"  value="status/onGoing/"/>
                    </c:if>
                    <c:if test="${data.RESULT_CODE == ''&& data.STTUS_CODE =='PETIT_FORMATN' }">
                    	<c:set var="url2"  value="closed/waitingRefer/"/>
                    </c:if>
                    <c:if test="${data.RESULT_CODE == 'PETIT_INADQT' && data.STTUS_CODE =='PETIT_END' }">
                    	<c:set var="url2"  value="closed/inadequate/"/>
                    </c:if>
                     <c:if test="${data.STTUS_CODE == 'CMIT_FRWRD' && data.RESULT_CODE =='CMIT_JDGING' }">
                    	<c:set var="url2"  value="referred/pending/"/>
                    </c:if>
                     <c:if test="${data.STTUS_CODE == 'CMIT_FRWRD' && data.RESULT_CODE !='CMIT_JDGING' }">
                    	<c:set var="url2"  value="referred/done/"/>
                    </c:if>
                        <div class="ysearch_result_01"> ${data.PETIT_REALM_NM } </div>
                        <div class="ysearch_result_02">
                            <a href="${ url}${ url2}${ data.PETIT_ID}" target="_blank">${fn:replace( fn:replace(data.PETIT_SJ , HS , HS_VAL) , HE , HE_VAL)}</a>
                            <span class="ysearch_result_02_date"> (${data.RDATE })</span>
                        </div>
                        <a href="${ url}${ url2}${ data.PETIT_ID}" target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.PETIT_CN , HS , HS_VAL) , HE , HE_VAL)}
                        </a>
                    </article>
          		 </c:forEach>
         </section>
