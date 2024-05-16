<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${iopen_name.colDisplayName}(<span><fmt:formatNumber value="${iopen_name.totalCount}" pattern="#,###"/>건</span>)</div>
                       <fmt:parseNumber var="cnt" type="number" value="${iopen_name.totalCount }"  />
                       <c:if test="${fn:contains(vo.collection, 'ALL') &&  cnt >3  }">
                        <a href="javascript:doCollection('${iopen_name.colIndexName}' , 'iopenT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                    <div class="ysearch_result_desc">열린국회정보 명칭, 태그, 항목명과 일치하는 검색결과를 조회하실수 있습니다.</div>
                     <c:forEach var="data" items="${iopen_name.srchList }">
                    <article>
                        <div class="ysearch_result_01"> ${fn:replace( fn:replace( data.INF_PATH, HS , HS_VAL) , HE , HE_VAL)}</div>
                        <div class="ysearch_result_02">
                            <a href="${ data.INF_URL}" target="_blank">${fn:replace( fn:replace( data.INF_TIT, HS , HS_VAL) , HE , HE_VAL)}</a>
                           	<%--<span class="ysearch_result_02_date"> (${empty data.LOAD_DTTM ? data.OPEN_YMD :data.LOAD_DTTM})</span>--%>
                            <c:if test="${not empty data.LOAD_DTTM}"><span class="ysearch_result_02_date"> (${data.LOAD_DTTM })</span></c:if>
                        </div>
                        <a href="${ data.INF_URL}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.INF_CONT , HS , HS_VAL) , HE , HE_VAL)}
                       	 </br>
                       	  <c:if test="${data.COLS !=''}">
                       	  ${fn:replace( fn:replace(data.COLS , HS , HS_VAL) , HE , HE_VAL)}
                       	 </c:if>
                       	 </a>
                       	 <c:if test="${data.SCHW_TAG_CONT !=''}">
                       	 	<c:set var="tagS" value="${fn:split(data.SCHW_TAG_CONT,',')}"/>
                       	 	 <div class="ysearch_result_01">
                       	 	 	<c:forEach var="tagL" items="${tagS }" varStatus="l">
                       	 	 		 <a href="javascript:doTagSearch('${fn:replace( fn:replace(tagL, HS , '') , HE , '')}')" >#${fn:replace( fn:replace(tagL, HS , HS_VAL) , HE , HE_VAL)}</a>
                       	 	 	</c:forEach>
	                       	  </div>
                       	 </c:if>
                      		
                    </article>
          		 </c:forEach>
         </section>
