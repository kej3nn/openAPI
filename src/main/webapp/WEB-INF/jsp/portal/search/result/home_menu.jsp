<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<section class="ysearch_section">
                    <div class="ysearch_result_tit">
                        <div class="ysearch_result_tit_txt">${home_menu.colDisplayName}(<span><fmt:formatNumber value="${home_menu.totalCount}" pattern="#,###"/>건</span>)</div>
                        <fmt:parseNumber var="cnt" type="number" value="${home_menu.totalCount }"  />
                       <c:if test="${fn:contains(vo.collection, 'ALLA') &&  cnt >3  }">   
                   			<a href="javascript:doCollection('${home_menu.colIndexName}' , 'assemT')">더보기 <span>+</span></a>
                       </c:if>
                    </div>
                     <c:forEach var="data" items="${home_menu.srchList }">
                    <article>
                        <div class="ysearch_result_01"> ${fn:replace( fn:replace( data.MENU_FULL_LOCATION, HS , HS_VAL) , HE , HE_VAL)}
                        </div>
                        
                        <div class="ysearch_result_02">
                            <a href="http://www.assembly.go.kr/${ data.URL}" target="_blank">${fn:replace( fn:replace( data.STITLE, HS , HS_VAL) , HE , HE_VAL)}</a>
                           	<span class="ysearch_result_02_date"></span>
                        </div>
                        <a href="http://www.assembly.go.kr/${ data.URL}"   target="_blank" class="ysearch_result_03">
                       	 ${fn:replace( fn:replace(data.CONTENT , HS , HS_VAL) , HE , HE_VAL)}
                        </a>
                      
                    </article>
          		 </c:forEach>
         </section>
