<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:parseNumber var="cnt" type="number" value="${iopen_menu.totalCount }"  />
 <c:if test="${(vo.collection == 'ALL' || vo.collection == 'iopen_menu' )&&  cnt > 0  }">
		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${iopen_menu.colDisplayName}(<span><fmt:formatNumber value="${iopen_menu.totalCount}" pattern="#,###"/>건</span>)</div>
                       <c:if test="${ cnt >3  }">
                        <a href="javascript:doCollection('${iopen_menu.colIndexName}' , 'iopenT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                     <c:forEach var="data" items="${iopen_menu.srchList }">
                    <article>
                       <%--  <div class="ysearch_result_01">${fn:replace( fn:replace( data.MENU_FULLNM, HS , HS_VAL) , HE , HE_VAL)}</div> --%>
                        <div class="ysearch_result_02">
                            <a href="${ data.MENU_URL}" target="_blank">${fn:replace( fn:replace( data.MENU_FULLNM, HS , HS_VAL) , HE , HE_VAL)}</a>
                        </div>
                    </article>
          		 </c:forEach>
         </section>
</c:if>