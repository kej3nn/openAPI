<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${iopen_compass.colDisplayName}(<span><fmt:formatNumber value="${iopen_compass.totalCount}" pattern="#,###"/>건</span>)</div>
                       <fmt:parseNumber var="cnt" type="number" value="${iopen_compass.totalCount }"  />
                       <c:if test="${fn:contains(vo.collection, 'ALL') &&  cnt >3  }">
                        <a href="javascript:doCollection('${iopen_compass.colIndexName}' , 'iopenT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                     <c:forEach var="data" items="${iopen_compass.srchList }">
                    <article>
                        <div class="ysearch_result_01">${fn:replace( fn:replace( data.CATE_FULLNM, HS , HS_VAL) , HE , HE_VAL)}</div>
                        <div class="ysearch_result_02">
                            <a href="${ data.SRC_URL}" target="_blank">${fn:replace( fn:replace( data.INFO_NM, HS , HS_VAL) , HE , HE_VAL)}</a>
                        </div>
                        <a href="${ data.SRC_URL}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.INFO_SRC_EXP , HS , HS_VAL) , HE , HE_VAL)}
                        </a>
                    </article>
          		 </c:forEach>
         </section>
